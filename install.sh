#!/bin/bash

# Setează variabilele
PROJECT_DIR="/home/mihai/uppy"
VENV_DIR="$PROJECT_DIR/venv"
BIN_DIR="$VENV_DIR/bin"
SCRIPT_DIR="$PROJECT_DIR"

# Funcția pentru instalare
install_uppy() {
    # Creează și activează un mediu virtual
    python3 -m venv $VENV_DIR
    source $VENV_DIR/bin/activate

    # Creează fișierele necesare

    # Fișierul process_manager.py
    cat <<EOL > $SCRIPT_DIR/process_manager.py
import subprocess
import os
import json
from datetime import datetime

class ProcessManager:
    def __init__(self, data_file='processes.json'):
        self.data_file = data_file
        self.processes = self.load_processes()
        self.next_id = max(map(int, self.processes.keys()), default=0) + 1

    def load_processes(self):
        if os.path.exists(self.data_file):
            with open(self.data_file, 'r') as f:
                return json.load(f)
        return {}

    def save_processes(self):
        processes_to_save = {}
        for id, proc in self.processes.items():
            processes_to_save[id] = {
                'name': proc['name'],
                'command': proc['command'],
                'restarts': proc['restarts'],
                'start_time': proc['start_time']
            }
        with open(self.data_file, 'w') as f:
            json.dump(processes_to_save, f, indent=4)

    def start_process(self, file_name, name):
        id = str(self.next_id)
        self.next_id += 1

        command = f"python {file_name}"
        process = subprocess.Popen(command, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        self.processes[id] = {
            'name': name,
            'command': command,
            'process': process,
            'restarts': 0,
            'start_time': datetime.now().timestamp()
        }
        self.save_processes()
        print(f"Started process {id} with PID {process.pid}")

    def stop_process(self, id):
        if id not in self.processes:
            print(f"No such process {id}.")
            return

        process = self.processes[id].get('process')
        if process:
            process.terminate()
            print(f"Stopped process {id}")
        del self.processes[id]
        self.save_processes()

    def list_processes(self):
        print(f"{'ID':<10} {'Name':<20} {'Command':<30} {'Restarts':<10} {'Uptime':<20} {'Status':<10}")
        for id, proc in self.processes.items():
            uptime = datetime.now() - datetime.fromtimestamp(proc.get('start_time', datetime.now().timestamp()))
            uptime_str = f"{uptime.days}d {uptime.seconds // 3600}h {uptime.seconds % 3600 // 60}m"
            status = "Running" if proc.get('process') and proc['process'].poll() is None else "Stopped"
            print(f"{id:<10} {proc['name']:<20} {proc['command']:<30} {proc['restarts']:<10} {uptime_str:<20} {status:<10}")

    def sys_boot(self):
        service_file_content = (
            f"[Unit]\n"
            f"Description=Uppy Process Manager\n\n"
            f"[Service]\n"
            f"ExecStart=/usr/bin/python3 {os.path.abspath(__file__)}\n"
            f"Restart=always\n\n"
            f"[Install]\n"
            f"WantedBy=multi-user.target\n"
        )
        with open('/etc/systemd/system/uppy.service', 'w') as f:
            f.write(service_file_content)
        subprocess.run(['systemctl', 'enable', 'uppy.service'])
        print("Service enabled for boot")

    def sys_unboot(self):
        subprocess.run(['systemctl', 'disable', 'uppy.service'])
        os.remove('/etc/systemd/system/uppy.service')
        print("Service disabled from boot")

    def logs(self, id):
        if id in self.processes:
            process = self.processes[id].get('process')
            if process:
                stdout, stderr = process.communicate()
                print(f"Logs for process {id}:")
                print(stdout.decode())
                print(stderr.decode())
            else:
                print(f"No active process found for ID {id}")
        else:
            print(f"No such process {id}")
EOL

    # Fișierul uppy_cli.py
    cat <<EOL > $SCRIPT_DIR/uppy_cli.py
import argparse
from process_manager import ProcessManager

def main():
    parser = argparse.ArgumentParser(description='Uppy Process Manager')
    parser.add_argument('command', choices=['start', 'stop', 'list', 'sys-boot', 'sys-unboot', 'logs', 'monit'])
    parser.add_argument('id', nargs='?', help='ID of the process')
    parser.add_argument('--name', help='Name of the process')
    parser.add_argument('--command', help='Command to run for the process')

    args = parser.parse_args()
    manager = ProcessManager()

    if args.command == 'start':
        if args.command and args.name:
            manager.start_process(args.command, args.name)
        else:
            print("Error: --command and --name are required for start.")
    elif args.command == 'stop':
        if args.id:
            manager.stop_process(args.id)
        else:
            print("Error: id is required for stop.")
    elif args.command == 'list':
        manager.list_processes()
    elif args.command == 'sys-boot':
        manager.sys_boot()
    elif args.command == 'sys-unboot':
        manager.sys_unboot()
    elif args.command == 'logs':
        if args.id:
            manager.logs(args.id)
        else:
            print("Error: id is required for logs.")
    elif args.command == 'monit':
        print("Monitoring is not yet implemented.")
    else:
        print("Error: Unknown command")

if __name__ == "__main__":
    main()
EOL

    # Fișierul uppy.py
    cat <<EOL > $SCRIPT_DIR/uppy.py
from uppy_cli import main

if __name__ == "__main__":
    main()
EOL

    # Fișierul setup.py
    cat <<EOL > $SCRIPT_DIR/setup.py
from setuptools import setup

setup(
    name='uppy',
    version='0.1',
    py_modules=['uppy', 'process_manager', 'uppy_cli'],
    install_requires=[],
    entry_points={
        'console_scripts': [
            'uppy=uppy:main',
        ],
    },
    classifiers=[
        'Programming Language :: Python :: 3',
        'License :: OSI Approved :: MIT License',
        'Operating System :: OS Independent :: Ubuntu',
    ],
    python_requires='>=3.6',
)
EOL

    # Instalează pachetul
    pip install --upgrade $SCRIPT_DIR

    # Verifică dacă comanda 'uppy' este disponibilă
    if command -v uppy > /dev/null; then
        echo "Uppy a fost instalat cu succes!"
    else
        echo "Eroare: Uppy nu a fost instalat corect."
    fi

    # Testează comanda 'uppy'
    uppy --help
}

# Funcția pentru eliminare
remove_uppy() {
    echo "Șterge tot ce ține de Uppy și mediu virtual..."

    # Dezactivează și șterge mediu virtual
    if [ -d "$VENV_DIR" ]; then
        rm -rf $VENV_DIR
        echo "Mediu virtual șters."
    fi

    # Șterge fișierele și pachetele Uppy
    if [ -f "$SCRIPT_DIR/setup.py" ]; then
        pip uninstall -y uppy
        echo "Pachetul Uppy dezinstalat."
    fi

    # Șterge fișierele de proiect
    if [ -d "$PROJECT_DIR" ]; then
        rm -rf $PROJECT_DIR
        echo "Fișierele Uppy șterse."
    fi

    # Șterge serviciul systemd, dacă există
    if [ -f "/etc/systemd/system/uppy.service" ]; then
        systemctl stop uppy.service
        systemctl disable uppy.service
        rm /etc/systemd/system/uppy.service
        echo "Serviciul systemd Uppy șters."
    fi

    echo "Toate componentele Uppy au fost șterse."
}

# Verifică argumentele
if [ "$1" == "--danger_remove" ]; then
    remove_uppy
else
    install_uppy
fi

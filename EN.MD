# Uppy - Manager de Procese 🚀

Uppy este un manager de procese simplu, inspirat de PM2, care îți permite să pornești, oprești și gestionezi procese în Python. Uppy este util pentru a rula și monitoriza aplicații Python într-un mod similar cu PM2.

## Funcționalități 🎯

- **Start**: Începe un nou proces
- **Stop**: Oprește un proces existent
- **List**: Listează procesele curente
- **Sys-Boot**: Configurează Uppy să pornească automat la boot
- **Sys-Unboot**: Dezactivează Uppy la boot
- **Logs**: Afișează log-urile unui proces
- **Monit**: (În dezvoltare) Monitorizează procesele

## Instalare 🛠️

1. Clonează repository-ul:

    git clone https://github.com/username/repository.git
    cd repository

2. Rulează scriptul de instalare:

    ./install.sh

   Acest script va crea un mediu virtual, va instala dependențele necesare și va configura comanda `uppy`.

## Comenzi 🚦

### `uppy start {file-name}.{extension} --name {name}`

Pornește un nou proces cu numele specificat și comandă. De exemplu:

    uppy start 1.py --name "My Script"

### `uppy stop {id}`

Oprește procesul cu ID-ul specificat. De exemplu:

    uppy stop 1

### `uppy list`

Listează toate procesele curente cu detalii precum ID, nume, comandă, număr de reporniri, uptime și status. De exemplu:

    uppy list

### `uppy sys-boot`

Configurează Uppy să pornească automat la boot. De exemplu:

    uppy sys-boot

### `uppy sys-unboot`

Dezactivează Uppy la boot. De exemplu:

    uppy sys-unboot

### `uppy logs {id}`

Afișează log-urile pentru procesul cu ID-ul specificat. De exemplu:

    uppy logs 1

### `uppy monit`

(În dezvoltare) Afișează statistici de monitorizare. De exemplu:

    uppy monit

### `./install.sh --danger_remove`

Șterge complet Uppy, inclusiv mediu virtual și fișiere asociate. **Folosește cu grijă!** De exemplu:

    ./install.sh --danger_remove

## Probleme și Contribuții 🛠️

Dacă întâlnești probleme sau dorești să contribui, deschide o problemă sau un pull request pe [GitHub](https://github.com/username/repository).

## Licență 📄

Distribuit sub licența MIT. Vezi `LICENSE` pentru mai multe informații.

---

**Uppy** - Simplifică gestionarea proceselor Python! 🚀

---

# Uppy - Process Manager 🚀

Uppy is a simple process manager inspired by PM2, allowing you to start, stop, and manage processes in Python. Uppy is useful for running and monitoring Python applications in a way similar to PM2.

## Features 🎯

- **Start**: Start a new process
- **Stop**: Stop an existing process
- **List**: List current processes
- **Sys-Boot**: Configure Uppy to start automatically at boot
- **Sys-Unboot**: Disable Uppy at boot
- **Logs**: Display logs of a process
- **Monit**: (Under development) Monitor processes

## Installation 🛠️

1. Clone the repository:

    git clone https://github.com/username/repository.git
    cd repository

2. Run the installation script:

    ./install.sh

   This script will create a virtual environment, install the necessary dependencies, and set up the `uppy` command.

## Commands 🚦

### `uppy start {file-name}.{extension} --name {name}`

Starts a new process with the specified name and command. For example:

    uppy start 1.py --name "My Script"

### `uppy stop {id}`

Stops the process with the specified ID. For example:

    uppy stop 1

### `uppy list`

Lists all current processes with details such as ID, name, command, number of restarts, uptime, and status. For example:

    uppy list

### `uppy sys-boot`

Configures Uppy to start automatically at boot. For example:

    uppy sys-boot

### `uppy sys-unboot`

Disables Uppy at boot. For example:

    uppy sys-unboot

### `uppy logs {id}`

Displays logs for the process with the specified ID. For example:

    uppy logs 1

### `uppy monit`

(Under development) Displays monitoring statistics. For example:

    uppy monit

### `./install.sh --danger_remove`

Completely removes Uppy, including the virtual environment and associated files. **Use with caution!** For example:

    ./install.sh --danger_remove

## Issues and Contributions 🛠️

If you encounter issues or want to contribute, open an issue or a pull request on [GitHub](https://github.com/username/repository).

## License 📄

Distributed under the MIT License. See `LICENSE` for more details.

---

**Uppy** - Simplify Python process management! 🚀

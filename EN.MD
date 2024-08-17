# Uppy - Process Manager 🚀

Uppy is a simple process manager inspired by PM2, allowing you to start, stop, and manage processes in Python. Uppy is useful for running and monitoring Python applications in a manner similar to PM2.

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
    cd uppy

2. Run the installation script:

    setup.sh

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

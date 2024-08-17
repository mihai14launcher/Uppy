# Uppy - Process Manager 🚀

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

1. **Clonează repository-ul**:

    ```bash
    git clone https://github.com/mihai14launcher/uppy.git
    cd uppy
    ```

2. **Rulează scriptul de instalare**:

    ```bash
    ./install.sh
    ```

   Acest script va crea un mediu virtual, va instala dependențele necesare și va configura comanda `uppy`.

## Comenzi 🚦

### `uppy start {file-name}.{extension} --name {name}`
### Example `uppy start example-file.sh --name Example
Pornește un nou proces cu numele specificat și comandă. De exemplu:

```bash
uppy start 1.py --name "My Script"

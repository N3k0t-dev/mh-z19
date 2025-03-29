#!/bin/bash

sudo apt-get update #aggiunto per aggiornare i pacchetti
sudo apt-get install python3-pip git
sudo pip3 install mh_z19 pondslider incremental_counter error_counter #rimosso --break-system-packages

if [ $(cat /etc/debian_version | cut -d '.' -f 1) -lt 11 ]; then
  sudo apt-get install python-pip
  sudo pip install mh_z19 pondslider incremental_counter error_counter
fi

if [ -d "handlers" ]; then
    echo "La cartella handlers esiste già. Rimuoverla o rinominarla prima di continuare."
else
    git clone https://github.com/UedaTakeyuki/handlers
fi

if [ -f "send2monitor.py" ]; then
    echo "Il collegamento send2monitor.py esiste già. Rimuoverlo se necessario."
else
    ln -s handlers/value/sender/send2monitor/send2monitor.py
fi

sudo sed -i "s/^enable_uart=.*/enable_uart=1/" /boot/config.txt

read -p "Would you like to reboot now?  (y/n) :" YN
if [ "${YN}" = "y" ]; then
  sudo reboot
else
  exit 1
fi

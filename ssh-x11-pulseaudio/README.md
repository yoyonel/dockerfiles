# SSH X11 PulseAudio

Docker pour construire une image faisant tourner un serveur SSH forwardant audio/video X11+PulseAudio (cote host).

Contient:

* openssh-server (dernière version disponible via apt-get (*))
* pulseaudio (*)

## ChucK + SSH connnection for X11 & PulseAudio

1. ```sh generate_and_add_ssh_key.sh```
	- génère une clée SSH utilisable par le container
	- update des authorisations SSH
2. ```sh build.sh```
	- construit l'image en utilisant la clée SSH générée en 1.

### Optionnel:
- ```sh start_ssh_server.sh```
	- lance un container sur cette image.
	- ca fait tourner un server SSH permettant des flux audio/video
- ```sh run.sh```
	- se connecte au serveur SSH et lance l'éditeur miniAudicle
- ```sh stop_ssh_server.sh``` (at the end)
	- va arrêter le serveur ssh (i.e. stop le container SSH server)
- ```sh run_bash.sh```
	- permet de lancer un bash sur le container faisant tourner le serveur SSH
- ```sh reset_pulse_audio.sh```
	- permet de reset le serveur pulseaudio de l'host (peut être utile

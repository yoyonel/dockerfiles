# ChucK + miniAudicle

Docker pour construire une image faisant tourner ChucK+miniAudicle (IDE) via une connection SSH avec un serveur X11+PulseAudio (cote host).

Contient:

* Chuck audio engine: 1.3.5.2 -> [site web](http://chuck.cs.princeton.edu/)
* miniAudicle (IDE): 1.3.3 -> [site web](http://audicle.cs.princeton.edu/mini/)
* openssh-server (dernière version disponible via apt-get (*))
* pulseaudio (*)

## ChucK + SSH connnection for X11 & PulseAudio

1. ```sh generate_and_add_ssh_key.sh```
	- génère une clée SSH utilisable par le container
	- update des authorisations SSH
2. ```sh build.sh```
	- construit l'image en utilisant la clée SSH générée en 1.
3. ```sh start_ssh_server.sh```
	- lance un container sur cette image.
	- ca fait tourner un server SSH permettant des flux audio/video
4. ```sh run.sh```
	- se connecte au serveur SSH et lance l'éditeur miniAudicle
5. ```sh stop_ssh_server.sh``` (at the end)
	- va arrêter le serveur ssh (i.e. stop le container SSH server)

### Optionnel:
- ```sh run_bash.sh```
	- permet de lancer un bash sur le container faisant tourner le serveur SSH
- ```sh reset_pulse_audio.sh```
	- permet de reset le serveur pulseaudio de l'host (peut être utile

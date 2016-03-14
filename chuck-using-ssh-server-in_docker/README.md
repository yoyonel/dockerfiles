# ChucK + miniAudicle

Docker pour construire une image faisant tourner ChucK+miniAudicle (IDE) via une connection SSH avec un serveur X11+PulseAudio (cote host).

Contient:

* Chuck audio engine: 1.3.5.2 -> [site web](http://chuck.cs.princeton.edu/)
* miniAudicle (IDE): 1.3.3 -> [site web](http://audicle.cs.princeton.edu/mini/)

Requirements:
* yoyo/docker-ssh image

## ChucK + SSH connnection for X11 & PulseAudio

1. ```sh build.sh```
	- lance la construction de l'image compilant et installant ChucK + miniAudicle
	- Récupère (par héritage d'image) un serveur SSH pour forwarder des flux audio/video (pulseaudio/x11)
2. ```sh start_ssh_server.sh```
	- Lance le serveur SSH de l'image yoyo/docker-ssh héritée
3. ```sh run.sh```
	- se connecte au serveur SSH et lance l'éditeur miniAudicle
	```bash
		ssh docker_ssh chuck-pulseaudio-forward
	```
	Le run est intéressant:
		- on utilise l'accès SSH de l'image héritée (yoyo/docker-ssh)
		- on utilise le wrapper `chuck-pulseaudio-forward` construit dans cette image pour lancer l'application
4. ```sh stop_ssh_server.sh``` (at the end)
	- va arrêter le serveur ssh (i.e. stop le container SSH server)

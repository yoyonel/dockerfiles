# ChucK + SSH connnection for X11 & PulseAudio
#
# 1. sh generate_and_add_ssh_key.sh
#	-> génère une clée SSH utilisable par le container
#	-> update des authorisations SSH
# 2. sh build.sh
#	-> construit l'image en utilisant la clée SSH générée en 1.
# 3. sh start_ssh_server.sh
#	-> lance un container sur cette image.
#	-> ca fait tourner un server SSH permettant des flux audio/video
# 4. sh run.sh
#	-> se connecte au serveur SSH et lance l'éditeur miniAudicle
# 5. (at the end) sh stop_ssh_server.sh
#	-> va arrêter le serveur ssh (stop le container faisant tourner le serveur SSH)
# (optionnals: 
#	sh run_bash.sh
#	-> permet de lancer un bash sur le container faisant tourner le serveur SSH
#	sh reset_pulse_audio.sh
#	-> permet de reset le serveur pulseaudio de l'host (peut être utile)
# )
#
# version SSH pulse-audio
# utile (indispensable) à l'IGN
FROM ignf/ubuntu
# utilisation d'une image ubuntu, faudrait tester une debian directement
# FROM ubuntu:latest
#
MAINTAINER Lionel ATTY <lionel.atty@gmail.com>

#
RUN apt-get -y update &&\
	apt-get -y upgrade &&\
	apt-get -y install software-properties-common

##################################################
# Partie serveur SSH forward X11+PulseAudio
##################################################
# Install OpenSSH
RUN apt-get install -y openssh-server

# Create OpenSSH privilege separation directory
RUN mkdir /var/run/sshd

# Install Pulseaudio
RUN apt-get install -y pulseaudio

# Add the docker user
RUN adduser --disabled-password --gecos "Docker User" --uid 5001 docker_ssh

# Add SSH public key for the chuck user
RUN mkdir /home/docker_ssh/.ssh
ADD id_rsa.pub /home/docker_ssh/.ssh/authorized_keys
RUN chown -R docker_ssh:docker_ssh /home/docker_ssh/.ssh

##################################################
# Mise en place d'un wrapper pour activer le forward
##################################################
# Set up the launch wrapper
RUN echo 'export PULSE_SERVER="tcp:localhost:64713"' >> /usr/local/bin/program-pulseaudio-forward
#RUN echo 'miniAudicle' >> /usr/local/bin/chuck-pulseaudio-forward
RUN chmod 755 /usr/local/bin/program-pulseaudio-forward

# Start SSH so we are ready to make a tunnel
ENTRYPOINT ["/usr/sbin/sshd",  "-D"]

# Expose the SSH port
EXPOSE 22

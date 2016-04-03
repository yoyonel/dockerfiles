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
#FROM ignf/ubuntu
# utilisation d'une image ubuntu, faudrait tester une debian directement
FROM ubuntu:latest
#
MAINTAINER Lionel ATTY <lionel.atty@gmail.com>

RUN rm -r /var/cache/apt/archives/partial/
#
RUN apt-get -y update &&\
	apt-get -y upgrade &&\
	apt-get -y install software-properties-common

##################################################
# ChucK + miniAudicle
##################################################
# Dépendances pour compiler l'audio engine ChucK + son IDE miniAudicle
RUN apt-get -y install \
		make \
		gcc \
		g++

RUN apt-get -y install \
		bison \
		flex 

RUN apt-get -y install \
		libasound2-dev \
		libsndfile1-dev 

RUN apt-get -y install libqt4-dev

RUN apt-get -y install libqscintilla2-dev

RUN apt-get -y install libpulse-dev

# Copy des sources pour le moteur Audio : ChucK
COPY chuck-1.3.5.2.tgz /root/
COPY miniAudicle-1.3.3.tgz /root/
RUN cd /root; \
	tar xzvf chuck-1.3.5.2.tgz; \
	tar xzvf miniAudicle-1.3.3.tgz; \
	rm /root/*.tgz
# installation du moteur de rendu ChucK
RUN	cd /root/chuck-1.3.5.2/src; \
	make linux-pulse; \
	make install;

# installation/compilation du moteur de rendu ChucK + EDIteur (qt)
RUN cd /root/miniAudicle-1.3.3/src; \
	make linux-pulse; \
	make install;

##################################################
# Partie serveur SSH forward X11+PulseAudio
##################################################
# Install OpenSSH
RUN apt-get install -y openssh-server

# Create OpenSSH privilege separation directory
RUN mkdir /var/run/sshd

# Install Pulseaudio
RUN apt-get install -y pulseaudio

# Add the ChucK user that will run the IDE + Audio Engine
RUN adduser --disabled-password --gecos "ChucK User" --uid 5001 chuck

# Add SSH public key for the chuck user
RUN mkdir /home/chuck/.ssh
ADD id_rsa.pub /home/chuck/.ssh/authorized_keys
RUN chown -R chuck:chuck /home/chuck/.ssh

##################################################
# Mise en place d'un wrapper pour activer le forward
# pulseaudio pour miniAudicle pour l'user 'chuck'
##################################################
# Set up the launch wrapper
RUN echo 'export PULSE_SERVER="tcp:localhost:64713"' >> /usr/local/bin/chuck-pulseaudio-forward
RUN echo 'miniAudicle' >> /usr/local/bin/chuck-pulseaudio-forward
RUN chmod 755 /usr/local/bin/chuck-pulseaudio-forward

# Start SSH so we are ready to make a tunnel
ENTRYPOINT ["/usr/sbin/sshd",  "-D"]

# Expose the SSH port
EXPOSE 22

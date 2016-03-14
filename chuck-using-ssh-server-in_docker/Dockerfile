# version SSH pulse-audio
# utile (indispensable) à l'IGN
FROM yoyo/docker-ssh
#
MAINTAINER Lionel ATTY <lionel.atty@gmail.com>

##################################################
# ChucK + miniAudicle
##################################################
# Dépendances pour compiler l'audio engine ChucK + son IDE miniAudicle
RUN apt-get -y install \
		make \
		gcc \
		g++ \
		bison \
		flex \
		libasound2-dev \
		libsndfile1-dev \
		libqt4-dev \
		libqscintilla2-dev \
		libpulse-dev

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
# Mise en place d'un wrapper pour activer le forward
# pulseaudio pour miniAudicle pour l'user 'chuck'
##################################################
# Set up the launch wrapper
RUN cp /usr/local/bin/program-pulseaudio-forward /usr/local/bin/chuck-pulseaudio-forward
RUN echo 'miniAudicle' >> /usr/local/bin/chuck-pulseaudio-forward
RUN chmod 755 /usr/local/bin/chuck-pulseaudio-forward
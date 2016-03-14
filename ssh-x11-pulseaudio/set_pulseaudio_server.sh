#!/bin/bash

# url: http://stackoverflow.com/questions/592620/check-if-a-program-exists-from-a-bash-script
if ! [ -x "$(command -v paprefs)" ]; then
	sudo apt-get install -y paprefs
fi

echo "<< Il faut activer dans 'Network Server' -> [x] 'Activer l'accès aux périphériques de son locaux' "
echo "<< Il faut activer dans 'Network Server' -> [x] 'Don't require authentification' "

paprefs

#if [ -x "$(command -v display)" ]; then
#	display paprefs-settings-to-activate.jpg
#fi

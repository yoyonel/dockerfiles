#!/bin/bash

if [ ! -f ~/.ssh/id_rsa.pub ] 
	then 
	echo ">> pas de fichier id_rsa.pub trouvé, on lance la génération de clée SSH !"
	ssh-keygen;	
else
	echo ">> le fichier ~/.ssh/id_rsa.pub existe déjà, on l'utilise (par défaut)"
fi
echo ">> copie du fichier ~/.ssh/id_rsa.pub"
cp ~/.ssh/id_rsa.pub .;

# on vérifie que la config SSH n'est pas déjà présente
# dans le fichier de setting ~/.ssh/config
if grep -Fxq "Host docker_ssh" ~/.ssh/config 
	then
	echo ">> Host docker_ssh déjà présent dans ~/.ssh/config"	
else
	echo ">> On insère la config SSH pour Docker dans un Docker container"
	cat config >> ~/.ssh/config
fi
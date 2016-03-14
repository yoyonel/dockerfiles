docker build -t yoyo/docker-ssh .

if [ -f id_rsa.pub ]
	then
	echo ">> suppression de la clée publique"
	rm id_rsa.pub
fi
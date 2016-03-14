docker build -t yoyo/chuck_ssh_pulse .

if [ -f id_rsa.pub ]
	then
	echo ">> suppression de la clée publique"
	rm id_rsa.pub
fi
#!/bin/bash

# Authors: Alex Freitag, Sahra Flôhr, Willyam Castro
# 
# Date: 23/03/2020
#
# Descryption: Crypt and decrypt files (only txt) with openssl in rsa key (asymmetric);
#

ext='.crypt'

[ "$1" == 1 ] && echo && echo || clear

echo -en "\033[1;34m\n[0] Gerar chaves \n[1] Crypt or Decrypt \n[2] Sair: \033[0m"
read ANSWER

clear



# Checking
case $ANSWER in
	# Generate public and private keys
	0) echo -en "\033[1;32m\n\tDefina uma chave de segurança a seguir e confirme-a: \n\n\033[0m"

		openssl genrsa -des3 -out ~/private.pem 2048
		[ $? == 0 ] && (echo -en "\033[1;32m\n\n\tEntre com a chave definida para gerar a chave pública:\n\n\033[0m" && 
			openssl rsa -in ~/private.pem -outform PEM -pubout -out ~/public.pem)

		if [ $? == 0 ]; then
			clear
			echo -en "\033[1;32m\n\t Chave privada gerada $HOME/private.pem e \n\t\tpública em $HOME/public.pem\033[0m\n\n"
$0 1
		fi
			;;



	1) echo -en "\033[1;34m\n[0] Crypto \n[1] Decrypt : \033[0m "
		read ANSWER

		echo

		case $ANSWER in

			# Crypt;
			0)
				clear
				echo -en "\033[1;34m Full path from archive TXT for crypt: \033[0m"
				read path

				if [ -e "$path" ]; then
					cd $(dirname $path)

					# get filename only
					fileName=$(basename $path)

					# change extension name to "$ext"
					fileNameDst=$(echo $fileName | sed -e "s/.txt/${ext}/g")

					if [ $? = 0 ]; then
						openssl rsautl -encrypt -inkey ~/public.pem -pubin -in $fileName -out $fileNameDst
						
						echo -en "\033[1;32m\n\t Arquivo encriptado com sucesso utilizando a chave pública. \n\n\033[0m"

					else					
						echo -e "\033[1;31m	Erro ao encriptar \"$path\" \033[0m"
						exit 10
					fi

				else
					echo -e "\033[1;31m\n\n	Arquivo \"$path\" não localizado... \033[0m"
					echo && echo

				fi
					;;

			# Decrypt;
			1)
				echo
				echo -en "\033[1;34m Informe o caminho completo do arquivo .crypt: \033[0m "
				read path

				# $OUTPUT vazio;
				if [ -n $path ]; then
					outputFile="$(echo $path | cut -d. -f1).txt" #"$fileName.txt"

					echo -en "\033[1;32m \n\tInforme a chave de segurança da chave privada: \n \033[0m"

					# Decrypt;
					openssl rsautl -decrypt -inkey ~/private.pem -in $path -out $outputFile >> /dev/null

					[ $? == 0 ] && echo -en "\033[1;32m \n\t Arquivo \"$path\" decriptado com sucesso! \n\t\tDisponível em \"$outputFile\" \n\n\033[0m"

				else
					echo -en "\033[1;31m \n\t\tCaminho vazio...\n\n \033[0m"
				fi

					;;

			*) printf "\033[1;31m \t\tValor inválido...\n \033[0m"
			esac
				;;

	2) exit;;
		
	*) printf "\033[1;31m \n\t\tValor inválido... \033[0m"
	$0 1
esac

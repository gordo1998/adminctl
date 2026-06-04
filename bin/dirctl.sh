#!/bin/bash

COMMAND="$1"

usage(){
cat << EOF

Uso: userctl <comando> [opciones]

Comandos:
	create <user>	Crear directorio
	delete <user>	Eliminar directorio
	import <file>	Crear directorios desde archivo
	dimport <file>	Eliminar directorios desde archivo

Opciones:
	--help			Mostrar ayuda
	--version		Mostrar versión

EOF
}

VERSION=$(cat "../version/version")

case "$COMMAND" in
	create)
		#FUNCION ARCHIVO CREATE
		;;
	delete)
		#FUNCION ARCHIVO DELETE
		;;
	import)
		#FUNCION ARCHIVO IMPORT
		;;
	dimport)
		#FUNCION ARCHIVO DIMPORT
		;;
	-h|--help)
		usage
		exit 0
		;;
	-v|--version)
		echo "$VERSION"
		exit 0
		;;
	*)
		echo "Opcion no válida"
		exit 1
		;;
esac

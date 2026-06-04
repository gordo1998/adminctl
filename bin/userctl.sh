#!/bin/bash

source "../options/user/create.sh"
source "../options/user/delete.sh"
source "../options/user/import.sh"
source "../options/user/dimport.sh"

COMMAND="$1"

usage(){
cat << EOF

Uso: userctl <comando> [opciones]

Comandos:
	create <user>	Crear usuario
	delete <user>	Eliminar usuario
	import <file>	Crear usuarios desde archivo
	dimport <file>	Eliminar usuarios desde archivo

Opciones:
	--help			Mostrar ayuda
	--version		Mostrar versión

EOF
}

VERSION=$(cat "../version/version")

case "$COMMAND" in
	create)
		uc_create_user "$@"
		;;
	delete)
		ud_delete_user "$@"
		;;
	import)
		ui_import_users "$@"
		;;
	dimport)
		udi_delete_users "$@"
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

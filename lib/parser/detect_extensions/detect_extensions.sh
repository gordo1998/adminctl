#!/bin/bash

#Funcion que tenga un archivo y dependiendo de la extensión deribea un f
#VARIABLE

DIR_SOURCE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LIB_MOD_EXT="$(cd "$DIR_SOURCE/../parser_extensions" && pwd)"

source "$LIB_MOD_EXT/csv.sh"
#Poner mas en caso de que hayan más formatos (aunque tiene que haber otra manera mas limpia porque no esta bien poner todas las extensiones.

FILE="$2"
COMMAND="$1"

lpd_det_ext(){
	case "$FILE" in
		*.csv)
			importOrdimport_csv
			#llama a otra funcion que se enceuntra en lib/parser/parser_extensions
			;;
		*)
			echo "Operación no permitida"
	esac 
}

importOrdimport_csv(){
	case "$COMMAND" in
		import)
			lpp_parser_ext_user_csv "$@"
			;;
		dimport)
			lpp_parser_ext_user_del_csv "$@"
			;;
	esac
}


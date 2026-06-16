#!/bin/bash

#Funcion que tenga un archivo y dependiendo de la extensión deribea un f
#VARIABLE

DIR_SOURCE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LIB_DIR="$(cd "$DIR_SOURCE/../.." && pwd)"

source "$LIB_DIR/parser/parser_extensions/csv.sh"
#Poner mas en caso de que hayan más formatos (aunque tiene que haber otra manera mas limpia porque no esta bien poner todas las extensiones.


lpd_det_ext(){
	local file="$2"
	case "$file" in
		*.csv)
			importOrdimport_csv
			#llama a otra funcion que se enceuntra en lib/parser/parser_extensions
			;;
		*)
			echo "Operación no permitida"
	esac 
}

importOrdimport_csv(){
	local command="$1"
	case "$command" in
		import)
			lpp_parser_ext_user_csv "$@"
			;;
		dimport)
			lpp_parser_ext_user_del_csv "$@"
			;;
	esac
}




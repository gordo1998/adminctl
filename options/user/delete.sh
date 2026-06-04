#!/bin/bash

SCRIPT_SOURCE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LIB_MOD_SOURCE="$(cd "$SCRIPT_SOURCE/../../lib/mode" && pwd)"
source "$LIB_MOD_SOURCE/lib_mode_det_mode.sh"

UD_USER=""

ud_det_user(){
	while [[ $# -gt 0 ]];do
		case "$1" in
			delete)
				shift
				;;
			*)
				if [[ -z "$UD_USER" ]];then
					UD_USER="$1"
				else
					echo "Opcion no valida"
				fi
				shift
		esac
	done
}

ud_dmake_user(){
	echo "Eliminando usuario $UD_USER"
	sudo userdel -r "$UD_USER" &> /dev/null

	([[ $? == 0 || $? == 12 ]] && echo "usuaro $UD_USER eliminado correctamente") || echo "El usuario $UD_USER no existe o no se ha podido eliminar correctamente" && exit 1
}

ud_delete_user(){
	ud_det_user "$@"
	ud_dmake_user
}



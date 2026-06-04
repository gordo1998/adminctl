#!/bin/bash



UDI_DIR_SOURCE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
UDI_LIB_PAR_EXT="$(cd "$UDI_DIR_SOURCE/../../lib/parser" && pwd)"
source "$UDI_LIB_PAR_EXT/detect_extensions/detect_extensions.sh"

UDI_PARSED=$(lpd_det_ext "$@")

udi_delete_users(){
	while read -r user;do
		echo "Eliminando usuario $user..."
		sudo userdel -r "$user" &>/dev/null
		([[ $? == 0 || $? == 12 ]] && echo "Usuario $user eliminado correctamente") || (echo "El usuario $user no se ha podidio eliminar" && exit 1)
	done <<<"$UDI_PARSED"
}



#!/bin/bash

UI_DIR_SOURCE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
UI_LIB_PAR_EXT="$(cd "$UI_DIR_SOURCE/../../lib/parser" && pwd)"
UI_LIB_MOD="$(cd "$UI_DIR_SOURCE/../../lib/mode" && pwd)"

source "$UI_LIB_PAR_EXT/detect_extensions/detect_extensions.sh"
source "$UI_LIB_MOD/lib_mode_det_mode.sh"


UI_PARSED=$(lpd_det_ext "$@")
UI_DIR=$(lm_det_mode "$@")

#Un while tiene que haber si o si. Antes del while se llama a una funcion que parsea la info. 

ui_import_users(){
	while IFS="|" read -r user path_user;do
		echo "Creando usuario $user..."
		sudo useradd -m -d "$UI_DIR/$path_user" "$user"
		([[ $? == 0 ]] && echo "Usuario $user creado correctamente") || (echo "Usuario $user no se ha podido crear o ya existe" && exit 1)
	done <<< "$UI_PARSED"
}

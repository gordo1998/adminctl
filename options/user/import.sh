#!/bin/bash

UI_DIR_SOURCE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LIB_DIR="$(cd "$UI_DIR_SOURCE/../../lib" && pwd)"

source "$LIB_DIR/parser/detect_extensions/detect_extensions.sh"
source "$LIB_DIR/mode/lib_mode_det_mode.sh"
source "$LIB_DIR/user/execution.sh"
source "$LIB_DIR/user/validation.sh"

#EN BASE A LA LISTA PARSEADA DE UI_PARSED EJECUTA LAS INSTRUCCIONES PARA LA CREACIÓN DE USUARIOS
ui_import_users(){
	#ESTA VARIABLE SE ENCARGA DE RECOGER LA LISTA PARSEADA.
	local ui_parsed=$(lpd_det_ext "$@")
	#ESTA DETECTA EL MODO DEL ENTORNO (LABORATORIO O NORMAL PARA CREAR EL PATH RAIZ)
	local ui_dir=$(lm_det_mode "$@")

	while IFS="|" read -r user path_user;do
		local dir_complete="$ui_dir/$path_user"
		echo "Creando usuario $user..."
		exec_comm "$user" "$dir_complete"
	done <<< "$UI_PARSED"
}

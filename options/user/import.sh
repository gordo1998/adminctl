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
		local complete_dir="$ui_dir/$path_user"
		validate_param "$user"
		local statement=$?

		if [[ $statement -eq 0 ]];then
			echo "El usuario es: $user"
			echo "El directorio personal es: $dir_root"
			#Llamamos a la funcion de ejecucion  que se encuentra en la libreria
			exec_comm "$user" "$complete_dir"
		else
			return 1
		fi
	done <<< "$UI_PARSED"
}

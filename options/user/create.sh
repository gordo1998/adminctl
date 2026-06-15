#!/bin/bash


SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LIB_DIR="$(cd "$SCRIPT_DIR/../../lib"  && pwd)"


source "$LIB_DIR/mode/lib_mode_det_mode.sh"
source "$LIB_DIR/user/validation.sh"
source "$LIB_DIR/user/execution.sh"


#ESTA FUNCIÓN VALIDARÁ EL PARÁMETRO
uc_det_param(){
	local user=""
	local dir_par=""
	local statement=""

	while [[ $# -gt 0 ]];do
		case "$1" in
			--dir)
				dir_par="$2"
				shift 2
				;;
			-*)
				echo "Error: Opción no reconocida '$1'"
				return 1
				;;
			*)
				user="$1"
				shift
				;;
		esac
	done

	validation_param "$user"
	statement=$?
	echo "$user|$dir_par|$statement"
}

uc_create_user(){
	local dir_root=$(lm_det_mode)
	local complete_dir=""
	
	IFS='|' read -r user dir_par statement <<< "$(uc_det_param "$@")"
	complete_dir="$dir_root/$dir_par"
	
	if [[ $statement -eq 0 ]];then
		echo "El usuario es: $user"
		echo "El directorio personal es: $dir_root"
		#Llamamos a la funcion de ejecucion  que se encuentra en la libreria
		exec_comm "$user" "$complete_dir"
	else
		return 1
	fi
	
}


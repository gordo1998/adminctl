#!/bin/bash


SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LIB_DIR="$(cd "$SCRIPT_DIR/../../lib/mode"  && pwd)"



source "$LIB_DIR/lib_mode_det_mode.sh"


#DEBERIAMOS GUARDAR UNA VARIABLE DONDE ALMACENE EL DIR RAIZ, INDEPENDIENTEMENTE DE SI ES LAB O NORMAL. ESO LO HARA OTRA FUNCION DE LA LIB MODE.




uc_validate_param(){
	local user="$1"
	#USUARIO NO PUEDE ESTAR VACÍO
	[[ -z "$user" ]] && echo "Error: debes especificar un usuario" >&2 && return 1

	#USUARIO NO DEBE EMPEZAR POR GUIÓN PARA NO CONFUNDIR CON PARÁMETROS
	[[ "$user" == -*  ]] && echo "Error: El usuario no debe empezar por guiones" >&2  && return 1

	#USUARIO NO DBE CONTENER CARÁCTERES INVÁLIDOS
	[[ ! "$user" =~ ^[a-z0-9_]+$ ]] && echo "Error: el usuario $user contiene carácteres inválidos" >&2 && return 1

	return 0
}

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

	uc_validate_param "$user"
	statement=$?
	echo "$user|$dir_par|$statement"
}

uc_exec_comm(){
	local user="$1"
	local dir_complete="$2"
	
	echo "Creando usuario $user..."
	sudo useradd -m -d "$dir_complete" "$user"
	([[ $? -eq 0 ]] && echo "usuario $user creado correctamente.") || (echo "El usuario $user no se ha podido crear" && exit 1)
}

uc_create_user(){
	local dir_root=$(lm_det_mode)
	local complete_dir=""
	#A ver necesito completar aquí la ruta correcta. Y además, necesito crear otro puto array para pasarlo
	#a la funcion de ejecucion. Necesito las siguientes variables.
	# usuario, dircompleto	
	IFS='|' read -r user dir_par statement <<< "$(uc_det_param "$@")"
	complete_dir="$dir_root/$dir_par"
	
	if [[ $statement -eq 0 ]];then
		echo "El usuairo es: $user"
		echo "El directorio personal es: $dir_root"
		uc_exec_comm "$user" "$complete_dir"
	else
		echo "Error en el parámetro"
	fi
	
}


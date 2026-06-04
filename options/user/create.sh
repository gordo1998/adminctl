#!/bin/bash


SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LIB_DIR="$(cd "$SCRIPT_DIR/../../lib/mode"  && pwd)"



source "$LIB_DIR/lib_mode_det_mode.sh"


#DEBERIAMOS GUARDAR UNA VARIABLE DONDE ALMACENE EL DIR RAIZ, INDEPENDIENTEMENTE DE SI ES LAB O NORMAL. ESO LO HARA OTRA FUNCION DE LA LIB MODE.


UC_USER=""
UC_DIR_PAR=""
UC_DIR_ROOT=$(lm_det_mode)
UC_COMPLETE_DIR=""

uc_det_param(){
	while [[ $# -gt 0 ]];do
		case "$1" in
			--dir)
				echo "Se ejecuta --dir"
				UC_DIR_PAR="$2"
				shift 2
				;;
			*)
				if [[ -z "$UC_USER" ]];then
					UC_USER="$2"
				else
					echo "Opcion no válida"
				fi
				shift
				;;
		esac
	done
}

uc_exec_comm(){
	UC_COMPLETE_DIR="$UC_DIR_ROOT/$UC_DIR_PAR"
	echo "Creando usuario $UC_USER..."
	sudo useradd -m -d "$UC_COMPLETE_DIR" "$UC_USER"
	([[ $? == 0 ]] && echo "usuario $UC_USER creado correctamente.") || echo "El usuario $UC_USER no se ha podido crear" && exit 1
}

uc_create_user(){
	uc_det_param "$@"
	echo "El directorio personal es: $UC_COMPLETE_DIR"
	echo "UC_DIR_PAR: $UC_DIR_PAR"
	echo "UC_DIR_ROOT: $UC_DIR_ROOT"
	uc_exec_comm
}


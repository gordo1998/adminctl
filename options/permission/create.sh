#!bin/bash

PC_SOURCE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

PC_OPTION=""
PC_PERMISSION=""
PC_OWNER=""
PC_PATH_PERM=""
PC_GROUP=""
PC_PERM=""

#path_perm owner group perm


pc_create_perm(){
	while true;do
		case "$1" in
			-a|--acl)
				PC_PATH_PERM="$"
				PC_PERM="$2"
				shift 2
				;;
			-b|--basic)
				shift 2
				;;
			create)
				shift
				;;
			*)
				if [[ -z "$PC_PERM" ]];then
					PC_USER="$1"
				else
					echo "Esta opción es inválida"
					exit 1
				fi
				shift
				;;
		esac
	done
}

acl_perm(){
	[[ -n "$PC_USER" ]] &&  echo "Creando permisos acl para el usuario "
}

base_perm(){

}

dir_perm(){
	if [[ 
}

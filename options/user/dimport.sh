#!/bin/bash

UDI_DIR_SOURCE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LIB_DIR="$(cd "$UDI_DIR_SOURCE/../../lib" && pwd)"

source "$LIB_DIR/parser/detect_extensions/detect_extensions.sh"
source "$LIB_DIR/user/delete.sh"
source "$LIB_DIR/user/validation.sh"


udi_delete_users(){
	local parsed=$(lpd_det_ext "$@")
	local statement=0
	while read -r user;do
		validate_param "$user"
		statement=$?
		if [[ $statement -eq 0 ]];then
			echo "Eliminando usuario $user..."
			delete_user "$user"
		else
			return 1
		fi
		
	done <<<"$parsed"
}



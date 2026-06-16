#!/bin/bash


#SERIALIZA DATOS DE ENTRADA DONDE DETECTA USUARIOS Y DIRECTORIOS DEVOLVIENDOLOS CON FORMATO <VALUE1|VALUE2>
lpp_parser_ext_user_csv(){
	local file="$2"

	while IFS="," read -r user path_user;do
        [[ -z "$user" ]] && continue
		echo "$user|$path_user"
	done < "$file" 
}

#SERIALIZAR DATOS DE ENTRADA DONDE DETECTA USUARIOS DEVOLVIENDOLOS CON FORMATO <VALUE1>
lpp_parser_ext_user_del_csv() {
	local file="$2"

	while read -r user;do
        [[ -z "$user" ]] && continue
		echo "$user"
	done < "$file"
}

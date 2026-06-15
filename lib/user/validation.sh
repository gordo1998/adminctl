validate_param(){
	local user="$1"
	#USUARIO NO PUEDE ESTAR VACÍO
	[[ -z "$user" ]] && echo "Error: debes especificar un usuario" >&2 && return 1

	#USUARIO NO DEBE EMPEZAR POR GUIÓN PARA NO CONFUNDIR CON PARÁMETROS
	[[ "$user" == -*  ]] && echo "Error: El usuario no debe empezar por guiones" >&2  && return 1

	#USUARIO NO DBE CONTENER CARÁCTERES INVÁLIDOS
	[[ ! "$user" =~ ^[a-z0-9_]+$ ]] && echo "Error: el usuario $user contiene carácteres inválidos" >&2 && return 1

	return 0
}


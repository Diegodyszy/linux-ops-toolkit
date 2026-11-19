#!/bin/bash

echo "Logins interativos da maquina: "
LOGIN_USERS=$(grep -E "/(bash|sh)$" /etc/passwd | cut -d: -f1,7)
if [ -z "$LOGIN_USERS" ]; then
	echo "Nenhum usuario encontrado"
else
	echo "$LOGIN_USERS"
fi
echo " "
echo "Usuarios com permissão sudo: "
ADMIN_SUDO=$(grep -E "^(sudo|wheel):" /etc/group)
if [ -z "$ADMIN_SUDO" ]; then
	echo "Nenhum usuario sudo encontrado"
else
	echo "$ADMIN_SUDO"
fi
echo " "
echo "Arquivos com bit SUID: "
SUID_FILES=$( find /usr/bin -perm -4000 2>/dev/null)
if [ -z "$SUID_FILES" ]; then 
	echo "Nenhum arquivo com bit SUID encontrado"
else 
	echo "$SUID_FILES"
fi
echo " "
echo "Arquivos com permisão 777: "
RWX_PERM=$(find /usr/bin -perm 777 2>/dev/null)
if [ -z "$RWX_PERM" ]; then
       echo "Nenhum arquivo com permissão 777 encontrado"
else
       echo "$RWX_PERM"
fi       

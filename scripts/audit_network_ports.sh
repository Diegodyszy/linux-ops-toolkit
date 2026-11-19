#!/bin/bash
SOCKETS=$(sudo ss -tulpn)
echo "Portas abertas em 0.0.0.0"
EXPOSTAS=$(echo "$SOCKETS" |grep -E "0\.0\.0\.0")
if  [ -z "$EXPOSTAS" ]; then
	echo "Nenhuma porta encontrada"
else
	echo "$EXPOSTAS"
fi

echo " "
echo "Portas escutando apenas localmente 127.0.0.1"
LOCAIS=$(echo "$SOCKETS" |grep -E "127\.0\.0\.1")
if [ -z "$LOCAIS" ]; then 
	echo "Nenhuma porta encontrata"
else 
	echo "$LOCAIS"
fi
echo " "
echo "Portas em estado LISTEN"
STATELIS=$(echo "$SOCKETS" |grep -E "LISTEN")
if [ -z "$STATELIS" ]; then
	echo "Nenhuma porta encontrada"
else 
	echo "$STATELIS"
fi
echo " "
echo "Portas em estado UNCONN"
UDP_UNCON=$(echo "$SOCKETS" |grep "UNCONN")
if [ -z "$UDP_UNCON" ]; then
	echo "Nenhuma porta encontrada"
else 
	echo "$UDP_UNCON"
fi
echo " "
echo "Enderecos IPv6"
IPV6_SOCKETS=$(echo "$SOCKETS" |grep -E "\[::\]")
if [ -z "$IPV6_SOCKETS" ]; then
	echo "Nenhuma porta encontrada"
else 
	echo "$IPV6_SOCKETS"
fi
	

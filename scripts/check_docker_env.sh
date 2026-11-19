#!/bin/bash
echo "Status do serviço: "
if systemctl is-active --quiet docker 2>/dev/null; then
	echo "active"
else
	echo "inactive"
fi
echo " "
echo "Containers em execução: "
CONTAINER_ON=$(docker ps -q 2>/dev/null)
if [ -z "$CONTAINER_ON" ]; then 
	echo "Nenhum container esta em execução"
else
	docker ps
echo " " 
echo "Containers parados: "
CONTAINER_OFF=$(docker ps -a -f status=exited -q 2>/dev/null)
if [ -z "$CONTAINER_OFF" ]; then
	echo "Nenhum container esta parado"
else 
	docker ps -a -f status=exited
fi
echo " "
echo "Imagens sem tag"
DANGLING=$(docker images -f "dangling=true" -q 2>/dev/null)
if [ -z "$DANGLING" ]; then
	echo "Não foi encontrado nenhuma imagen sem tag"
else 
	docker images -f "dangling=true"
fi
echo " " 
echo "Volumes ou portas em uso pelos containers"
VOLUMES=$(docker volume ls -q 2>/dev/null)
if [ -z "$VOLUMES" ]; then
	echo "Não possuem volumes criados na maquina"
else
	docker volume ls
fi
echo " "
echo "Portas mapeadas pelos containers: "
PORTS_MAP=$(docker ps --format "{{.Names}}: {{.Ports}}" 2>/dev/null | grep "->")
if [ -z "$PORTS_MAP" ]; then
    echo "Nenhuma porta mapeada em containers ativos"
else
    echo "$PORTS_MAP"
fi

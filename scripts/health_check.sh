#!/usr/bin/env bash
echo "tempo que a maquina esta ligada e sua carga media:"
	uptime
echo ""
echo "uso de RAM e swap"
	free -h
echo ""
echo "espaco em disco da maquina"
	USO_DISCO=$(df -h --output=pcent / | tail -1 | tr -d ' %')
	if [ "$USO_DISCO" -gt 80 ]; then
    		echo "[ALERTA] Disco acima de 80%: ${USO_DISCO}%"
	else
    		echo "[OK] Uso de disco normal: ${USO_DISCO}%"
	fi
echo ""
echo "status do docker"
	systemctl is-active docker
echo ""

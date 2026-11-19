#!/bin/bash

ORIGEM="$HOME/cofre-suporte"
DESTINO="$HOME/backups-cofre"
DATA=$(date +%F)
ARQUIVO="$DESTINO/cofre_backup_$DATA.tar.gz"
DIAS_RETENCAO=7

echo "=== 1. Validacao de pastas ==="
if [ ! -d "$ORIGEM" ]; then
    echo "Erro: pasta de origem nao encontrada em $ORIGEM"
    exit 1
fi

mkdir -p "$DESTINO"
echo "Origem verificada: $ORIGEM"
echo "Destino pronto: $DESTINO"
echo ""

echo "=== 2. Criacao do backup ==="
tar -czf "$ARQUIVO" -C "$ORIGEM" . 2>/dev/null

if [ ! -f "$ARQUIVO" ] || [ ! -s "$ARQUIVO" ]; then
    echo "Erro: falha ao criar o arquivo de backup em $ARQUIVO"
    exit 1
fi

echo "Backup criado com sucesso: $ARQUIVO"
echo ""

echo "=== 3. Rotacao de backups antigos ==="
OLD_BACKUPS=$(find "$DESTINO" -maxdepth 1 -name "cofre_backup_*.tar.gz" -type f -mtime +$DIAS_RETENCAO 2>/dev/null)

if [ -z "$OLD_BACKUPS" ]; then
    echo "Nenhum backup com mais de $DIAS_RETENCAO dias para remover"
else
    echo "Removendo backups antigos:"
    echo "$OLD_BACKUPS"
    find "$DESTINO" -maxdepth 1 -name "cofre_backup_*.tar.gz" -type f -mtime +$DIAS_RETENCAO -delete 2>/dev/null
    echo "Limpeza concluida"
fi
echo ""

echo "=== 4. Resumo final ==="
CURRENT_BACKUPS=$(ls -lh "$DESTINO"/cofre_backup_*.tar.gz 2>/dev/null)

if [ -z "$CURRENT_BACKUPS" ]; then
    echo "Nenhum arquivo de backup encontrado em $DESTINO"
else
    echo "$CURRENT_BACKUPS"
fi

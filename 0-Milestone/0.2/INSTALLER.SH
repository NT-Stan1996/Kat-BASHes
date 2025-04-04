#!/bin/bash

# Copia a pasta KTBASHes para o diretório home do usuário
cp -r ./KTBASHes $HOME/KTBASHes

# Cria o arquivo KTBASHes_START.SH em $HOME/ e insere o conteúdo
cat > $HOME/KTBASHes_START.SH <<'EOF'
#!/bin/bash

# Usa o dialog para perguntar se o usuário quer continuar
dialog --backtitle "Kat#BASHes Boot Menu" --title "Kat#BASHes Boot Menu" --yesno "Deseja inicializar o Kat#BASHes?" 7 60

# Se o usuário escolher "Sim", executa o menu.sh
if [ $? -eq 0 ]; then
    cd $HOME/KTBASHes/
    bash menu.sh
else
    echo "Inicialização cancelada."
    exit 0
fi
EOF

# Torna o arquivo KTBASHes_START.SH executável
chmod +x $HOME/KTBASHes_START.SH

cd $HOME

# Exibe mensagem de sucesso
echo "Instalação concluída! Você pode iniciar o sistema com 'bash KTBASHes_START.SH' no local onde foi criado."

#!/bin/bash

# Criando diretórios necessários
mkdir -p KatTagBASHes/
mkdir -p KatTagBASHes/GAMES/
mkdir -p KatTagBASHes/GAMES/SAVES/

# Mensagem inicial
echo ""
echo "Bem-vindo ao Kat#BASHes"
echo "==[ i ] Pressione [ENTER] para continuar ===="
echo ""
echo "NOTA: O Kat#BASH foi feito para rodar no Termux"
read -r

# Função principal do menu
main_menu() {
    while true; do
        CHOICE=$(dialog --clear --backtitle "Kat#BASHes" --title "Menu Inicial do Kat#BASHes" \
            --menu "Escolha uma opção:" 15 50 5 \
            1 "Jogar" \
            2 "Jogos Salvos" \
            3 "Sobre" \
            4 "NIS(TM) Store" \
            5 "Kat Update" \
            6 "Sair" \
            7 "PWD" \
            2>&1 >/dev/tty)
        
        case $CHOICE in
            1) play_game ;;
            2) saved_games ;;
            3) about ;;
            4) nis_store ;;
            5) updateservice ;;
            6) confirm_exit ;;
            7) show_pwd ;;
            *) break ;;
        esac
    done
}

# Função Jogar
play_game() {
    GAMES=( $(find KatTagBASHes/GAMES/ -type f -name "*.sh" -o -name "*.bin" -o -name "*.SH" -o -name "*.BIN" 2>/dev/null) )
    if [ ${#GAMES[@]} -eq 0 ]; then
        dialog --backtitle "Kat#BASHes" --msgbox "Nenhum jogo instalado. Instale pela NIS(TM) Store ou manualmente." 10 50
        return
    fi

    # Prepara o array para o menu do dialog, mostrando apenas o nome do arquivo
    MENU_OPTIONS=()
    for game in "${GAMES[@]}"; do
        GAME_NAME=$(basename "$game")  # Obtém o nome do arquivo sem o caminho
        MENU_OPTIONS+=("$GAME_NAME" "$GAME_NAME")
    done

    GAME_CHOICE=$(dialog --clear --backtitle "Kat#BASHes" --title "Selecione um jogo" \
        --menu "Escolha um jogo para iniciar (suporte a .bin/.BIN não confirmado):" 15 50 ${#MENU_OPTIONS[@]} \
        "${MENU_OPTIONS[@]}" 2>&1 >/dev/tty)

    if [ -n "$GAME_CHOICE" ]; then
        # Procura o caminho completo para o jogo selecionado
        GAME_PATH=$(find KatTagBASHes/GAMES/ -type f -name "$GAME_CHOICE" 2>/dev/null)

        # Verifica assinatura para jogos .sh/.SH
        if [[ "$GAME_PATH" == *.sh || "$GAME_PATH" == *.SH ]]; then
            SIGNATURE=$(head -n 3 "$GAME_PATH" | grep -oP 'SIGNATURE="\K[^"]+')
            if [[ "$SIGNATURE" == "KTBASHES" || "$SIGNATURE" == "FIRE" ]]; then
                if [ "$SIGNATURE" == "FIRE" ]; then
                    dialog --backtitle "Kat#BASHes" --msgbox "A assinatura é FIRE. Achamos estranho que os devs do jogo conheçam o Fire, mas tudo bem..." 10 50
                fi
                clear  # Limpa a tela antes de executar o jogo
                bash --rcfile <(echo 'PS1="$ "') -i "$GAME_PATH"  # Roda o jogo em um shell interativo
                read -p "==[ i ] Pressione Enter para voltar ao menu ===="
            else
                dialog --backtitle "Kat#BASHes" --msgbox "Assinatura inválida. O jogo não pode ser iniciado." 10 50
            fi
        # Joga diretamente os jogos .bin/.BIN sem verificação de assinatura
        elif [[ "$GAME_PATH" == *.bin || "$GAME_PATH" == *.BIN ]]; then
            clear
            bash --rcfile <(echo 'PS1="$ "') -i -c "./$GAME_PATH"
            read -p "==[ i ] Pressione Enter para voltar ao menu ===="
        fi
    fi
}

# Função Jogos Salvos
saved_games() {
    SAVES=( $(find ./KatTagBASHes/GAMES/SAVES/ -type f -name "*.SAV" 2>/dev/null) )
    if [ ${#SAVES[@]} -eq 0 ]; then
        dialog --backtitle "Kat#BASHes" --msgbox "Nenhum jogo salvo encontrado." 10 50
        return
    fi

    # Prepara a lista de saves para exibição apenas com o nome do arquivo
    MENU_OPTIONS=()
    for save in "${SAVES[@]}"; do
        SAVE_NAME=$(basename "$save")
        MENU_OPTIONS+=("$SAVE_NAME" "$SAVE_NAME")
    done

    while true; do
        SAVE_CHOICE=$(dialog --clear --backtitle "Kat#BASHes" --title "Jogos Salvos" \
            --menu "Escolha um save para excluir ou pressione Cancelar para sair (se o save excluido continuar sendo listado, não significa que ele não foi excluído):" 15 50 ${#MENU_OPTIONS[@]} \
            "${MENU_OPTIONS[@]}" 2>&1 >/dev/tty)

        if [ -z "$SAVE_CHOICE" ]; then
            return  # Sai se o usuário cancelar
        fi

        SAVE_PATH="./KatTagBASHes/GAMES/SAVES/$SAVE_CHOICE"
        if [ -f "$SAVE_PATH" ]; then
            dialog --backtitle "Kat#BASHes" --yesno "Tem certeza de que deseja excluir '$SAVE_CHOICE'?" 7 50
            if [ $? -eq 0 ]; then
                { 
                    for ((i = 0; i <= 100; i += 20)); do
                        sleep 0.1
                        echo $i
                    done
                    rm "$SAVE_PATH"
                } | dialog --gauge "Excluindo $SAVE_CHOICE..." 10 50 0
            fi
        fi
    done
}

# Função Sobre
about() {
    dialog --backtitle "Kat#BASHes" --msgbox "========[ Kat BASH Entertainment System(TM) ]========\nVersão: Milestone (pre-Alpha) 0.3\nLinha: # (Linha 'Tag')\n\nFeito por: StanoBemLoko\nDistribuído por: Neko Interactive Systems(TM)\n\nApoio:\n- Fire <3\n- ChatGPT (...)\n\n(C) 2024-2025 Neko Interactive Systems(TM)\n(C) 2019-2025 TGF! Studios(TM)" 20 60
}

# Função NIS(TM) Store
nis_store() {
    CATEGORY=$(dialog --clear --backtitle "Kat#BASHes" --title "NIS™ Store" \
        --menu "Escolha uma categoria:" 10 50 2 \
        "1" "Jogos" \
        "2" "Apps" \
        2>&1 >/dev/tty)

    case $CATEGORY in
        1) STORE_PATH="Games" ;;
        2) STORE_PATH="Apps" ;;
        *) return ;;
    esac

    FILES=$(curl -s "https://api.github.com/repos/NT-Stan1996/NIS-Store/contents/$STORE_PATH" | grep -oP '"name": "\K[^"]+\.zip')

    if [ -z "$FILES" ]; then
        dialog --backtitle "Kat#BASHes" --msgbox "Nenhum item disponível para download." 10 50
        return
    fi

    MENU_OPTIONS=()
    for file in $FILES; do
        MENU_OPTIONS+=("$file" "$file")
    done

    CHOICE=$(dialog --clear --backtitle "Kat#BASHes" --title "NIS™ Store - $STORE_PATH" \
        --menu "Escolha um item para instalar:" 15 50 ${#MENU_OPTIONS[@]} \
        "${MENU_OPTIONS[@]}" 2>&1 >/dev/tty)

    if [ -z "$CHOICE" ]; then
        return
    fi

    ZIP_URL="https://github.com/NT-Stan1996/NIS-Store/raw/main/$STORE_PATH/$CHOICE"
    TEMP_FILE="/data/data/com.termux/files/usr/tmp/$CHOICE"

    dialog --backtitle "Kat#BASHes" --infobox "Baixando $CHOICE..." 10 50
    curl -L "$ZIP_URL" -o "$TEMP_FILE" --silent

    if [ ! -f "$TEMP_FILE" ]; then
        dialog --backtitle "Kat#BASHes" --msgbox "Falha ao baixar $CHOICE." 10 50
        return
    fi

    dialog --backtitle "Kat#BASHes" --infobox "Instalando $CHOICE..." 10 50
    unzip -o "$TEMP_FILE" -d "KatTagBASHes/GAMES/" >/dev/null 2>&1
    rm "$TEMP_FILE"

    dialog --backtitle "Kat#BASHes" --msgbox "$CHOICE instalado com sucesso!" 10 50
}

# Função Confirmar Saída
confirm_exit() {
    dialog --backtitle "Kat#BASHes" --yesno "Tem certeza de que deseja sair?" 7 50
    if [ $? -eq 0 ]; then
        clear
        exit 0
    fi
}

# Função Mostrar diretório atual
show_pwd() {
    CURRENT_DIR=$(pwd)
    dialog --backtitle "Kat#BASHes" --msgbox "O diretório atual é:\n$CURRENT_DIR" 10 50
}

updateservice() {
    URL="https://github.com/NT-Stan1996/Kat-BASHes/raw/main/0-Milestone/4/KTBASHes.zip"
    if curl --output /dev/null --silent --head --fail "$URL"; then
        dialog --backtitle "Kat#BASHes" --msgbox "Uma nova versão do Kat#BASHes está disponível!\n\nPara atualizar, baixe manualmente:\n$URL\n\nApós baixar, extraia o arquivo e substitua os arquivos antigos." 15 60
    else
        dialog --backtitle "Kat#BASHes" --msgbox "Nenhuma atualização disponível no momento." 10 50
    fi
}

# Iniciar menu principal
main_menu

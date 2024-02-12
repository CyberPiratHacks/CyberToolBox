#!/bin/bash

# Verifique se o script está sendo executado como root
if [ "$EUID" -ne 0 ]; then
    echo -e "\e[91mPor favor, execute o script como root (sudo)!\e[0m"
    exit
fi

# Verifique se o colorama está instalado
if ! [ -x "$(command -v python3 -m colorama)" ]; then
    echo -e "Colorama não está instalado. Instalando..."
    pip3 install colorama
fi

# Importando colorama e inicializando
# Você também pode adicionar esse bloco ao seu script Python diretamente
python3 - <<'EOF'
from colorama import init, Fore

init(autoreset=True)
EOF

# SETANDO AS CORES:

RED=$(tput setaf 1)
BLUE=$(tput setaf 2)
GREEN=$(tput setaf 3)
VIOLET=$(tput setaf 4)
NC=$(tput sgr0)  # Reset de cor

# ASCII Art
echo -e "${RED}   ______      __             ______            ____              "
echo -e "${VIOLET}  / ____/_  __/ /_  ___  ____/_  __/___  ____  / / /_  ____  _  __"
echo -e "${GREEN} / /   / / / / __ \/ _ \/ ___// / / __ \/ __ \/ / __ \/ __ \| |/_/"
echo -e "${BLUE}/ /___/ /_/ / /_/  \__\/ /   / / / /_/ / /_/ / / /_/ / /_/ />  <  "
echo -e "${RED}\____/\__, /_.___/\___/_/   /_/  \____/\____/_/_.___/\____/_/|_|  "
echo -e "${VIOLET}     /____/                                                        ${NC}"

# Nome do desenvolvedor
echo -e "${RED}Ferramentas e instalador escrito por ${NC}${GREEN}David A. Mascaro${NC}"

# Avisando ao usuário
echo -e "\n${RED}ATENÇÃO:${NC} Este script deve ser executado como root (sudo) para garantir a instalação adequada das ferramentas."

# DANDO UPDATE NO SISTEMA:
echo -e "\n${GREEN}Deseja realizar update dos pacotes APT do Kernel e atualizar o sistema?${NC}" "${RED}(s/n)${NC}"
read -r ress01

# LENDO A RESPOSTA:
if [ "$ress01" = "s" ]; then
    echo -e "${BLUE}Realizando update dos pacotes...${NC}"
    # EXECUTANDO COMANDO:
    sudo apt update && sudo apt full-upgrade -y
    clear
    # Verificando e instalando Python
    if ! [ -x "$(command -v python3)" ]; then
        echo -e "${GREEN}Instalando Python...${NC}"
        sudo apt install python3 -y
    fi

    # Verificando e instalando Git
    if ! [ -x "$(command -v git)" ]; then
        echo -e "${GREEN}Instalando Git...${NC}"
        sudo apt install git -y
    fi
elif [ "$ress01" = "n" ]; then
    echo -e "${VIOLET}Update ignorado!"
else
    clear
    echo -e "${RED}Comando Invalido!${NC}"
    exit 1
fi

# ISTALANDO MINHAS FERRAMENTAS:
echo -e "\n${GREEN}Quais ferramentas você deseja instalar?\n"
echo -e "${BLUE}[1] DDG-OSINT ${NC}(Ideal para Dorks e salvar links em larga escala)"
echo -e "${BLUE}[2] LUCYLEAKS ${NC}(Ideal para buscar vazamentos e salvar as hashes de senhas para uso posterior)"
echo -e "${BLUE}[3] Sair${NC}"
read -r ferramenta

case "$ferramenta" in
    1)
        # Instalar DDG-OSINT
        echo -e "${BLUE}Clonando o repositório DDG-OSINT...${NC}"
        git clone https://github.com/CyberPiratHacks/DDG-OSINT.git
        clear
        echo -e "${RED}Executando ferramenta...${NC}" 
        cd DDG-OSINT || exit
        python3 DDG-OSINT.py
        echo -e "${GREEN}DDG-OSINT instalado com sucesso!${NC}"
        ;;
    2)
        # Instalar LUCYLEAKS
        echo -e "${BLUE}Clonando o repositório LUCYLEAKS...${NC}"
        git clone https://github.com/CyberPiratHacks/lucyleaks02.git
        clear
        echo -e "${GREEN}LUCYLEAKS instalado com sucesso!${NC}"
        echo -e "${RED}Executando ferramenta...${NC}"
        cd lucyleaks02 || exit
        python3 lucyleaks.py
        ;;
    3)
        echo -e "${VIOLET}Saindo do script${NC}"
        ;;
    *)
        echo -e "${RED}Opção inválida! Saindo do script.${NC}"
        ;;
esac

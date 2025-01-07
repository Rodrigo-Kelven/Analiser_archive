#!/bin/bash

# So fiz este script para facilitar a verificacao de arquivos. -> "quando eu esqueco se eu criei/escrevi em tal arquivo tenho preguica de verificar"

# Função para verificar arquivos e diretórios
check_files() {
    local dir="$1"
    local indent="$2"
    local has_files=false

    # Percorre todos os arquivos e diretórios dentro do diretório atual
    for item in "$dir"/*; do
        if [ -d "$item" ]; then
            # Se for um diretório, imprime o nome do diretório
            echo "${indent}├── $(basename "$item")/"
            # Chama a função recursivamente com um nível de indentação maior
            check_files "$item" "${indent}│   "
        elif [ -f "$item" ]; then
            # Se for um arquivo, verifica se está vazio
            has_files=true
            if [ -s "$item" ]; then
                echo "${indent}├── $(basename "$item") (não vazio)"
            else
                echo "${indent}├── $(basename "$item") (vazio)"
            fi
        fi
    done

    # Verifica se a pasta contém arquivos
    if [ "$has_files" = false ]; then
        echo "${indent}└── A pasta '$(basename "$dir")' não contém arquivos."
    fi
}

# Verifica se um diretório foi passado como argumento
if [ -z "$1" ]; then
    echo "Uso: $0 <diretório>"
    exit 1
fi

# Chama a função de verificação
echo "$1/"
check_files "$1" ""

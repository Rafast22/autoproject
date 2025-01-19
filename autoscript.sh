#/bin/bash
CONFIG_FILE=config.ini

read_config() {
    local key=$1
    grep -oP "(?<=^${key}=).*" "$CONFIG_FILE"
}

PROJECTS=$(read_config "path" )
USE_STACK=$(read_config "use-stack")
PROJECTS_PATH=$(eval echo $PROJECTS)
cd $PROJECTS_PATH

while true; do
    if [[ -d "$PROJECTS_PATH" ]]; then
        # projects=$(find "$PROJECTS_PATH" -maxdepth 1 -type d | sed 's|^\./||')
        projects_list=$(find . -maxdepth 1 -type d | sed 's|^\./||' | grep -v '^\.$')
        break
    else
        echo "Erro: O diretório '$PROJECTS_PATH' não existe."
        mkdir $PROJECTS_PATH 
        cd $PROJECTS_PATH
    fi
done

selected_dir=$(echo "$projects_list" | rofi -dmenu -p "New Project")

if [ -n "$selected_dir" ]; then
    if ! echo "$projects_list" | grep -q "^$selected_dir$"; then
        mkdir $projects_expanded/$selected_dir
    fi
else
    exit 0
fi

code $projects_expanded/$selected_dir





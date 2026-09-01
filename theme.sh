#!/usr/bin/env bash
# ============================================================
# DEVOURY CLOUD — THEMES MODULE
# ============================================================

set -uo pipefail

# ────────────────────────────────────────────────────────────
# COLORS
# ────────────────────────────────────────────────────────────

CYAN='\033[1;36m'
BLUE='\033[1;34m'
PURPLE='\033[1;35m'
GREEN='\033[1;32m'
RED='\033[1;31m'
YELLOW='\033[1;33m'
WHITE='\033[1;37m'
GRAY='\033[0;37m'
DARK='\033[0;90m'
NC='\033[0m'

# ────────────────────────────────────────────────────────────
# HELPERS
# ────────────────────────────────────────────────────────────

pause() {
    echo
    read -rp " ${CYAN}➜${NC} Press Enter to continue..."
}

status() {
    if command -v blueprint >/dev/null 2>&1; then
        echo -e "${GREEN}● ONLINE${NC}"
    else
        echo -e "${RED}● OFFLINE${NC}"
    fi
}

# ────────────────────────────────────────────────────────────
# HEADER
# ────────────────────────────────────────────────────────────

header() {
    clear

    echo -e "${GREEN}"
    cat <<'EOF'
 ██████╗ ███████╗██╗   ██╗ ██████╗  ██████╗ ██╗   ██╗
 ██╔══██╗██╔════╝██║   ██║██╔═══██╗██╔═══██╗╚██╗ ██╔╝
 ██║  ██║█████╗  ██║   ██║██║   ██║██║   ██║ ╚████╔╝
 ██║  ██║██╔══╝  ╚██╗ ██╔╝██║   ██║██║   ██║  ╚██╔╝
 ██████╔╝███████╗ ╚████╔╝ ╚██████╔╝╚██████╔╝   ██║
 ╚═════╝ ╚══════╝  ╚═══╝   ╚═════╝  ╚═════╝    ╚═╝
EOF
    echo -e "${NC}"

    echo -e "              ${PURPLE}DEVOURY THEMES${NC}"
    echo -e "        ${GRAY}Pterodactyl Theme Manager${NC}"
    echo
}

# ────────────────────────────────────────────────────────────
# BUTTON
# ────────────────────────────────────────────────────────────

button() {
    local number="$1"
    local name="$2"

    printf " ${CYAN}╭──────────────────────────────────╮${NC}\n"
    printf " ${CYAN}│${NC} ${WHITE}[ %s ]${NC} %-25s ${CYAN}│${NC}\n" \
        "$number" "$name"
    printf " ${CYAN}╰──────────────────────────────────╯${NC}\n"
}

# ────────────────────────────────────────────────────────────
# MAIN MENU
# ────────────────────────────────────────────────────────────

main_menu() {

    while true; do

        header

        echo -e "${GRAY}╭──────────────────────────────────────────────────────────╮${NC}"
        printf "${GRAY}│${NC} ${WHITE}BLUEPRINT STATUS${NC} %-33s${GRAY}│${NC}\n" "$(status)"
        echo -e "${GRAY}╰──────────────────────────────────────────────────────────╯${NC}"

        echo
        echo -e "${WHITE}DEVOURY THEMES${NC}"
        echo -e "${GRAY}────────────────────────────────────────────────────────────${NC}"

        button "1" "Blueprint"
        button "2" "Themes"
        button "3" "Extensions"
        button "4" "Hyper V1"

        echo
        echo -e "${GRAY}────────────────────────────────────────────────────────────${NC}"
        echo -e " ${RED}[ 0 ]${NC} Exit"
        echo

        echo -ne "${CYAN}➜${NC} ${WHITE}Select an option:${NC} "
        read -r main

        case "$main" in

            1)
                blueprint_menu
                ;;

            2)
                launch_themes
                ;;

            3)
                launch_extensions
                ;;

            4)
                launch_hyper
                ;;

            0|exit|quit)
                clear
                echo
                echo -e "${PURPLE}DEVOURY THEMES${NC}"
                echo -e "${GRAY}Session closed.${NC}"
                echo
                exit 0
                ;;

            *)
                echo
                echo -e "${RED}✘ Invalid option.${NC}"
                sleep 1
                ;;

        esac

    done
}

# ────────────────────────────────────────────────────────────
# BLUEPRINT MENU
# ────────────────────────────────────────────────────────────

blueprint_menu() {

    while true; do

        header

        if command -v blueprint >/dev/null 2>&1; then
            installed=true
        else
            installed=false
        fi

        echo -e "${WHITE}BLUEPRINT${NC}"
        echo -e "${GRAY}────────────────────────────────────────────────────────────${NC}"

        if [ "$installed" = false ]; then

            echo -e " ${RED}Status:${NC} ${RED}● NOT INSTALLED${NC}"
            echo

            button "1" "Install Blueprint"
            button "0" "Back"

        else

            echo -e " ${GREEN}Status:${NC} ${GREEN}● INSTALLED${NC}"
            echo

            button "1" "Reinstall"
            button "2" "Update"
            button "3" "Information"
            button "4" "Version"
            button "5" "Uninstall"
            button "0" "Back"

        fi

        echo
        echo -ne "${CYAN}➜${NC} ${WHITE}Select an option:${NC} "
        read -r bp

        case "$bp" in

            1)
                if [ "$installed" = false ]; then

                    echo
                    echo -e "${CYAN}▶ Installing Blueprint...${NC}"

                    rm -f /etc/apt/keyrings/nodesource.gpg 2>/dev/null || true

                    bash <(curl -fsSL \
                    "https://raw.githubusercontent.com/nobita329/Nobita-Cloud/refs/heads/main/thame/install.sh")

                else

                    echo
                    echo -e "${CYAN}▶ Reinstalling Blueprint...${NC}"

                    yes | blueprint -rerun-install

                fi

                pause
                ;;

            2)
                echo
                echo -e "${CYAN}▶ Updating Blueprint...${NC}"

                yes | blueprint -upgrade

                pause
                ;;

            3)
                echo
                blueprint -info
                pause
                ;;

            4)
                echo
                blueprint -version
                pause
                ;;

            5)
                echo
                echo -e "${RED}▶ Uninstalling Blueprint...${NC}"
                echo

                path="$(command -v blueprint 2>/dev/null || true)"

                if [ -n "$path" ]; then

                    systemctl stop pterodactyl-queue 2>/dev/null || true

                    rm -f "$path"

                    rm -rf ~/.blueprint
                    rm -rf ~/.config/blueprint
                    rm -rf /var/www/pterodactyl/.blueprint

                    rm -rf /var/www/pterodactyl/app/BlueprintFramework
                    rm -rf /var/www/pterodactyl/extensions

                    rm -rf /etc/blueprint
                    rm -f /etc/systemd/system/blueprint* 2>/dev/null

                    systemctl daemon-reload 2>/dev/null || true

                    echo
                    echo -e "${GREEN}✔ Blueprint removed.${NC}"

                else

                    echo -e "${RED}Blueprint is not installed.${NC}"

                fi

                pause
                ;;

            0)
                break
                ;;

            *)
                echo -e "${RED}Invalid option.${NC}"
                sleep 1
                ;;

        esac

    done
}

# ────────────────────────────────────────────────────────────
# THEMES
# ────────────────────────────────────────────────────────────

launch_themes() {

    header

    echo -e "${CYAN}▶ Opening DEVOURY Theme Library...${NC}"
    echo

    bash <(curl -fsSL \
    "https://raw.githubusercontent.com/nobita329/Nobita-Cloud/refs/heads/main/thame/thames.sh")

    pause
}

# ────────────────────────────────────────────────────────────
# EXTENSIONS
# ────────────────────────────────────────────────────────────

launch_extensions() {

    header

    echo -e "${CYAN}▶ Opening DEVOURY Extensions...${NC}"
    echo

    bash <(curl -fsSL \
    "https://raw.githubusercontent.com/nobita329/Nobita-Cloud/refs/heads/main/thame/Extension2.sh")

    pause
}

# ────────────────────────────────────────────────────────────
# HYPER V1
# ────────────────────────────────────────────────────────────

launch_hyper() {

    header

    echo -e "${PURPLE}▶ Launching Hyper V1...${NC}"
    echo

    wget -q -O installer.sh \
    "https://r2.rolexdev.tech/hyperv1/installer.sh"

    chmod +x installer.sh

    sudo ./installer.sh

    rm -f installer.sh

    if [ -d "/var/www/pterodactyl" ]; then

        cd /var/www/pterodactyl || return

        php artisan view:clear
        php artisan config:clear

        chown -R www-data:www-data /var/www/pterodactyl/*

        php artisan queue:restart

    fi

    echo
    echo -e "${GREEN}✔ Hyper V1 finished.${NC}"

    pause
}

# ────────────────────────────────────────────────────────────
# START
# ────────────────────────────────────────────────────────────

main_menu

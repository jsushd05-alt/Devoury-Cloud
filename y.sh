#!/usr/bin/env bash
# ============================================================
# DEVOURY CLOUD — NEXT GEN SERVER MANAGER
# Main Launcher
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
# MODULE LINKS
# Replace these with your actual module URLs
# ────────────────────────────────────────────────────────────

VPS_URL="https://raw.githubusercontent.com/nobita329/Nobita-Cloud/refs/heads/main/setup%20vm/menu.sh"
PANEL_URL="https://raw.githubusercontent.com/nobita329/Nobita-Cloud/refs/heads/main/panel/1.sh"
WINGS_URL="https://raw.githubusercontent.com/nobita329/Nobita-Cloud/refs/heads/main/wings/run.sh"
TOOLBOX_URL="https://raw.githubusercontent.com/nobita329/ptero/refs/heads/main/ptero/tools/run.sh"
THEMES_URL="https://raw.githubusercontent.com/nobita329/Nobita-Cloud/refs/heads/main/thame/run.sh"
SYSTEM_URL="https://raw.githubusercontent.com/nobita329/The-Coding-Hub/refs/heads/main/srv/menu/System1.sh"
CONTAINER_URL="https://raw.githubusercontent.com/nobita329/ptero/refs/heads/main/ptero/no-kvm/run.sh"

# ────────────────────────────────────────────────────────────
# SYSTEM METRICS
# ────────────────────────────────────────────────────────────

get_metrics() {

    HOSTNAME_NOW="$(hostname 2>/dev/null || echo "Unknown")"

    CPU="$(top -bn1 2>/dev/null |
        awk '/Cpu\(s\)/ {
            printf "%.0f", $2 + $4r
            exist 
        }')"

    RAM="$(free 2>/dev/null |
        awk '/Mem:/ {
            printf "%.0f", ($3/$2)*100
            exit
        }')"

    DISK="$(df -h / 2>/dev/null |
        awk 'NR==2 {
            print $5
            exit
        }')"

    UPTIME="$(uptime -p 2>/dev/null |
        sed 's/^up //' || echo "Unknown")"

    [[ -z "$CPU" ]] && CPU="--"
    [[ -z "$RAM" ]] && RAM="--"
    [[ -z "$DISK" ]] && DISK="--"
    [[ -z "$UPTIME" ]] && UPTIME="Unknown"
}

# ────────────────────────────────────────────────────────────
# BUTTON
# ────────────────────────────────────────────────────────────

button() {

    local number="$1"
    local title="$2"

    printf "  ${CYAN}╭──────────────────────────────╮${NC}\n"

    printf "  ${CYAN}│${NC} ${WHITE}[ %s ]${NC} ${WHITE}%-22s${NC} ${CYAN}│${NC}\n" \
        "$number" "$title"

    printf "  ${CYAN}╰──────────────────────────────╯${NC}\n"
}

# ────────────────────────────────────────────────────────────
# HEADER
# ────────────────────────────────────────────────────────────

draw_header() {

    echo -e "${GREEN}"

    cat <<'EOF'
 ██████╗ ███████╗██╗   ██╗ ██████╗   ██████╗ ██╗   ██╗
 ██╔══██╗██╔════╝██║   ██║██╔═══██╗ ██╔══██╗╚██╗ ██╔╝
 ██║  ██║█████╗  ██║   ██║██║     ██║ ██████╔╝ ╚████╔╝
 ██║  ██║██╔══╝  ╚██╗ ██╔╝██║    ██║ ██╔══██╗   ╚██╔╝
 ██████╔╝███████╗ ╚████╔╝ ╚██████╔╝ ██║  ██║    ██║
 ╚═════╝ ╚══════╝  ╚═══╝   ╚═════╝   ╚═╝  ╚═╝    ╚═╝
EOF

    echo -e "${NC}"

    echo -e "             ${PURPLE}DEVOURY CLOUD${NC}"
    echo -e "       ${GRAY}Next Generation Server Management${NC}"

    echo
}

# ────────────────────────────────────────────────────────────
# DASHBOARD
# ────────────────────────────────────────────────────────────

draw_dashboard() {

    get_metrics

    clear

    draw_header

    echo -e "${GRAY}╭──────────────────────────────────────────────────────────────╮${NC}"

    printf "${GRAY}│${NC} ${WHITE}HOST${NC} %-18s ${GRAY}│${NC} ${WHITE}STATUS${NC} ${GREEN}● ONLINE${NC} ${GRAY}│${NC}\n" \
        "$HOSTNAME_NOW"

    echo -e "${GRAY}╰──────────────────────────────────────────────────────────────╯${NC}"

    echo

    echo -e "${WHITE}SYSTEM OVERVIEW${NC}"
    echo -e "${GRAY}──────────────────────────────────────────────────────────────${NC}"

    printf " ${CYAN}CPU${NC}     ${WHITE}%s%%${NC}     ${PURPLE}RAM${NC}     ${WHITE}%s%%${NC}     ${GREEN}DISK${NC}     ${WHITE}%s${NC}\n" \
        "$CPU" "$RAM" "$DISK"

    printf " ${YELLOW}UPTIME${NC}  ${WHITE}%s${NC}\n" "$UPTIME"

    echo

    echo -e "${WHITE}DEVOURY SERVICES${NC}"
    echo -e "${GRAY}──────────────────────────────────────────────────────────────${NC}"

    button "1" "VPS"
    button "2" "PANEL"
    button "3" "WINGS"
    button "4" "TOOLBOX"

    echo

    button "5" "THEMES"
    button "6" "SYSTEM"
    button "7" "CONTAINER"

    echo

    echo -e "${GRAY}──────────────────────────────────────────────────────────────${NC}"

    echo -e " ${RED}[ 0 ]${NC} Exit"

    echo

    echo -ne "${CYAN}➜${NC} ${WHITE}Select an option:${NC} "
}

# ────────────────────────────────────────────────────────────
# RUN MODULE
# ────────────────────────────────────────────────────────────

run_module() {

    local url="$1"

    clear

    echo -e "${CYAN}╭────────────────────────────────────────────╮${NC}"
    echo -e "${CYAN}│${NC} ${WHITE}DEVOURY CLOUD${NC} ${GRAY}→ Launching module${NC} ${CYAN}│${NC}"
    echo -e "${CYAN}╰────────────────────────────────────────────╯${NC}"

    echo

    if [[ "$url" == "https://example.com/"* ]]; then

        echo -e "${YELLOW}Module URL has not been configured yet.${NC}"
        echo -e "${GRAY}Edit the *_URL variables at the top of devoury.sh.${NC}"

        echo

        read -rp "Press Enter to return..."

        return
    fi

    if ! command -v curl >/dev/null 2>&1; then

        echo -e "${RED}curl is not installed.${NC}"

        read -rp "Press Enter to return..."

        return
    fi

    echo -e "${GRAY}Fetching module...${NC}"
    echo

    tmp="$(mktemp)"

    if curl -fsSL "$url" -o "$tmp"; then

        bash "$tmp"

    else

        echo -e "${RED}Failed to download module.${NC}"

    fi

    rm -f "$tmp"

    echo

    read -rp "Press Enter to return to DEVOURY CLOUD..."
}

# ────────────────────────────────────────────────────────────
# MAIN LOOP
# ────────────────────────────────────────────────────────────

while true; do

    draw_dashboard

    read -r option

    case "$option" in

        1)
            run_module "$VPS_URL"
            ;;

        2)
            run_module "$PANEL_URL"
            ;;

        3)
            run_module "$WINGS_URL"
            ;;

        4)
            run_module "$TOOLBOX_URL"
            ;;

        5)
            run_module "$THEMES_URL"
            ;;

        6)
            run_module "$SYSTEM_URL"
            ;;

        7)
            run_module "$CONTAINER_URL"
            ;;
            
        0|exit|quit)

            clear

            echo
            echo -e "${CYAN}DEVOURY CLOUD${NC}"
            echo -e "${GRAY}Session closed.${NC}"
            echo

            exit 0
            ;;

        *)

            echo
            echo -e "${RED}Invalid option.${NC}"
            sleep 1
            ;;

    esac

done

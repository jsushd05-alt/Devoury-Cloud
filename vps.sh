#!/bin/bash

# ============================================================
# DEVOURY CLOUD — DEVELOPMENT MENU
# ============================================================

# COLORS
R='\033[1;31m'
G='\033[1;32m'
Y='\033[1;33m'
B='\033[1;34m'
P='\033[1;35m'
C='\033[1;36m'
W='\033[1;37m'
D='\033[0;90m'
N='\033[0m'

# ============================================================
# BUTTON
# ============================================================

button() {
    local number="$1"
    local title="$2"

    printf "  ${C}╭──────────────────────────────╮${N}\n"
    printf "  ${C}│${N} ${W}[ %s ] %-22s${C}│${N}\n" "$number" "$title"
    printf "  ${C}╰──────────────────────────────╯${N}\n"
}

# ============================================================
# PAUSE
# ============================================================

pause() {
    echo
    read -rp "Press Enter to continue..."
}

# ============================================================
# STATUS
# ============================================================

status_msg() {
    local text="$1"
    local color="$2"

    echo
    echo -e "${color}${text}${N}"
    echo
}

# ============================================================
# HEADER
# ============================================================

draw_header() {

    clear

    echo -e "${G}"

    cat <<'EOF'
 ██████╗ ███████╗██╗   ██╗ ██████╗   ██████╗ ██╗   ██╗
 ██╔══██╗██╔════╝██║   ██║██╔═══██╗ ██╔══██╗╚██╗ ██╔╝
 ██║  ██║█████╗  ██║   ██║██║     ██║ ██████╔╝ ╚████╔╝
 ██║  ██║██╔══╝  ╚██╗ ██╔╝██║    ██║ ██╔══██╗   ╚██╔╝
 ██████╔╝███████╗ ╚████╔╝ ╚██████╔╝ ██║  ██║    ██║
 ╚═════╝ ╚══════╝  ╚═══╝   ╚═════╝   ╚═╝  ╚═╝    ╚═╝
EOF

    echo -e "${N}"

    echo -e "             ${P}DEVOURY CLOUD${N}"
    echo -e "          ${D}Development Menu${N}"
    echo
}

# ============================================================
# MAIN MENU
# ============================================================

while true; do

    draw_header

    echo -e "${D}────────────────────────────────────────────────────────────${N}"
    echo -e "${W}DEVELOPMENT SERVICES${N}"
    echo -e "${D}────────────────────────────────────────────────────────────${N}"
    echo

    button "1" "RDX Tool"
    button "2" "VM 1 KVM"
    button "3" "VM 2 NO KVM"
    button "4" "VM 3 ALL SETUP"

    echo

    echo -e "${D}────────────────────────────────────────────────────────────${N}"
    echo -e " ${R}[ 0 ]${N} Exit"
    echo

    echo -ne "${C}➜${N} ${W}Select an option:${N} "
    read -r op

    case "$op" in

        # ====================================================
        # RDX TOOL
        # ====================================================

        1)
            clear

            status_msg "🔧 Running RDX Tool Setup..." "$Y"

            echo -e "${D}────────────────────────────────────────────────────────────${N}"
            echo

            echo -e "${C}Cleaning old files...${N}"

            cd || exit
            rm -rf myapp
            rm -rf flutter

            cd vm 2>/dev/null || {
                echo -e "${R}vm directory not found.${N}"
                pause
                continue
            }

            if [ ! -d ".idx" ]; then

                echo -e "${C}Creating .idx directory...${N}"
                mkdir .idx
                cd .idx || continue

                echo -e "${C}Creating dev.nix...${N}"

                cat <<'EOF' > dev.nix
{ pkgs, ... }: {
  channel = "stable-24.05";

  packages = with pkgs; [
    unzip
    openssh
    git
    qemu_kvm
    sudo
    cdrkit
    cloud-utils
    qemu
  ];

  env = {
    EDITOR = "nano";
  };

  idx = {
    extensions = [
      "Dart-Code.flutter"
      "Dart-Code.dart-code"
    ];

    workspace = {
      onCreate = { };
      onStart = { };
    };

    previews = {
      enable = false;
    };
  };
}
EOF

                echo
                echo -e "${G}RDX Tool setup complete.${N}"

            else

                echo -e "${Y}.idx already exists — skipping.${N}"

            fi

            pause
            ;;

        # ====================================================
        # VM 1 KVM
        # ====================================================

        2)
            clear

            status_msg "Starting VM 1 KVM..." "$B"

            echo -e "${C}Fetching VM script...${N}"
            echo

            bash <(
                curl -fsSL \
                "https://raw.githubusercontent.com/nobita329/Nobita-Cloud/refs/heads/main/setup%20vm/vm-1.sh"
            )

            pause
            ;;

        # ====================================================
        # VM 2 NO KVM
        # ====================================================

        3)
            clear

            status_msg "Starting VM 2 NO KVM..." "$B"

            echo -e "${C}Fetching VM script...${N}"
            echo

            bash <(
                curl -fsSL \
                "https://raw.githubusercontent.com/nobita329/Nobita-Cloud/refs/heads/main/setup%20vm/vm-2.sh"
            )

            pause
            ;;

        # ====================================================
        # VM 3 ALL SETUP
        # ====================================================

        4)
            clear

            status_msg "Starting VM 3 ALL SETUP..." "$B"

            echo -e "${C}Fetching VM script...${N}"
            echo

            bash <(
                curl -fsSL \
                "https://raw.githubusercontent.com/nobita329/Nobita-Cloud/refs/heads/main/setup%20vm/vm-3.sh"
            )

            pause
            ;;

        # ====================================================
        # EXIT
        # ====================================================

        0)
            clear

            echo
            echo -e "${C}DEVOURY CLOUD${N}"
            echo -e "${D}Development Menu closed.${N}"
            echo

            exit 0
            ;;

        *)
            echo
            echo -e "${R}Invalid option.${N}"
            sleep 1
            ;;

    esac

done

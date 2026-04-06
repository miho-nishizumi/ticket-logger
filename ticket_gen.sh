#!/bin/bash

GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
NC='\033[0m' 

while true; do
    clear
    echo -e "${CYAN}--------------------------------------${NC}"
    echo -e "${YELLOW}   OPERATION ONE TICKET GENERATOR     ${NC}"
    echo -e "${CYAN}--------------------------------------${NC}"

    echo -n -e "\n${GREEN}Step 0:${NC} Enter Ticket ID (Press Enter for 'EC'): "
    read input_id
    if [ -z "$input_id" ]; then
        ticket_id="EC"
    else
        ticket_id="$input_id"
    fi

    echo -n -e "${GREEN}Step 1:${NC} Enter Roblox User ID: "
    read userid

    echo -e "\n${GREEN}Step 2:${NC} Select Platform:"
    options=("Roblox" "Discord")
    select platform in "${options[@]}"; do
        case $platform in
            "Roblox"|"Discord") break ;;
            *) echo "Invalid selection, try again." ;;
        esac
    done

    echo -e "\n${GREEN}Step 3:${NC} Select Violation Reason:"
    reasons=(
        "Cheating/Exploiting" 
        "Griefing" 
        "Inappropriate display/loadout/username" 
        "Cheating servers"
        "Cheating by own admission"
        "Custom"
    )

    is_perm=false
    select reason_choice in "${reasons[@]}"; do
        case $reason_choice in
            "Cheating/Exploiting")
                base_reason="Reported and investigated for cheating."
                is_perm=true
                break ;;
            "Griefing")
                base_reason="Reported and investigated for griefing."
                break ;;
            "Inappropriate display/loadout/username")
                base_reason="Reported for inappropriate user content."
                break ;;
            "Cheating servers")
                base_reason="Reported and investigated for being in cheating servers."
                is_perm=true
                break ;;
            "Cheating by own admission")
                base_reason="Reported and investigated for cheating by own admission."
                break ;;
            "Custom")
                echo -n -e "\n${YELLOW}Enter custom reason:${NC} "
                read base_reason
                break ;;
            *) echo "Invalid selection, try again." ;;
        esac
    done

    if [ "$is_perm" = true ]; then
        duration="Permanent"
        hr_val=""
        warning=""
    else
        echo -e "\n${GREEN}Step 4:${NC} Select Punishment Duration:"
        durations=("24 Hours" "3 Days" "7 Days" "Permanent")
        select duration in "${durations[@]}"; do
            case $duration in
                "24 Hours")
                    hr_val="24"
                    warning=" Repeat offenses may result in permanent suspension."
                    break ;;
                "3 Days")
                    hr_val="72"
                    warning=" Repeat offenses may result in permanent suspension."
                    break ;;
                "7 Days")
                    hr_val="168"
                    warning=" Repeat offenses may result in permanent suspension."
                    break ;;
                "Permanent")
                    hr_val=""
                    warning=""
                    break ;;
                *) echo "Invalid selection, try again." ;;
            esac
        done
    fi

    final_phrase="${base_reason}${warning} ID: ${ticket_id}"

    clear
    echo -e "${YELLOW}--- GENERATED TICKET CONTENT ---${NC}"
    echo "--------------------------------"
    echo "Ticket Reference: $ticket_id"
    echo "Target User ID: $userid"
    echo "Platform: $platform"
    echo "Reason: $reason_choice"
    echo "Details: $final_phrase"
    echo "Punishment Length: $duration"
    echo "Evidence: "
    echo "--------------------------------"

    if [ "$platform" == "Roblox" ]; then
        echo -e "${GREEN}Generated Admin Command:${NC}"
        if [ -z "$hr_val" ]; then
            echo "ban/$userid/$final_phrase"
        else
            echo "ban/$userid/$final_phrase/$hr_val"
        fi
        echo "--------------------------------"
    fi

    echo -e "\n${CYAN}Ticket generated successfully.${NC}"
    
    echo -n -e "\nWould you like to make another ticket? Y/n: "
    read run_again
    
    # Convert input to lowercase for comparison
    run_again_lower=$(echo "$run_again" | tr '[:upper:]' '[:lower:]')
    
    if [[ "$run_again_lower" == "n" ]]; then
        echo "Exiting..."
        break
    fi
done

#!/bin/bash
# Author: David Durá Vilches  (aka cyberhacktowelie)
#Colours by S4vitaar
declare -r greenColour="\e[0;32m\033[1m"
declare -r endColour="\033[0m\e[0m"
declare -r redColour="\e[0;31m\033[1m"
declare -r blueColour="\e[0;34m\033[1m"
declare -r yellowColour="\e[0;33m\033[1m"
declare -r purpleColour="\e[0;35m\033[1m"
declare -r turquoiseColour="\e[0;36m\033[1m"
declare -r grayColour="\e[0;37m\033[1m"

trap ctrl_c INT

function ctrl_c(){
    tput cnorm
    echo -e "\n\n${redColour}[!] Exiting...${endColour}"
    exit 1
}


function banner(){
        echo -e "${blueColour}

                               @@@@@@@@@@@@@@@@@@@
                       @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
                  @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@&@@@@@@@@@
              @@@@@@@@  @@@@@@@(       @@       @@@@@@@@   @@@@@@@@             
           @@@@@@(    @@@@@@       @@@@@@@@@@@     (@@@@@&     (@@@@@@          
        @@@@@@       @@@@@          ,,,@@,,,,,,@@#   ,@@@@@        @@@@@@       
      @@@@@*        @@@@@            @@@@@@@,,,,,,@(   @@@@@         *@@@@@     
    @@@@@          @@@@@   @          ,@@,,,,@@,,,,@@   @@@@@           @@@@@   
  @@@@@            @@@@/  *@,,,,@&   @@@@@@,,,@@,,,,@   @@@@@             @@@@@ 
 @@@@@             @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@              @@@@@
   @@@@@           @@@@@   @,,,,(@,,,,,@@,,,,*@,,,,&@   @@@@@            @@@@@  
     @@@@@         @@@@@.   @,,,,,@@@,,@@,,@@(,,,,&@   @@@@@           @@@@@    
       @@@@@        @@@@@%   @@,,,,,,,,@@,,,,,,,%@(   @@@@@*        .@@@@@      
         @@@@@@      *@@@@@     @@@,,,,@@,,,,@@@    %@@@@@        @@@@@@        
            @@@@@@@    @@@@@@@        /@@/        @@@@@@#     @@@@@@@           
               @@@@@@@@( *@@@@@@@@&    @@    @@@@@@@@@   (@@@@@@@@
                   (@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@(
                         @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
                                    #&@@@@@&#.${endColour}


      @@@@@     %@@@@@@  @@@@@@@      @@@@@@%       @@@@@       @@@@@@@@@@@@    
        @@@@&     #@@      @@@@@@    @@@@@@        @@@.@@@        @@@@   @@@@@  
        @@  @@    #@@      @@@@@@@  @@@@@@@       @@@@ @@@@       @@@@    @@@@  
        @@   @@@  #@@      @@@&,@@@@@@ @@@@      @@@@@@@@@@@      @@@@@@@@@@@   
        @@     @@@#@@     &@@@  #@@@@  %@@@.    @@@@....,@@@&     @@@@          
        @@       @@@@   (@@@@@@@      @@@@@@@ @@@@@@@   @@@@@@@ @@@@@@@@        
      %%%%%%      /%%   *%%%%%%%      %%%%%%% %%%%%%%   %%%%%%# %%%%%%%%        \n"


    for i in $(seq 1 80); do echo -ne "${redColour}-"; done; echo -ne "${endColour}"
}

 function nmapIPAddress(){
    ipAddress=$1
    echo nmap -n -sS $ipAddress
    nmap -n -sS $ipAddress
 }
 function nmapMyPublicIPAddress(){
    ipAddress=$(curl ipinfo.io/ip  2> /dev/null)
    echo nmap -n -sS $ipAddress
    nmap -n -sS $ipAddress
 }
 function nmapMyPrivateIPAddress(){
    ipAddress=$(hostname -I | awk '{print $1}')
    echo nmap -n -sS $ipAddress
    nmap -n -sS $ipAddress
 }

function helpPanel(){
    banner
    echo -e "\n${redColour}[!] Usage: ./ipScanner${endColour}"
    for i in $(seq 1 80); do echo -ne "${redColour}-"; done; echo -ne "${endColour}"
        echo -e "\n\n\t${grayColour}[-a]${endColour}${yellowColour} Nmap myself${endColour}"
            echo -e "\t\t${purpleColour}public${endColour}${yellowColour}:\t\t\t Public IP${endColour}"
            echo -e "\t\t${purpleColour}private${endColour}${yellowColour}:\t\t Private IP${endColour}"
        echo -e "\t${grayColour}[-i]${endColour}${yellowColour} Nmap by IP Address${endColour} ${blueColour}\t\t${endCo>
}

parameter_counter=0
tput civis; while getopts ":a:i:h:" arg; do
    case $arg in
        a) auto_mode=$OPTARG && let parameter_counter+=1;;
        i) ip_address=$OPTARG && let parameter_counter+=1;;
        h) helpPanel;;
    esac
done

if [ "$parameter_counter" == "0" ]; then
    helpPanel;
fi

if [ $ip_address ]; then
    nmapIPAddress $ip_address
fi

if [ $auto_mode ]; then
    if [ "$(echo $auto_mode)" == "public" ]; then
        nmapMyPublicIPAddress;
    elif [ "$(echo $auto_mode)" == "private" ]; then
        nmapMyPrivateIPAddress;
    else
        helpPanel;
    fi

else
    helpPanel;
fi

tput cnorm;
exit 0



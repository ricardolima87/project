#!/bin/bash
# Infrastructure Team - LBSLOCAL
# infra@lbslocal.com

file=~/git/scripts-infra/default.rb
  
  echo "\033[1;32mAxiodis -  Shared Apache VirtualHost Creation Tool\033[0m"
  echo "\n"
  read -p "Enter the Client Name: " clientname

client_upper=$(echo $clientname | awk '{print toupper($0)}')

result="default[\"apache2-axiodis\"][\"sites\"][\"$clientname\"] = { \"port_http\" => 80, \"port_https\" => 443, \"servername\" => \"$clientname-axiodis.maplink.global\", \"app_workername\" => \"axiodis${client_upper}appWorker\", \"cal_workername\" => \"axiodis${client_upper}calWorker\" }"
  
  echo "\n"
  echo "\033[1;33mRESULT:\033[0m"
  
  echo ${result}
  echo "\n"
  read -p "Confirm? (y/n) " -n 1
    if [[ ! $REPLY =~ ^[Yy]$ ]]
    then
      echo ""
      echo "\033[1;31mAborted by user...\033[0m"
      exit 1
    fi
  echo ""
  echo ${result} >> ${file}

file=~/git/scripts-infra/workers.properties

  read -p "Enter the App IP Server: " app_ip
  read -p "Enter the MWS IP Server: " mws_ip

  echo "\nworker.axiodis${client_upper}appWorker.type=ajp13\nworker.axiodis${client_upper}appWorker.host=${app_ip}\nworker.axiodis${client_upper}appWorker.port=8009\nworker.axiodis${client_upper}appWorker.retries=6\nworker.axiodis${client_upper}appWorker.socket_keepalive=1\nworker.axiodis${client_upper}appWorker.socket_timeout=30\nworker.axiodis${client_upper}appWorker.reply_timeout=3600000\n\nworker.axiodis${client_upper}calWorker.type=ajp13\nworker.axiodis${client_upper}calWorker.host=${mws_ip}\nworker.axiodis${client_upper}calWorker.port=8009\nworker.axiodis${client_upper}calWorker.retries=6\nworker.axiodis${client_upper}calWorker.socket_keepalive=1\nworker.axiodis${client_upper}calWorker.socket_timeout=30\nworker.axiodis${client_upper}calWorker.reply_timeout=3600000" >> ${file}
  
  echo "\033[1;32mDone!\033[0m" 

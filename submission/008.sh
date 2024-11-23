# Which public key signed input 0 in this tx:
#   `e5969add849689854ac7f28e45628b89f7454b83e9699e551ce14b6f90c86163`

# Identifiquei que se trata de um #P2WSH com uma condicional (if)

txid="e5969add849689854ac7f28e45628b89f7454b83e9699e551ce14b6f90c86163"

witness=$(bitcoin-cli getrawtransaction $txid true)

pubkeys=$(echo $witness | jq -r '.'vin[0].txinwitness[-1] | grep -Eo '02[0-9A-Fa-f]{64}')
condition=$(echo $witness | jq -r '.'vin[0].txinwitness[-2]) # resultado da condicional

if [ "$condition" == "01" ]; then
    echo $(echo $pubkeys | awk '{print $1}')
else
     echo $(echo $pubkeys | awk '{print $2}')
fi





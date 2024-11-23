# Only one single output remains utxo from block 123,321. What address was it sent to?
blockhash=$(bitcoin-cli getblockhash 123321)
txids=$(bitcoin-cli getblock "$blockhash" | jq -r '.tx[]')

for txid in $txids; do
    vout_count=$(bitcoin-cli getrawtransaction "$txid" true | jq '.vout | length')
    for (( n=0; n<$vout_count; n++ )); do
       voutAddres=$(bitcoin-cli gettxout "$txid" $n | jq -r '.scriptPubKey.address' )
       if [ -n "$voutAddres" ]; then
            echo $voutAddres
            break 2
        fi
    done
done

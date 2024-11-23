# Which tx in block 257,343 spends the coinbase output of block 256,128?
blockHeight=256128
blockHash=$(bitcoin-cli getblockhash $blockHeight)
coinbaseTxid=$(bitcoin-cli getblock $blockHash | jq -r '.tx[0]')

blockHeight2=257343
blockHash2=$(bitcoin-cli getblockhash $blockHeight2)
txids=$(bitcoin-cli getblock $blockHash2 | jq -r '.tx[]')

for txid in $txids; do
    vin_txids=$(bitcoin-cli getrawtransaction $txid true | jq -r '.vin[].txid')
    for vin_txid in $vin_txids; do
        if [ "$vin_txid" == "$coinbaseTxid" ]; then
            echo  $txid
            break 2
        fi
    done
done








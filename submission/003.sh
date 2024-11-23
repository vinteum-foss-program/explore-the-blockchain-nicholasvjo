# How many new outputs were created by block 123,456?
hash=$(bitcoin-cli getblockhash 123456)
blockInfo=$(bitcoin-cli getblock $hash 2)

echo $blockInfo | jq '[.tx[].vout[]] | length'
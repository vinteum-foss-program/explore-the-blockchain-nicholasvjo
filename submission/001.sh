# What is the hash of block 654,321?
blockHeight=654321
hash=$(bitcoin-cli getblockhash $blockHeight)
echo $hash
# How many new outputs were created by block 123,456?
BLOCK_HEIGHT=123456
BLOCK_HASH=$(bitcoin-cli getblockhash $BLOCK_HEIGHT)
BLOCK_DATA=$(bitcoin-cli getblock $BLOCK_HASH 2)
NEW_OUTPUTS=$(echo "$BLOCK_DATA" | jq '[.tx[].vout | length] | add')
echo "$NEW_OUTPUTS"

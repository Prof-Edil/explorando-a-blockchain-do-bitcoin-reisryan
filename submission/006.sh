# Which tx in block 257,343 spends the coinbase output of block 256,128?
GET_BLOCK="$(bitcoin-cli -rpcconnect=84.247.182.145:8332 -rpcuser=user_259 -rpcpassword=CsaSE6fmbyP0 getblock 256128 2)"
TXID=$(echo "$GET_BLOCK" | jq -r '.tx[0].txid')
TXS=$(bitcoin-cli -rpcconnect=84.247.182.145:8332 -rpcuser=user_259 -rpcpassword=CsaSE6fmbyP0 getblock 257343 2)
INPUT_TX=$(echo "$TXS" | jq -r --arg TXID "$TXID" '.tx[] | select(.vin[].txid == $TXID) | .txid')
echo "$INPUT_TX"

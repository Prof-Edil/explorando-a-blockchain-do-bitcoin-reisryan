# Which tx in block 257,343 spends the coinbase output of block 256,128?
GET_HASH1="$(bitcoin-cli -rpcconnect=84.247.182.145:8332 -rpcuser=user_259 -rpcpassword=CsaSE6fmbyP0 getblockhash 256128)"
GET_BLOCK="$(bitcoin-cli -rpcconnect=84.247.182.145:8332 -rpcuser=user_259 -rpcpassword=CsaSE6fmbyP0 getblock "$GET_HASH1" 2)"
TXID=$(echo "$GET_BLOCK" | jq -r '.tx[0].txid')
GET_HASH2="$(bitcoin-cli -rpcconnect=84.247.182.145:8332 -rpcuser=user_259 -rpcpassword=CsaSE6fmbyP0 getblockhash 257343)"
TXS=$(bitcoin-cli -rpcconnect=84.247.182.145:8332 -rpcuser=user_259 -rpcpassword=CsaSE6fmbyP0 getblock "$GET_HASH2" 2)
INPUT_TX=$(echo "$TXS" | jq -r --arg TXID "$TXID" '.tx[] | select(.vin[].txid == $TXID) | .txid')
echo "$INPUT_TX"

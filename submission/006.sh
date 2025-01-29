# Which tx in block 257,343 spends the coinbase output of block 256,128?
GET_BLOCK="$(bitcoin-cli -rpcconnect=84.247.182.145:8332 -rpcuser=user_259 -rpcpassword=CsaSE6fmbyP0 getblock 256128 2)"
echo "$GET_BLOCK"

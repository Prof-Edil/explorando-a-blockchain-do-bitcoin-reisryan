# Which public key signed input 0 in this tx:
#   `e5969add849689854ac7f28e45628b89f7454b83e9699e551ce14b6f90c86163`
TXID="e5969add849689854ac7f28e45628b89f7454b83e9699e551ce14b6f90c86163"
SCRIPT=$(bitcoin-cli -rpcconnect=84.247.182.145:8332 -rpcuser=user_259 -rpcpassword=CsaSE6fmbyP0 getrawtransaction "$TXID" true | jq -r '.vin[0].txinwitness[2]')
PUBKEY=$(echo "$SCRIPT" | cut -c7-72)
echo "$PUBKEY"

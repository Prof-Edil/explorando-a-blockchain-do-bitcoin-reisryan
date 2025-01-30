# Which public key signed input 0 in this tx:
#   `e5969add849689854ac7f28e45628b89f7454b83e9699e551ce14b6f90c86163`
TXID="e5969add849689854ac7f28e45628b89f7454b83e9699e551ce14b6f90c86163"
PUBKEY=$(bitcoin-cli getrawtransaction "$TXID" true | jq -r '.vin[0].scriptSig.asm' | awk '{print $2}')
echo "$PUBKEY"

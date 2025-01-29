# Create a 1-of-4 P2SH multisig address from the public keys in the four inputs of this tx:
#   `37d966a263350fe747f1c606b159987545844a493dd38d84b070027a895c4517`
TXID="37d966a263350fe747f1c606b159987545844a493dd38d84b070027a895c4517"
RAW_TX=$(bitcoin-cli getrawtransaction "$TXID" true)
PUBKEYS=$(echo "$RAW_TX" | jq -r '.vin[].scriptSig.asm' | grep -Eo "[0-9a-f]{66,130}")
PUBKEY_ARRAY=($(echo "$PUBKEYS" | head -n 4))
PUBKEY_JSON=$(printf '"%s",' "${PUBKEY_ARRAY[@]}")
PUBKEY_JSON="[${PUBKEY_JSON%,}]"
MULTISIG=$(bitcoin-cli createmultisig 1 "$PUBKEY_JSON")
P2SH_ADDRESS=$(echo "$MULTISIG" | jq -r '.address')
echo "$P2SH_ADDRESS"

# Only one single output remains unspent from block 123,321. What address was it sent to?
BHASH="$(bitcoin-cli -rpcconnect=84.247.182.145:8332 -rpcuser=user_259 -rpcpassword=CsaSE6fmbyP0 getblockhash 123321)"
BDATA="$(bitcoin-cli -rpcconnect=84.247.182.145:8332 -rpcuser=user_259 -rpcpassword=CsaSE6fmbyP0 getblock "$BHASH" 2)"

echo "$BDATA" | jq -r '.tx[].txid' | while read -r TX; do
  TX_OUTS=$(bitcoin-cli getrawtransaction "$TX" true | jq -c '.vout[] | select(.scriptPubKey.addresses != null)')

  echo "$TX_OUTS" | while read -r TXOUTN; do
    OUT_INDEX=$(echo "$TXOUTN" | jq -r '.n')
    OUT_ADDRESS=$(echo "$TXOUTN" | jq -r '.scriptPubKey.addresses[0]')
    OUT_STATUS=$(bitcoin-cli gettxout "$TX" "$OUT_INDEX")

    if [ -n "$OUT_STATUS" ]; then
      echo "$OUT_ADDRESS"
    fi
  done
done

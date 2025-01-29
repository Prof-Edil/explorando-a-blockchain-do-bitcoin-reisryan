# Only one single output remains unspent from block 123,321. What address was it sent to?
BHASH="$(bitcoin-cli -rpcconnect=84.247.182.145:8332 -rpcuser=user_259 -rpcpassword=CsaSE6fmbyP0 getblockhash 123321)"
BDATA="$(bitcoin-cli -rpcconnect=84.247.182.145:8332 -rpcuser=user_259 -rpcpassword=CsaSE6fmbyP0 getblock "$BHASH" 2)"

echo "$BDATA" | jq -r '.tx[].txid' | while read -r TX; do
  TX_OUTS=$(bitcoin-cli getrawtransaction "$TX" true)

  if [ -n "$TX_OUTS" ]; then
    echo "$TX_OUTS" | jq -c '.vout[] | select(.scriptPubKey.addresses != null)' | while read -r TXOUTN; do
      OUT_INDEX=$(echo "$TXOUTN" | jq -r '.n')
      OUT_ADDRESS=$(echo "$TXOUTN" | jq -r '.scriptPubKey.addresses[0]')
      OUT_STATUS=$(bitcoin-cli gettxout "$OUT_ADDRESS" 1)

      if [ -n "$OUT_ADDRESS" ]; then
        echo "$OUT_ADDRESS"
      fi
    done
  else
    echo "Erro: resposta vazia ou mal formatada para getrawtransaction do TX $TX" >&2
  fi
done

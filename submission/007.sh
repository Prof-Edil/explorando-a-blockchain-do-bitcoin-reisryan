# Only one single output remains unspent from block 123,321. What address was it sent to?
#!/bin/bash

BHASH="$(bitcoin-cli getblockhash 123321)"
BDATA="$(bitcoin-cli getblock "$BHASH" 2)"

echo "$BDATA" | jq -c '.tx[] | {txid: .txid, vout: .vout[]}' | while read -r TX_OUT; do
  TXID=$(echo "$TX_OUT" | jq -r '.txid')
  VOUT_INDEX=$(echo "$TX_OUT" | jq -r '.vout.n')
  ADDRESS=$(echo "$TX_OUT" | jq -r '.vout.scriptPubKey.address')

  # Verifica se o output ainda está não gasto (unspent)
  OUT_STATUS=$(bitcoin-cli gettxout "$TXID" "$VOUT_INDEX")

  if [ -n "$OUT_STATUS" ]; then
    echo "$ADDRESS"
  fi
done

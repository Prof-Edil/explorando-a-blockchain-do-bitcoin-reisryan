# Using descriptors, compute the taproot address at index 100 derived from this extended public key:
#   `xpub6Cx5tvq6nACSLJdra1A6WjqTo1SgeUZRFqsX5ysEtVBMwhCCRa4kfgFqaT2o1kwL3esB1PsYr3CUdfRZYfLHJunNWUABKftK2NjHUtzDms2`
XPUB="xpub6Cx5tvq6nACSLJdra1A6WjqTo1SgeUZRFqsX5ysEtVBMwhCCRa4kfgFqaT2o1kwL3esB1PsYr3CUdfRZYfLHJunNWUABKftK2NjHUtzDms2"
DESCRIPTOR="tr($XPUB/0/0/*)"
DESCRIPTOR_INFO=$(bitcoin-cli getdescriptorinfo "$DESCRIPTOR")
DESCRIPTOR_WITH_CHECKSUM=$(echo "$DESCRIPTOR_INFO" | jq -r '.descriptor')
ADDRESS=$(bitcoin-cli deriveaddresses "$DESCRIPTOR_WITH_CHECKSUM" "[99,99]" | jq -r '.[0]')
echo "$ADDRESS"

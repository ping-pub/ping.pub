

LOC=$(dirname "${BASH_SOURCE[0]}")

# URL to fetch JSON data
network="testnet"
URL="https://api.imperator.co/services?network=testnets"
network="mainnet"
URL="https://api.imperator.co/services?network=mainnets"

provider="Imperator"


curl -s "$URL" | jq -r 'to_entries[] | "\(.key) \(.value.endpoints.lcd) \(.value.endpoints.rpc)" ' | while read chain rest rpc ;do
    # // echo "$chain"
    config_file=$(echo "../chains/$network/$chain.json" | tr '[:upper:]' '[:lower:]')
    if [ -f "$config_file" ]; then
        if [[ "$rpc" != "null" ]]; then
            jq --arg provider "$provider" \
            --arg type "rpc" \
            --arg endpoint "$rpc" \
            '
            def upsert_provider(arr; provider; endpoint):
                (arr // []) as $a |
                if ($a | type == "array") and ($a | map(.provider == provider) | any)
                then $a | map(if .provider == provider then .address = endpoint else . end)
                else ($a + [{"provider": provider, "address": endpoint}])
                end;
            .[$type] = upsert_provider(.[ $type ]; $provider; $endpoint)
            ' "$config_file" > tmp.json && mv tmp.json "$config_file"
            echo "update $rpc to $config_file"
        fi
        if [[ "$rest" != "null" ]]; then
            jq --arg provider "$provider" \
            --arg type "api" \
            --arg endpoint "$rest" \
            '
            def upsert_provider(arr; provider; endpoint):
                (arr // []) as $a |
                if ($a | type == "array") and ($a | map(.provider == provider) | any)
                then $a | map(if .provider == provider then .address = endpoint else . end)
                else ($a + [{"provider": provider, "address": endpoint}])
                end;
            .[$type] = upsert_provider(.[ $type ]; $provider; $endpoint)
            ' "$config_file" > tmp.json && mv tmp.json "$config_file"
            echo "update $rest to $config_file"
        fi
    fi
done

# Fetch and parse
# curl -s "$URL" | jq -r '. | "\(.chain_name) \(.endpoint)"' | while read chain endpoint; do
#     echo "$chain/$endpoint"
#   config_file="../chains/$network/$chain.json"
#   config_file=$(echo "$config_file" | tr '[:upper:]' '[:lower:]')
#   type=$(echo "$short_name" | tr '[:upper:]' '[:lower:]')

#   echo "$short_name $endpoint $config_file"

#   if [ -f "$config_file" ]; then
#     if [[ "$type" == "rest" || "$type" == "rpc" ]]; then
#         if [[ "$type" == "rest" ]]; then 
#             type="api"
#         fi
#         # Your code here

#         jq --arg provider "$provider" \
#         --arg type "$type" \
#         --arg endpoint "$endpoint" \
#         '
#         def upsert_provider(arr; provider; endpoint):
#             (arr // []) as $a |
#             if ($a | type == "array") and ($a | map(.provider == provider) | any)
#             then $a | map(if .provider == provider then .address = endpoint else . end)
#             else ($a + [{"provider": provider, "address": endpoint}])
#             end;
#         .[$type] = upsert_provider(.[ $type ]; $provider; $endpoint)
#         ' "$config_file" > tmp.json && mv tmp.json "$config_file"
#         echo "update config $config_file"
#     fi
#   fi
# done

echo $LOC
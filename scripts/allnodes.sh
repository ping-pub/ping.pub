#!/bin/bash


LOC=$(dirname "${BASH_SOURCE[0]}")

# URL to fetch JSON data
URL="https://publicnode.com/_next/data/K_XtTZOu1a0DBsNJiDJQX/index.json"
provider="Allnodes"

# Fetch and parse
curl -s "$URL" | jq -r '.. | objects | .chains? | arrays | .[] | select(.based_on == "cosmos") | . as $c | .platforms[] | "\($c.name) \(.short_name) \(.network) \(.endpoint)"' | while read chain short_name network endpoint; do

  config_file="../chains/$network/$chain.json"
  config_file=$(echo "$config_file" | tr '[:upper:]' '[:lower:]')
  type=$(echo "$short_name" | tr '[:upper:]' '[:lower:]')

#   echo "$short_name $endpoint $config_file"

  if [ -f "$config_file" ]; then
    if [[ "$type" == "rest" || "$type" == "rpc" ]]; then
        if [[ "$type" == "rest" ]]; then 
            type="api"
        fi
        # Your code here
        jq --arg provider "$provider" \
        --arg type "$type" \
        --arg endpoint "$endpoint" \
        '
        def upsert_provider(arr; provider; endpoint):
            (arr // []) as $a |
            if ($a | type == "array") and ($a | map(.provider == provider) | any)
            then $a | map(if .provider == provider then .address = endpoint else . end)
            else ($a + [{"provider": provider, "address": endpoint}])
            end;
        .[$type] = upsert_provider(.[ $type ]; $provider; $endpoint)
        ' "$config_file" > tmp.json && mv tmp.json "$config_file"
        echo "update config $config_file"
    fi
  fi
done

echo $LOC
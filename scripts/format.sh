for file in ../chains/*/*.json; do
  jq '
    def extract_provider:
      capture("^(?:https?://)?(?<host>[^/]+)") 
      | .host
      | sub("^www\\."; "")
      | split(".")
      | (if length > 2 then .[-2:] else . end)
      | join(".");
    def strarr_to_objarr: 
      if type == "array" and length > 0 and all(.[]; type == "string") then
        map({
          address: .,
          provider: (extract_provider // .)
        })
      else
        .
      end;
    .api |= strarr_to_objarr | .rpc |= strarr_to_objarr
  ' "$file" > "${file}.tmp" && mv "${file}.tmp" "$file"
done
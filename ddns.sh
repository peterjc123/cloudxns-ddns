#!/bin/bash

# variables
api_key='API-KEY'
secret_key='SECRET-KEY'
domain='DOMAIN'

# constants
data=`date --utc "+%a, %d %b %Y %H:%M:%S GMT"`
api_url='https://www.cloudxns.net/api2/ddns'
data="{\"domain\": \"$domain\"}"

# hash calculation
mac="$api_key$api_url$data$date$secret_key"
hmac=`echo -n "$mac"|md5sum|cut -d ' ' -f1`

# headers
content_type="Content-Type: application/json"
api_format="API-FORMAT: json"
api_hmac="API-HMAC: $hmac"
api_request="API-REQUEST-DATE: $date"
api_key="API-KEY: $api_key"

# request
curl -k -H "$content_type" -H "$api_format" -H "$api_hmac" -H "$api_request" -H "$api_key" -X POST -d "$data" "$api_url"

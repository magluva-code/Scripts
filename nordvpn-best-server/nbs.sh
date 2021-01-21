#!/usr/bin/env bash
################################################################################
#
# nordvpn-best-server.sh
#
# How to use:
#   run ./nordvpn-best-server.sh Chosen contry
#
# Requirements:
#   curl
#
# Notes:
#   - Chosen contry must start with capital letter.
#   - As of now the script does not support direct piping in to the
#     nordvpn-bin package connect command. Will look at adding this
#     in the future.
#
################################################################################

# Base url for curl.
base_url="https://api.nordvpn.com/v1/servers"
# Creating a file of contries.
out=contry_list.txt
# Fetching contry IDs and names and write to file $out.
curl --silent $base_url"/countries" | jq --raw-output '.[] | [.id, .name] | @tsv' > $out
# Getting contry ID corresponding to the contry name arg $1
contry_id=$(grep -i $1 $out | sed 's/[^0-9]//g')
# Fetching best server for chosen contry.
best=$(curl --silent $base_url"/recommendations?filters\[country_id\]=$contry_id&limit=1" | jq --raw-output '.[].hostname')
# Displaying best server.
echo $best

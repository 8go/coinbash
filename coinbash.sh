#!/bin/bash
#
# coinbash.sh
# - Bash Script
# - CLI
# - A bash script (CLI) for displaying crypto currencies market data in a terminal
# - Tested on Debian and Ubuntu
# - Dependencies: bash, curl, jq, coinmarketcap-API-key
# - Uses cloud API of https://pro-api.coinmarketcap.com/v1
# - YOU MUST HAVE YOUR OWN coinmarketcap-API-key, as of Oct 2020 you can get one for free at coinmarketcap.com
# - set the global environment variable COINMARKETCAP_API_KEY to your personal coinmarketcap-API-key,
# - e.g export COINMARKETCAP_API_KEY="your-coinmarketcap-API-key-here"
# - keywords: CLI, command-line, terminal, bash, market-data, ticker, price-tracker, marketcap, crypto, crypto currencies, cryptocurrency, bitcoin, btc, ethereum
#
# License: CC BY-SA 4.0 https://creativecommons.org/licenses/by-sa/4.0/
#

########## GENERAL INFO ##########

#
# API: https://coinmarketcap.com/api/
# https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest?convert=USD&limit=2&start=1
# Returns something like:
# {"status":{"timestamp":"2020-10-02T12:10:29.629Z","error_code":0,"error_message":null,"elapsed":9,"credit_count":1,"notice":null,"total_count":3560},"data":[{"id":1,"name":"Bitcoin","symbol":"BTC","slug":"bitcoin","num_market_pairs":9315,"date_added":"2013-04-28T00:00:00.000Z","tags":["mineable","pow","sha-256","store-of-value","state-channels"],"max_supply":21000000,"circulating_supply":18505718,"total_supply":18505718,"platform":null,"cmc_rank":1,"last_updated":"2020-10-02T12:09:30.000Z","quote":{"USD":{"price":10471.2855252,"volume_24h":26623814611.304,"percent_change_1h":-0.0184301,"percent_change_24h":-3.8861,"percent_change_7d":-1.68497,"market_cap":193778657026.8331,"last_updated":"2020-10-02T12:09:30.000Z"}}},{"id":1027,"name":"Ethereum","symbol":"ETH","slug":"ethereum","num_market_pairs":6043,"date_added":"2015-08-07T00:00:00.000Z","tags":["mineable","pow","smart-contracts","binance-chain"],"max_supply":null,"circulating_supply":112840913.124,"total_supply":112840913.124,"platform":null,"cmc_rank":2,"last_updated":"2020-10-02T12:09:23.000Z","quote":{"USD":{"price":339.400890152,"volume_24h":15156595436.1756,"percent_change_1h":-0.00356475,"percent_change_24h":-7.8024,"percent_change_7d":-1.45411,"market_cap":38298306359.8501,"last_updated":"2020-10-02T12:09:23.000Z"}}}]}
#
# cat /tmp/coinbash.sh.tmp.json | jq [.data[0]] gives something like
: '[
  {
    "id": 1,
    "name": "Bitcoin",
    "symbol": "BTC",
    "slug": "bitcoin",
    "num_market_pairs": 9315,
    "date_added": "2013-04-28T00:00:00.000Z",
    "tags": [
      "mineable",
      "pow",
      "sha-256",
      "store-of-value",
      "state-channels"
    ],
    "max_supply": 21000000,
    "circulating_supply": 18505718,
    "total_supply": 18505718,
    "platform": null,
    "cmc_rank": 1,
    "last_updated": "2020-10-02T12:09:30.000Z",
    "quote": {
      "USD": {
        "price": 10471.2855252,
        "volume_24h": 26623814611.304,
        "percent_change_1h": -0.0184301,
        "percent_change_24h": -3.8861,
        "percent_change_7d": -1.68497,
        "market_cap": 193778657026.8331,
        "last_updated": "2020-10-02T12:09:30.000Z"
      }
    }
  }
]'
#
# cat /tmp/coinbash.sh.tmp.json | jq [.data[1]][].name  gives something like "Ethereum"
# cat /tmp/coinbash.sh.tmp.json | jq [.data[1]][].quote.USD.price  gives something like 339.400890152

# https://pro-api.coinmarketcap.com/v1/cryptocurrency/quotes/latest?convert=USD&slug=bitcoin
# Returns something like:
# {"status":{"timestamp":"2020-10-02T12:39:21.288Z","error_code":0,"error_message":null,"elapsed":30,"credit_count":1,"notice":null},"data":{"1":{"id":1,"name":"Bitcoin","symbol":"BTC","slug":"bitcoin","num_market_pairs":9315,"date_added":"2013-04-28T00:00:00.000Z","tags":["mineable","pow","sha-256","store-of-value","state-channels"],"max_supply":21000000,"circulating_supply":18505743,"total_supply":18505743,"is_active":1,"platform":null,"cmc_rank":1,"is_fiat":0,"last_updated":"2020-1002T12:38:21.000Z","quote":{"USD":{"price":10491.9489757,"volume_24h":26838808649.2375,"percent_change_1h":0.12782,"percent_change_24h":-3.70075,"percent_change_7d":-1.5155,"market_cap":194161311313.41742,"last_updated":"2020-10-02T12:38:21.000Z"}}}}}
#
# cat "/tmp/coinbash.sh.tmp.json.part" | jq [.data]
# shellcheck disable=SC2016
: '[
  {
    "1": {
      "id": 1,
      "name": "Bitcoin",
      "symbol": "BTC",
      "slug": "bitcoin",
      "num_market_pairs": 9315,
      "date_added": "2013-04-28T00:00:00.000Z",
      "tags": [
        "mineable",
        "pow",
        "sha-256",
        "store-of-value",
        "state-channels"
      ],
      "max_supply": 21000000,
      "circulating_supply": 18505743,
      "total_supply": 18505743,
      "is_active": 1,
      "platform": null,
      "cmc_rank": 1,
      "is_fiat": 0,
      "last_updated": "2020-10-02T12:38:21.000Z",
      "quote": {
        "USD": {
          "price": 10491.9489757,
          "volume_24h": 26838808649.2375,
          "percent_change_1h": 0.12782,
          "percent_change_24h": -3.70075,
          "percent_change_7d": -1.5155,
          "market_cap": 194161311313.41742,
          "last_updated": "2020-10-02T12:38:21.000Z"
        }
      }
    }
  }
]

cat "/tmp/coinbash.sh.tmp.json.part" | jq "[.data][] | keys"| jq .[] # gets the id, name
"1"

cat "/tmp/coinbash.sh.tmp.json.part" | jq "[.data][] | keys"| jq .[] # gets the id, name
"1"
key=$(cat "/tmp/coinbash.sh.tmp.json.part" | jq "[.data][] | keys"| jq .[]) # assign the id, name
echo $key
"1"
cat "/tmp/coinbash.sh.tmp.json.part" | jq [.data][].$key
{
  "id": 1,
  "name": "Bitcoin",
  "symbol": "BTC",
  "slug": "bitcoin",
  "num_market_pairs": 9315,
  "date_added": "2013-04-28T00:00:00.000Z",
  "tags": [
    "mineable",
    "pow",
    "sha-256",
    "store-of-value",
    "state-channels"
  ],
  "max_supply": 21000000,
  "circulating_supply": 18505743,
  "total_supply": 18505743,
  "is_active": 1,
  "platform": null,
  "cmc_rank": 1,
  "is_fiat": 0,
  "last_updated": "2020-10-02T12:38:21.000Z",
  "quote": {
    "USD": {
      "price": 10491.9489757,
      "volume_24h": 26838808649.2375,
      "percent_change_1h": 0.12782,
      "percent_change_24h": -3.70075,
      "percent_change_7d": -1.5155,
      "market_cap": 194161311313.41742,
      "last_updated": "2020-10-02T12:38:21.000Z"
    }
  }
}
'

# formating of output in table: printf and column
#

########## CONSTANTS ##########

# colored output
# source: https://stackoverflow.com/questions/5947742/how-to-change-the-output-color-of-echo-in-linux
# shellcheck disable=SC2034
red=$(tput setaf 1) # Error
# shellcheck disable=SC2034
green=$(tput setaf 2) # OK
# shellcheck disable=SC2034
yellow=$(tput setaf 3) # Warning
# shellcheck disable=SC2034
bold=$(tput bold) # bold
# shellcheck disable=SC2034
rev=$(tput rev) # reverse
# shellcheck disable=SC2034
reset=$(tput sgr0) # reset, clearing, back to default

########## VARIABLES ##########
UNSPECIFIED=()  # this is the array of unspecified arguments
DEBUG="false"   # for --debug argument;
HELP="false"    # for --help argument;
VERSION="false" # for --version argument;
# shellcheck disable=SC2034
DOONLYCLEANUP="false" # for --cleanup argument;
# shellcheck disable=SC2034
COUNTER=0 # this is a counter of arguments
VERSIONDESC="2022-MAY-17"
MYAPP=jq    # this package is required, a json parser
MYAPP2=curl # this package is required
# https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest?start=1&convert=USD&limit=10
# https://pro-api.coinmarketcap.com/v1/cryptocurrency/quotes/latest?slug=bitcoin&convert=EUR
URLPREFIX="https://"
URLBASE="pro-api.coinmarketcap.com/"
URLPOSTFIX="v1/cryptocurrency/"
# URLBASEIP="104.17.137.178" # IP address of https://api.coinmarketcap.com from a tool like tor-resolve or http://www.dnsqueries.com/en/dns_lookup.php
DATAURL=${URLPREFIX}${URLBASE}${URLPOSTFIX}
JSONFILE="/tmp/${0##*/}.tmp.json"
TORIFYCMD="torify "
TORIFY="false"
TOPDEFAULT=10   # default
TOP=$TOPDEFAULT # init
FIAT="USD"      # default fiat currency
FIATARRAY=(BTC ETH USDT XRP BCH BNB DOT LINK CRO BSV LTC XAU XAG XPT XPD AUD BRL CAD CHF CLP CNY CZK DKK EUR GBP HKD HUF IDR ILS INR JPY KRW MXN MYR NOK NZD PHP PKR PLN RUB SEK SGD THB TRY TWD USD ZAR)
EUR="false"
CCSYMBOLSARRAY=()
CCSYMBOLSLIST=""    # string of crypt currencies seperated by comma (,) without spaces ( ). E.g. btc,eth,ltc
DEPTHDEFAULT=100    # default
DEPTH=$DEPTHDEFAULT # by default search up to $DEPTH entries to find the listed crypto currencies symbols; Use -p to change default
MATCHED=0
ALLMATCHED=99 # constant, return code, signifies all entries in CCSYMBOLSLIST have been printed
CCNAMESARRAY=()
CCNAMESLIST="" # string of crypt currencies seperated by comma (,) without spaces ( ). E.g. bitcoin-cash,ethereum-classic
VERBOSE="false"

########## FUNCTIONS ##########

# usage
function usage() {
    echo "${0##*/}: Usage: ${bold}${0##*/} [--help] [--debug] [--version] [--verbose] [--torify]  ${reset}"
    echo "${0##*/}:                    ${bold}[--top <NUMBER>]  [--depth <NUMBER>] ${reset}"
    echo "${0##*/}:                    ${bold}[--listbysymbols <CRYPTO1SYMBOL,CRYPTO2SYMBOL,ETC>]  ${reset}"
    echo "${0##*/}:                    ${bold}[--listbynames <CRYPTO1NAME,CRYPTO2NAME,ETC>]  ${reset}"
    echo "${0##*/}:                    ${bold}[--eur] [--fiat <CURRENCY>]${reset}"
    echo "${0##*/}:        ${bold}${0##*/} --cleanup ${reset}"
    echo "${0##*/}: Version: ${VERSIONDESC}"
    echo "${0##*/}: License: CC BY-SA 4.0 https://creativecommons.org/licenses/by-sa/4.0/"
    echo "${0##*/}: Source: ${0}"
    echo "${0##*/}: ${0##*/} requests data from ${bold}www.coinmarketcap.com${reset} and lists market info on "
    echo "${0##*/}:          the most valuable crypto currencies."
    echo "${0##*/}: If necessary it installs packages $MYAPP and $MYAPP2."
    echo "${0##*/}: Inspiration and basic idea from ${bold}https://github.com/bichenkk/coinmon${reset}"
    echo "${0##*/}: Real-time market data from ${bold}https://www.coinmarketcap.com${reset}"
    echo "${0##*/}: The default currency is USD and it supports "
    echo "${0##*/}:          BTC, ETH, USDT, XRP, BCH, BNB, DOT, LINK, CRO, BSV, LTC, "
    echo "${0##*/}:          XAU, XAG, XPT, XPD, "
    echo "${0##*/}:          AUD, BRL, CAD, CHF, CLP, CNY, CZK, "
    echo "${0##*/}:          DKK, EUR, GBP, HKD, HUF, IDR, ILS, INR, JPY, KRW, MXN, MYR, NOK, NZD, "
    echo "${0##*/}:          PHP, PKR, PLN, RUB, SEK, SGD, THB, TRY, TWD, ZAR."
    echo "${0##*/}: ${0##*/} uses a temporary file $JSONFILE which gets automatically removed."
    echo "${0##*/}: Example: ${0##*/}       ...  prints top $TOPDEFAULT crypto currencies, "
    echo "${0##*/}:                              uses default USD for prices"
    echo "${0##*/}: Example: ${0##*/} -n 3  ...  prints market info of top 3 crypto currencies, "
    echo "${0##*/}:                              uses USD for prices"
    echo "${0##*/}: Example: ${0##*/} -t -n 5  ...  uses Tor onion network, prints market info of "
    echo "${0##*/}:                              top 5 crypto currencies, uses USD for prices"
    echo "${0##*/}: Example: ${0##*/} -t -n 7 -e ...  uses Tor, prints market info of top 7 crypto currencies, "
    echo "${0##*/}:                              uses EUR for prices"
    echo "${0##*/}: Example: ${0##*/} -e  ...  shortcut for -f EUR, uses Euro for prices"
    echo "${0##*/}: Example: ${0##*/} -f BTC  ...  gives prices in Bitcoin (BTC)"
    echo "${0##*/}: Example: ${0##*/} -f XAU  ...  gives prices in Gold Troy ounces (XAU)"
    echo "${0##*/}: Example: ${0##*/} -f AUD  ...  gives prices in Australian Dollars (AUD)"
    echo "${0##*/}: Example: ${0##*/} -l btc  ...  lists only BTC"
    echo "${0##*/}: Example: ${0##*/} -l btc,eth,ltc  ...  lists BTC, ETH and LTC "
    echo "${0##*/}:                              (by default searches are limited to the top $DEPTH crypto currencies)"
    echo "${0##*/}: Example: ${0##*/} -l btc,eth,rev -p 1000  ...  lists BTC, ETH and REV "
    echo "${0##*/}:                              (searches in the top 1000 crypto currencies)"
    echo "${0##*/}: Example: ${0##*/} -t -f EUR -l btc,sc,btcd -p 100  ...  lists BTC, SC and BTCD "
    echo "${0##*/}:                              by searching in the top 100 crypto currencies,"
    echo "${0##*/}:                              communicates via Tor and uses Euros for prices"
    echo "${0##*/}: Example: ${0##*/} -t -f EUR -i bitcoin-cash, ethereum-classic  ...  lists BCH and ETC "
    echo "${0##*/}:                              by searching ${bold}all${reset} crypto currencies,"
    echo "${0##*/}:                              communicates via Tor and uses Euros for prices"
    echo "${0##*/}: Arguments are:"
    echo "${0##*/}: ${bold}--help, -h${reset}"
    echo "${0##*/}:    HELP: Prints the help text and exits. [type: flag]"
    echo "${0##*/}: ${bold}--version, -v${reset}"
    echo "${0##*/}:    VERSION: Same as --help [type: flag]"
    echo "${0##*/}: ${bold}--debug, -d${reset}"
    echo "${0##*/}:    DEBUG: Turns debug output on, default is off [type: flag]"
    echo "${0##*/}: ${bold}--cleanup, -c${reset}"
    echo "${0##*/}:    DO-ONLY-CLEANUP: Performs only cleanup, then exits [type: flag]"
    echo "${0##*/}: ${bold}--torify, -t${reset}"
    echo "${0##*/}:    TORIFY: Request the data via Tor onion network [type: flag]"
    echo "${0##*/}:    Was disabled in latest Coinmarketcap.com API."
    echo "${0##*/}: ${bold}--top, -n${reset}"
    echo "${0##*/}:    TOP: How many crypto currencies should be displayed [type: integer] [default: $TOP]"
    echo "${0##*/}: ${bold}--fiat, -f${reset}"
    echo "${0##*/}:    FIAT: Specify fiat currency for prices [type: string] [default: $FIAT]"
    echo "${0##*/}: ${bold}--eur, -e${reset}"
    echo "${0##*/}:    EUR: Use EUR as fiat currency instead of default USD, shortcut for -f EUR [type: flag]"
    echo "${0##*/}: ${bold}--listbysymbols, -l${reset}"
    echo "${0##*/}:    LIST-BY-SYMBOLS: List of crypto currencies to display, "
    echo "${0##*/}:    comma-separated space-less string of symbols like \"btc,eth,ltc\" [type: string]"
    echo "${0##*/}:    If option -l is used then options -n and -i should not be used."
    echo "${0##*/}: ${bold}--listbynames, -i${reset}"
    echo "${0##*/}:    LIST-BY-NAMES: List of crypto currencies to display, comma-separated "
    echo "${0##*/}:    space-less string of names like \"bitcoin-cash,ethereum-classic\" [type: string]"
    echo "${0##*/}:    If option -i is used then options -n, -p and -l should not be used."
    echo "${0##*/}: ${bold}--depth, -p${reset}"
    echo "${0##*/}:    DEPTH: When listing by symbols (-l) search the top \"depth\" "
    echo "${0##*/}:    crypto currencies for the symbols [type: integer] [default: $DEPTH]"
    echo "${0##*/}:    The larger the value for -p the longer execution will take."
    echo "${0##*/}: ${bold}--verbose, -w${reset}"
    echo "${0##*/}:    VERBOSE: Verbose listing of information including supply data, etc. [type: flag]"
}

function printArgs() {
    echo "${0##*/}: HELP......................=$HELP"
    echo "${0##*/}: DEBUG.....................=$DEBUG"
    echo "${0##*/}: VERSION...................=$VERSION"
    echo "${0##*/}: COUNTER...................=$COUNTER"
    echo "${0##*/}: UNSPECIFIED...............=(${UNSPECIFIED[*]});  length=${#UNSPECIFIED[@]}"
    echo "${0##*/}: MYAPP.....................=$MYAPP"
    echo "${0##*/}: MYAPP2....................=$MYAPP2"
    echo "${0##*/}: DOONLYCLEANUP.............=$DOONLYCLEANUP"
    echo "${0##*/}: VERBOSE...................=$VERBOSE"
    echo "${0##*/}: TORIFY....................=$TORIFY"
    echo "${0##*/}: TOP.......................=$TOP"
    echo "${0##*/}: EUR.......................=$EUR"
    echo "${0##*/}: FIAT......................=$FIAT"
    echo "${0##*/}: CCSYMBOLSLIST.............=$CCSYMBOLSLIST"
    echo "${0##*/}: CCNAMESLIST...............=$CCNAMESLIST"
}

# $1 ... value passed to exit
# This function exits the script
function cleanup() {
    rm -f "${JSONFILE}"
    rm -f "${JSONFILE}.part"
    exit "$1"
}

function controlC() {
    # ^C ... SIGINT ... 2
    echo -e "\n*** Trapped CTRL-C ***"
    cleanup 1
}

function sigUsr1() {
    # kill -SIGUSR1 ... SIGUSR1 ... 10
    echo -e "\n*** Trapped SIGUSR1 ***"
    cleanup 1
}

function controlBackslash() {
    # ^\ ... SIGQUIT ... 3
    echo -e "\n*** Trapped CTRL-\ ***"
    echo "${0##*/}: Exiting ${yellow}${bold}without${reset} any cleanup."
    exit 2
}

function printHeader() {
    #         "name": "Bitcoin",
    #         "symbol": "BTC",
    #         "rank": "1",
    #         "price_usd": "8294.96",
    #         "price_btc": "1.0",
    #         "24h_volume_usd": "3418410000.0",
    #         "market_cap_usd": "138482076086",
    #         "available_supply": "16694725.0",
    #         "total_supply": "16694725.0",
    #         "max_supply": "21000000.0",
    #         "percent_change_1h": "0.14",
    #         "percent_change_24h": "1.76",
    #         "percent_change_7d": "17.49",
    #         "last_updated": "1511350757"
    #
    #         "price_eur": "0.1718910529",
    #         "24h_volume_eur": "6333068.4605",
    #         "market_cap_eur": "1547019476.0"

    rank="Rank"
    symbol="Symbol"
    name="Name"
    price="$FIATUC"
    market_cap="Market-cap-$FIATUC"
    price_btc="BTC"
    percent_change_24h="24h-Change"
    percent_change_7d="7d-Change"
    if [ "$VERBOSE" == "true" ]; then
        a24h_volume="24h-Volume-$FIATUC"
        available_supply="Available-Supply"
        total_supply="Total-Supply"
        max_supply="Max-Supply"
        percent_change_1h="1h-Change"
        # dont put anything like ${bold} ${reset} here, it confuses `column` later
        printf "%s\t%s\t%s\t%s\t%s\t%s\t%s\t%17s\t%17s\t%17s\t%17s\t%17s\n" "$rank" "$symbol" "$name" "$price" "$percent_change_1h" "$percent_change_24h" "$percent_change_7d" "$a24h_volume" "$available_supply" "$total_supply" "$max_supply" "$market_cap"
    else
        # dont put anything like ${bold} ${reset} here, it confuses `column` later
        printf "%s\t%s\t%s\t%s\t%s\t%s\t%17s\n" "$rank" "$symbol" "$name" "$price" "$percent_change_24h" "$percent_change_7d" "$market_cap"
    fi
}

function setSeperator() {
    # The JSON is in UTF8 and uses LC_NUMERIC="en_US.UTF-8".
    # That means that JSON has . as decimal seperator.
    # Using these price strings will not work in other countries that use , as a decimal seperator
    # We will check if printf "%f" 1.3 works. If so we use prices as is.
    # If not than we will check if printf "%f" 1,3 works. If so we then substitute the dots (.) with commas (,) in the price strings.
    # If both 1.3 and 1,3 fail in printf, LC_NUMERIC is changed to force dot (.) as seperator.

    if [ "$(printf '%3.1f' 1.3 2>/dev/null)" == "1.3" ]; then
        seperator="."
    elif [ "$(printf '%3.1f' 1,3 2>/dev/null)" == "1,3" ]; then
        seperator=","
    else
        LC_NUMERIC="en_US.UTF-8"
        seperator="."
    fi
}

: ' input is JSON string like this {
      "id": 1,
      "name": "Bitcoin",
      "symbol": "BTC",
      "slug": "bitcoin",
      "num_market_pairs": 9315,
      "date_added": "2013-04-28T00:00:00.000Z",
      "tags": [
        "mineable",
        "pow",
        "sha-256",
        "store-of-value",
        "state-channels"
      ],
      "max_supply": 21000000,
      "circulating_supply": 18505743,
      "total_supply": 18505743,
      "is_active": 1,
      "platform": null,
      "cmc_rank": 1,
      "is_fiat": 0,
      "last_updated": "2020-10-02T12:38:21.000Z",
      "quote": {
        "USD": {
          "price": 10491.9489757,
          "volume_24h": 26838808649.2375,
          "percent_change_1h": 0.12782,
          "percent_change_24h": -3.70075,
          "percent_change_7d": -1.5155,
          "market_cap": 194161311313.41742,
          "last_updated": "2020-10-02T12:38:21.000Z"
        }
      }
    }
'
function processEntry() {
    symbol=$(echo "$1" | jq ".symbol")
    symbol="${symbol%\"}"
    symbol="${symbol#\"}"

    if [ "$useccsymbolslist" == "true" ]; then
        match="false"
        for element in "${CCSYMBOLSARRAY[@]}"; do
            if [ "$element" == "$symbol" ]; then
                match="true"
                ((MATCHED++))
                break
            fi
        done
        if [ "$match" == "false" ]; then
            return 0
        fi
    fi

    rank=$(echo "$1" | jq ".cmc_rank")
    #rank="${rank%\"}"
    #rank="${rank#\"}"
    name=$(echo "$1" | jq ".name")
    name="${name%\"}" # remove trailing quote
    name="${name#\"}" # remove leading quote
    # name="${name/ /-}" # replace spaces with hyphen; this does NOT work, only replaces a single space
    name=$(tr "[:blank:]" " " <<<$name | tr -s " " | tr " " "-")
    price=$(echo "$1" | jq ".quote.$FIATUC.price")
    #price="${price%\"}"
    #price="${price#\"}"
    [ $seperator == "," ] && price=${price//./,} # replace all dots
    # price_btc=$(echo "$1" | jq ".quote.BTC.price")  ==> Free API key does NOT support more than 1 currency!
    price_btc="---"
    #price_btc="${price_btc%\"}"
    #price_btc="${price_btc#\"}"
    [ $seperator == "," ] && price_btc=${price_btc//./,} # replace all dots
    percent_change_24h=$(echo "$1" | jq ".quote.$FIATUC.percent_change_24h")
    #percent_change_24h="${percent_change_24h%\"}"
    #percent_change_24h="${percent_change_24h#\"}"
    [ $seperator == "," ] && percent_change_24h=${percent_change_24h//./,} # replace all dots
    percent_change_7d=$(echo "$1" | jq ".quote.$FIATUC.percent_change_7d")
    #percent_change_7d="${percent_change_7d%\"}"
    #percent_change_7d="${percent_change_7d#\"}"
    [ $seperator == "," ] && percent_change_7d=${percent_change_7d//./,} # replace all dots
    market_cap=$(echo "$1" | jq ".quote.$FIATUC.market_cap")
    #market_cap="${market_cap%\"}"
    #market_cap="${market_cap#\"}"
    [ $seperator == "," ] && market_cap=${market_cap//./,} # replace all dots
    if [ "$VERBOSE" == "true" ]; then
        a24h_volume=$(echo "$1" | jq ".quote.$FIATUC.volume_24h")
        #a24h_volume="${a24h_volume%\"}"
        #a24h_volume="${a24h_volume#\"}"
        [ $seperator == "," ] && a24h_volume=${a24h_volume//./,} # replace all dots

        available_supply=$(echo "$1" | jq ".circulating_supply") # available_supply
        #available_supply="${available_supply%\"}"
        #available_supply="${available_supply#\"}"
        [ $seperator == "," ] && available_supply=${available_supply//./,} # replace all dots

        total_supply=$(echo "$1" | jq ".total_supply")
        #total_supply="${total_supply%\"}"
        #total_supply="${total_supply#\"}"
        [ $seperator == "," ] && total_supply=${total_supply//./,} # replace all dots

        max_supply=$(echo "$1" | jq ".max_supply")
        #max_supply="${max_supply%\"}"
        #max_supply="${max_supply#\"}"
        [ $seperator == "," ] && max_supply=${max_supply//./,} # replace all dots

        percent_change_1h=$(echo "$1" | jq ".quote.$FIATUC.percent_change_1h")
        #percent_change_1h="${percent_change_1h%\"}"
        #percent_change_1h="${percent_change_1h#\"}"
        [ $seperator == "," ] && percent_change_1h=${percent_change_1h//./,} # replace all dots
        printf "%d\t%s\t%s\t%'1.8f\t%+6.1f%%\t%+6.1f%%\t%+6.1f%%\t%'17.f\t%'17.f\t%'17.f\t%'17.f\t%'17.f\n" "$rank" "$symbol" "$name" "$price" "$percent_change_1h" "$percent_change_24h" "$percent_change_7d" "$a24h_volume" "$available_supply" "$total_supply" "$max_supply" "$market_cap" 2>/dev/null
    else
        printf "%d\t%s\t%s\t%'1.8f\t%+6.1f%%\t%+6.1f%%\t%'17.f\n" "$rank" "$symbol" "$name" "$price" "$percent_change_24h" "$percent_change_7d" "$market_cap" 2>/dev/null
    fi

    if [ "$useccsymbolslist" == "true" ]; then
        if [ "$MATCHED" -ge ${#CCSYMBOLSARRAY[@]} ]; then
            return "$ALLMATCHED" # stop scanning, all symbols have been matched
        fi
    fi
    return 1
}

########## Main ##########

function main() {
    if [ "$COINMARKETCAP_API_KEY" == "" ]; then
        echo "${0##*/}: ${red}${bold}Coinmarketcap-API-key missing.${reset} Global environment variable \"COINMARKETCAP_API_KEY\" is not set."
        echo "${0##*/}: Go to https://coinmarketcap.com and get your personal API key. Then assign it to environment variable \"COINMARKETCAP_API_KEY\"."
        exit 13
    fi
    # process arguments
    # source: https://stackoverflow.com/questions/192249/how-do-i-parse-command-line-arguments-in-bash
    while [[ $# -gt 0 ]]; do
        key="${1,,}" # lowercase $1

        case $key in
        h | -h | --h | help | -help | --help | -help* | --help*)
            HELP="true"
            ;;
        -d | --d | debug | -debug | --debug | -debug* | --debug*)
            DEBUG="true"
            ;;
        -v | --v | version | -version | --version | -version* | --version*)
            VERSION="true"
            ;;
        cleanup | -c | --c | clean | -clean | --clean | -clean* | --clean*)
            DOONLYCLEANUP="true"
            ;;
        torify | t | tor | -torify | -t | -tor | --torify | --t | --tor)
            TORIFY="true"
            echo "${0##*/}: ${red}${bold}This feature has been disabled by the API. It requires a captcha. Sorry.${reset}"
            echo "${0##*/}: ${red}${bold}TOR use no longer allowed in the new API version.${reset}"
            exit 33
            ;;
        top | n | number | -top | -n | -number | --top | --n | --number)
            if ! [[ "$2" =~ ^[0-9]+$ ]]; then
                echo "${0##*/}: ${red}${bold}Argument \"$key\" is of type \"integer\" and has value \"$2\". \"$2\" does not correspond to its type \"integer\". Please enter a positive number.${reset}"
                exit 3
            fi
            TOP=$2
            shift # jump past argument
            ;;
        eur | e | euro | euros | -eur | -e | -euro | -euros | --eur | --e | --euro | --euros)
            EUR="true"
            ;;
        fiat | f | -fiat | -f | --fiat | --f)
            FIAT=$2
            shift # jump past argument
            ;;
        listbysymbols | l | listbysymbol | symbol | symbols | -listbysymbols | -l | -listbysymbol | -symbol | -symbols | --listbysymbols | --l | --listbysymbol | --symbol | --symbols)
            CCSYMBOLSLIST="$2"
            shift # jump past argument
            ;;
        listbynames | i | listbyname | name | names | -listbynames | -i | -listbyname | -name | -names | --listbynames | --i | --listbyname | --name | --names)
            CCNAMESLIST="$2"
            shift # jump past argument
            ;;
        depth | p | deep | -depth | -p | -deep | --depth | --p | --deep)
            if ! [[ "$2" =~ ^[0-9]+$ ]]; then
                echo "${0##*/}: ${red}${bold}Argument \"$key\" is of type \"integer\" and has value \"$2\". \"$2\" does not correspond to its type \"integer\". Please enter a positive number.${reset}"
                exit 3
            fi
            DEPTH=$2
            shift # jump past argument
            ;;
        verbose | w | detail* | -verbose | -w | -detail* | --verbose | --w | --detail*)
            VERBOSE="true"
            ;;
        *)
            # UNSPECIFIED option
            ((COUNTER++))
            UNSPECIFIED[$COUNTER]=$1
            ;;
        esac
        shift # past argument or value
    done

    # we do know how many args to expect
    if [ ${#UNSPECIFIED[@]} -gt 0 ]; then
        echo "${0##*/}: ${red}${bold}There are too many arguments. Unrecognized arguments are: ${UNSPECIFIED[*]}${reset}"
        usage
        exit 2
    fi

    if [ "$HELP" == "true" ]; then
        usage
        exit 0
    fi

    if [ "$VERSION" == "true" ]; then
        usage
        exit 0
    fi

    if [ "$DOONLYCLEANUP" == "true" ]; then
        [ "$DEBUG" == "true" ] && printArgs
        cleanup 0
    fi

    FIATUC=${FIAT^^} # uppercase
    fiatvalid="false"
    for item in "${FIATARRAY[@]}"; do
        [[ "$FIATUC" == "$item" ]] && fiatvalid="true"
    done
    # shellcheck disable=SC2086
    if [ "$fiatvalid" == "false" ]; then
        echo "${0##*/}: ${red}${bold}Fiat currency \"$FIATUC\" is not valid.${reset}"
        usage
        exit 8
    else
        FIATLC=${FIAT,,} # lowercase
    fi

    # shellcheck disable=SC2086
    if [ "$EUR" == "true" ]; then
        FIAT="EUR"
        # shellcheck disable=SC2034
        FIATUC=${FIAT^^} # uppercase
        # shellcheck disable=SC2034
        FIATLC=${FIAT,,} # lowercase
    fi
    # I tried this: `CONVERT="?convert=BTC,${FIATUC}"` but it gave error `Free version does not support more than 1 currency`.
    CONVERT="?convert=${FIATUC}"
    [ "$DEBUG" == "true" ] && echo "${0##*/}: ${green}${bold}Converting to fiat $FIATUC.${reset}"

    if [ "$TORIFY" == "true" ]; then
        TORIFYCMD="torify "
    else
        TORIFYCMD=""
    fi
    if [ "$TOP" -eq 0 ]; then
        echo "${0##*/}: ${red}${bold}Top $TOP (zero) is not allowed.${reset}"
        usage
        exit 7
    fi
    if [ "$TOP" -lt 0 ]; then
        echo "${0##*/}: ${red}${bold}Top $TOP is negative and hence not allowed.${reset}"
        usage
        exit 6
    fi
    useccsymbolslist="false"
    if [ "$CCSYMBOLSLIST" == "" ]; then
        [ "$DEBUG" == "true" ] && echo "${0##*/}: ${yellow}${bold}List of symbols is empty, ignoring it.${reset}"
    else
        IFS=', ' read -r -a CCSYMBOLSARRAY <<<"${CCSYMBOLSLIST^^}" # will even work on strings like "btc,eth ltc xmr, bch"
        useccsymbolslist="true"
    fi
    useccnameslist="false"
    if [ "$CCNAMESLIST" == "" ]; then
        [ "$DEBUG" == "true" ] && echo "${0##*/}: ${yellow}${bold}List of names is empty, ignoring it.${reset}"
    else
        IFS=', ' read -r -a CCNAMESARRAY <<<"${CCNAMESLIST,,}" # will even work on strings like "bitcoin-cash,bitcoin litecoin monero, ethereum-classic"
        useccnameslist="true"
    fi
    [ "$DEBUG" == "true" ] && printArgs # for debugging
    if [ "$useccsymbolslist" == "false" ] && [ "$useccnameslist" == "false" ]; then
        [ "$DEPTH" -ne $DEPTHDEFAULT ] && echo "${0##*/}: ${yellow}${bold}Option -p (--depth) ($DEPTH) will be ignored. It should only be used combined with option -l.${reset}" # ok
    fi
    if [ "$useccsymbolslist" == "false" ] && [ "$useccnameslist" == "true" ]; then
        [ "$DEPTH" -ne $DEPTHDEFAULT ] && echo "${0##*/}: ${yellow}${bold}Option -p (--depth) ($DEPTH) will be ignored.  Not compatible with the option -i.${reset}" # ok
        [ "$TOP" -ne $TOPDEFAULT ] && echo "${0##*/}: ${yellow}${bold}Option -n (--top) ($TOP) will be ignored. Not compatible with the option -i.${reset}"
    fi
    if [ "$useccsymbolslist" == "true" ] && [ "$useccnameslist" == "false" ]; then
        [ "$TOP" -ne $TOPDEFAULT ] && echo "${0##*/}: ${yellow}${bold}Option -n (--top) ($TOP) will be ignored. Not compatible with the option -l.${reset}"
        TOP=$DEPTH
    fi
    if [ "$useccsymbolslist" == "true" ] && [ "$useccnameslist" == "true" ]; then
        echo "${0##*/}: ${red}${bold}Error: Cannot use both options -l and -i. Use one or the other.${reset}"
        usage
        exit 5
    fi

    wasinstalled="false"
    which $MYAPP >/dev/null 2>&1
    # shellcheck disable=SC2181
    if [ $? -eq 0 ]; then
        [ "$DEBUG" == "true" ] && echo "${0##*/}: ${green}${bold}Package $MYAPP already installed.${reset}"
    else
        echo "${0##*/}: ${green}${bold}Installing required package $MYAPP. Only done on first run.${reset}"
        sudo apt-get --yes install $MYAPP
        wasinstalled="true"
    fi

    wasinstalled2="false"
    which $MYAPP2 >/dev/null 2>&1
    # shellcheck disable=SC2181
    if [ $? -eq 0 ]; then
        [ "$DEBUG" == "true" ] && echo "${0##*/}: ${green}${bold}Package $MYAPP2 already installed.${reset}"
    else
        echo "${0##*/}: ${green}${bold}Installing required package $MYAPP2. Only done on first run.${reset}"
        sudo apt-get --yes install $MYAPP2
        wasinstalled2="true"
    fi

    [ "$DEBUG" == "true" ] && echo "${0##*/}: DEBUG: wasinstalled  = $wasinstalled"
    [ "$DEBUG" == "true" ] && echo "${0##*/}: DEBUG: wasinstalled2 = $wasinstalled2"

    # column -t -R 4,6,7,8,9,10,11,12,13 does not work on all platforms as column BSD does not support -R option
    echo "foo" | column -t -R 1 2>/dev/null >/dev/null
    ret=$?
    if [ "$ret" == "0" ]; then
        COLUMNOPTIONS="-R 4,6,7,8,9,10,11,12,13"
    else
        COLUMNOPTIONS=""
    fi
    # $TORIFYCMD curl -s "https://3g2upl4pq6kufc4m.onion/html" >"${JSONFILE}.html" # for testing
    if [ "$useccnameslist" == "true" ]; then
        LIMIT=""
        TOP=0
        echo -e "[\n" >"${JSONFILE}"
        isfirst="true"
        for name in "${CCNAMESARRAY[@]}"; do
            [ "$DEBUG" == "true" ] && echo "${0##*/}: DEBUG: $TORIFYCMD curl -H \"X-CMC_PRO_API_KEY: $COINMARKETCAP_API_KEY\" -H \"Accept: application/json\" -s  \"${DATAURL}quotes/latest${CONVERT}&slug=${name}\" > \"${JSONFILE}.part\""
            $TORIFYCMD curl -H "X-CMC_PRO_API_KEY: $COINMARKETCAP_API_KEY" -H "Accept: application/json" -s "${DATAURL}quotes/latest${CONVERT}&slug=${name}" >"${JSONFILE}.part"
            firstLine=$(head -n 1 "${JSONFILE}.part")
            if [ "${firstLine,,}" == "<!doctype html>" ] || [ "${firstLine}" == "<html>" ]; then
                errorstatus=600
            else
                errorstatus=$(jq <"${JSONFILE}.part" "[.status.error_code][]" 2>/dev/null)
            fi
            if [ "$errorstatus" != "0" ]; then
                echo "${0##*/}: ${red}Error: The https://coinmarketcap.com/ API returned error code \"$errorstatus\". Aborting.${reset}"
                echo "${0##*/}:     400 400 Bad Request"
                echo "${0##*/}:    1002 401 Unauthorized"
                echo "${0##*/}:    1006 403 Forbidden"
                echo "${0##*/}:    1008 429 Too Many Requests"
                echo "${0##*/}:     500 500 Internal Server Error"
                echo "${0##*/}:     600 600 API responded with HTML page. Maybe a CAPTCHA. Using TOR?"
                echo "${0##*/}: Timestamp:  $(jq <"${JSONFILE}.part" 2>/dev/null | "[.status.timestamp][]" 2>/dev/null)"
                echo "${0##*/}: Message:    $(jq <"${JSONFILE}.part" 2>/dev/null | "[.status.error_message][]" 2>/dev/null)"
                echo "${0##*/}: Reason:     Maybe you entered an unknown symbol or unknown name."
                echo "${0##*/}:             Or something else failed on server."
                exit "$ret"
            fi
            # shellcheck disable=SC2046
            if [ $(grep -c "id not found" "${JSONFILE}.part") -eq 1 ]; then
                echo "${0##*/}: ${yellow}WARNING: No crypto currency with name \"$name\" was not found.${reset} Skipping it."
            else
                key=$(jq <"${JSONFILE}.part" "[.data][] | keys" | jq .[]) # assign the id, name
                # echo $key  ==>  "1"  for bitcoin
                entry=$(jq <"${JSONFILE}.part" "[.data][].$key")
                if [ "$isfirst" == "true" ]; then
                    isfirst="false"
                else
                    echo -e ",\n" >>"${JSONFILE}"
                fi
                echo -e "\n${entry}\n" >>"${JSONFILE}"
            fi
        done
        echo -e "\n]\n" >>"${JSONFILE}"
        rm -f "${JSONFILE}.part"
    else
        LIMIT="&limit=${TOP}"
        if [ $TOP -gt $TOPDEFAULT ]; then
            echo -n "be patient ..."
        fi
        [ "$DEBUG" == "true" ] && echo "${0##*/}: DEBUG: $TORIFYCMD curl -H \"X-CMC_PRO_API_KEY: $COINMARKETCAP_API_KEY\" -H \"Accept: application/json\" s \"${DATAURL}listings/latest${CONVERT}${LIMIT}&start=1\" > \"${JSONFILE}\""
        $TORIFYCMD curl -H "X-CMC_PRO_API_KEY: $COINMARKETCAP_API_KEY" -H "Accept: application/json" -s "${DATAURL}listings/latest${CONVERT}${LIMIT}&start=1" >"${JSONFILE}"
        if [ $TOP -gt $TOPDEFAULT ]; then
            echo -e -n "\b\b\b\b\b\b\b\b\b\b\b\b\b\b              \b\b\b\b\b\b\b\b\b\b\b\b\b\b" # erase "be patient ..."
        fi
        firstLine=$(head -n 1 "${JSONFILE}")
        if [ "${firstLine,,}" == "<!doctype html>" ] || [ "${firstLine}" == "<html>" ]; then
            errorstatus=600
        else
            errorstatus=$(jq <"${JSONFILE}" "[.status.error_code][]" 2>/dev/null)
        fi
        if [ "$errorstatus" != "0" ]; then
            echo "${0##*/}: ${red}Error: The https://coinmarketcap.com/ API returned error code \"$errorstatus\". Aborting.${reset}"
            echo "${0##*/}:     400 400 Bad Request"
            echo "${0##*/}:    1002 401 Unauthorized"
            echo "${0##*/}:    1006 403 Forbidden"
            echo "${0##*/}:    1008 429 Too Many Requests"
            echo "${0##*/}:     500 500 Internal Server Error"
            echo "${0##*/}:     600 600 API responded with HTML page. Maybe a CAPTCHA. Using TOR?"
            echo "${0##*/}: Timestamp:  $(jq <"${JSONFILE}" 2>/dev/null | "[.status.timestamp][]" 2>/dev/null)"
            echo "${0##*/}: Message:    $(jq <"${JSONFILE}" 2>/dev/null | "[.status.error_message][]" 2>/dev/null)"
            echo "${0##*/}: Reason:     Maybe you entered an unknown symbol or unknown name."
            echo "${0##*/}:             Or something else failed on server."
            exit "$ret"
        fi
    fi
    setSeperator
    ii=0
    morelines="true"
    echo -e -n "be patient ..."
    # shellcheck disable=2086
    table=$(while [ ${morelines} == "true" ]; do
        if [ "$useccnameslist" == "true" ]; then
            ret=$(jq <"${JSONFILE}" ".[$ii]")
        else
            ret=$(jq <"${JSONFILE}" "[.data[$ii]][]")
        fi
        if [ "$ret" == "null" ]; then
            morelines="false"
            ii=$((ii - 1))
        else
            if [ $ii -eq 0 ]; then
                printHeader
            fi
            processEntry "$ret"
            if [ $? -eq $ALLMATCHED ]; then
                morelines="false"
            fi
            ii=$((ii + 1))
        fi
    done)
    echo -e -n "\b\b\b\b\b\b\b\b\b\b\b\b\b\b              \b\b\b\b\b\b\b\b\b\b\b\b\b\b" # erase "be patient ..."
    echo "$table" | tr -s "\t" " " | tr -s " " | column -t $COLUMNOPTIONS |
        sed -e "s/\(\+[0-9]*\.[0-9]*%\)/${green}\1${reset}/g" \
            -e "s/\(\-[0-9]*\.[0-9]*%\)/${red}\1${reset}/g" \
            -e "s/\(\+[0-9]*\,[0-9]*%\)/${green}\1${reset}/g" \
            -e "s/\(\-[0-9]*\,[0-9]*%\)/${red}\1${reset}/g"
    echo "Market data source: ${yellow}https://www.coinmarketcap.com${reset} on $(date)"
} # function main

main "$@"

# end of script

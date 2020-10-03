![coinbash.sh logo](https://raw.githubusercontent.com/8go/coinbash/master/coinbash-logo.png)


# 💰 A bash script (CLI) for displaying crypto currencies market data in a terminal 🖥

## Summary

* Check cryptocurrencies' prices, price changes, market cap, trading volume and more on your console.
* Simple and easy CLI tool for those who are both **Crypto investors** and **Engineers**. 
  Ideal for anyone who likes the terminal.
* A single-file bash script. There is only `coinbash.sh`. There are no config files or any other files.
* CLI only. No fancy graphics, no windows.
* Tested on Debian and Ubuntu
* Dependencies: bash, curl, jq, coinmarketcap-API-key
* Uses cloud API of https://pro-api.coinmarketcap.com/v1
* **YOU MUST HAVE YOUR OWN coinmarketcap-API-key**
  * Without your API key it will *not* work
  * As of Oct 2020 you can get an API key for *free* at https://coinmarketcap.com
  * Set the global environment variable `COINMARKETCAP_API_KEY` to your personal coinmarketcap-API-key,
  * e.g by placing a line like this into your `.bashrc` file 
    * `export COINMARKETCAP_API_KEY="your-coinmarketcap-API-key-here"`
* Keywords: CLI, command-line, terminal, bash, market-data, ticker, price-tracker, marketcap, crypto, crypto currencies, cryptocurrency, bitcoin, btc, ethereum
* License: [GPL v3](https://www.gnu.org/licenses/gpl-3.0.en.html)
* Inspired by [https://github.com/bichenkk/coinmon](https://github.com/bichenkk/coinmon)


## Install

There is no install. Download the release. Copy the single bash file `coinbash.sh` wherever you want, preferably some directory included in your `PATH`.
If not already installed and only on the first run, `coinbash.sh` will install the small packages `curl` and `ql`. Set the environment variable `COINMARKETCAP_API_KEY` to your personal coinmarketcap-API-key. Ready to go!

## Build

There is nothing to build or compile. Just download the release. And run the `coinbash.sh` bash script.

## Development

You are welcome to fork your own or contribute by providing a Pull Request.

## Usage

To get the basic information on the top 10 cryptocurrencies ranked by their market cap, simply enter
```
$ coinbash.sh
```

## Options

There are many options. Please run `coinbash.sh --help` to see them all. 
You can use the `-f` (or `--fiat`) followed by a currency symbol to get the prices in your local currency, crypto, or metal ounces.
* The default currency is USD.
* It supports crypto currencies: BTC, ETH, USDT, XRP, BCH, BNB, DOT, LINK, CRO, BSV, LTC. 
* It supports metals: XAU, XAG, XPT, XPD. 
* It supports local FIAT currencies: AUD, BRL, CAD, CHF, CLP, CNY, CZK, DKK, EUR, GBP, HKD, HUF, IDR, ILS, INR, JPY,  KRW, MXN, MYR, NOK, NZD, PHP, PKR, PLN, RUB, SEK, SGD, THB, TRY, TWD, ZAR. 

```
$ coinbash.sh -f BTC # get prices in BTC (Bitcoin)
$ coinbash.sh -f AUD # get prices in Australian Dollars
$ coinbash.sh -f XAU # get prices in Gold ounces
```

`-e` or `--eur` is a shortcut for Euros, a shortcut for `-f EUR`. 

```
$ coinbash.sh -e # get prices in Euros
```

Use `-n` or `--top` followed by a number to get the top _n_ crypto currencies, ranked by their market cap. 

```
$ coinbash.sh -n 12 # get information on the top 12 crypto currencies
```

You can use the `-l` (or `--listbysymbols`) with coin symbol to search cryptocurrencies by their symbols. Add symbols seperated by commas. 

```
$ coinbash.sh -l btc,eth,ltc # get information for Bitcoin (BTC), Ethereum (ETH) and Litecoin (LTC)
```

You can use the `-i` (or `--listbynames`) with coin name to search cryptocurrencies by their names. Add names seperated by commas.

```
$ coinbash.sh -i bitcoin-cash,ethereum-classic # lists Bitcoin Cash (BCH) and Ethereum Classic (ETC)
```

You can use the `-h` (or `--help`) to get help and to see all available options as well as examples.

```
$ coinbash.sh -h # get help
```

Help returns the following
```
coinbash.sh: Usage: coinbash.sh [--help] [--debug] [--version] [--verbose] [--torify]
coinbash.sh:                    [--top <NUMBER>]  [--depth <NUMBER>] 
coinbash.sh:                    [--listbysymbols <CRYPTO1SYMBOL,CRYPTO2SYMBOL,ETC>]
coinbash.sh:                    [--listbynames <CRYPTO1NAME,CRYPTO2NAME,ETC>]
coinbash.sh:                    [--eur] [--fiat <CURRENCY>]
coinbash.sh:        coinbash.sh --cleanup 
coinbash.sh: Version: 2020-OCT-03
coinbash.sh: License: GPL v3 https://www.gnu.org/licenses/gpl-3.0.en.html
coinbash.sh: Source: https://github.com/8go/coinbash
coinbash.sh: coinbash.sh requests data from www.coinmarketcap.com and lists market info on 
coinbash.sh:          the most valuable crypto currencies.
coinbash.sh: If necessary it installs packages jq and curl.
coinbash.sh: Inspiration and basic idea from https://github.com/bichenkk/coinmon
coinbash.sh: Real-time market data from https://www.coinmarketcap.com
coinbash.sh: The default currency is USD and it supports BTC, ETH, USDT, XRP, BCH, BNB, DOT, 
coinbash.sh:          LINK, CRO, BSV, LTC, XAU, XAG, XPT, XPD, AUD, BRL, CAD, CHF, CLP, CNY, CZK, 
coinbash.sh:          DKK, EUR, GBP, HKD, HUF, IDR, ILS, INR, JPY, KRW, MXN, MYR, NOK, NZD, 
coinbash.sh:          PHP, PKR, PLN, RUB, SEK, SGD, THB, TRY, TWD, ZAR.
coinbash.sh: coinbash.sh uses a temporary file /tmp/coinbash.sh.tmp.json which gets automatically removed.
coinbash.sh: Example: coinbash.sh       ...  prints top 10 crypto currencies, 
coinbash.sh:                              uses default USD for prices
coinbash.sh: Example: coinbash.sh -n 3  ...  prints market info of top 3 crypto currencies, 
coinbash.sh:                              uses USD for prices
coinbash.sh: Example: coinbash.sh -t -n 5  ...  uses Tor onion network, prints market info of 
coinbash.sh:                              top 5 crypto currencies, uses USD for prices
coinbash.sh: Example: coinbash.sh -t -n 7 -e ...  uses Tor, prints market info of top 7 crypto currencies, 
coinbash.sh:                              uses EUR for prices
coinbash.sh: Example: coinbash.sh -e  ...  shortcut for -f EUR, uses Euro for prices
coinbash.sh: Example: coinbash.sh -f BTC  ...  gives prices in Bitcoin (BTC)
coinbash.sh: Example: coinbash.sh -f XAU  ...  gives prices in Gold Troy ounces (XAU)
coinbash.sh: Example: coinbash.sh -f AUD  ...  gives prices in Australian Dollars (AUD)
coinbash.sh: Example: coinbash.sh -l btc  ...  lists only BTC
coinbash.sh: Example: coinbash.sh -l btc,eth,ltc  ...  lists BTC, ETH and LTC 
coinbash.sh:                              (by default searches are limited to the top 100 crypto currencies)
coinbash.sh: Example: coinbash.sh -l btc,eth,rev -p 1000  ...  lists BTC, ETH and REV 
coinbash.sh:                              (searches in the top 1000 crypto currencies)
coinbash.sh: Example: coinbash.sh -t -f EUR -l btc,sc,btcd -p 100  ...  lists BTC, SC and BTCD 
coinbash.sh:                              by searching in the top 100 crypto currencies,
coinbash.sh:                              communicates via Tor and uses Euros for prices
coinbash.sh: Example: coinbash.sh -t -f EUR -i bitcoin-cash, ethereum-classic  ...  lists BCH and ETC 
coinbash.sh:                              by searching all crypto currencies,
coinbash.sh:                              communicates via Tor and uses Euros for prices
coinbash.sh: Arguments are:
coinbash.sh: --help, -h
coinbash.sh:    HELP: Prints the help text and exits. [type: flag]
coinbash.sh: --version, -v
coinbash.sh:    VERSION: Same as --help [type: flag]
coinbash.sh: --debug, -d
coinbash.sh:    DEBUG: Turns debug output on, default is off [type: flag]
coinbash.sh: --cleanup, -c
coinbash.sh:    DO-ONLY-CLEANUP: Performs only cleanup, then exits [type: flag]
coinbash.sh: --torify, -t
coinbash.sh:    TORIFY: Request the data via Tor onion network [type: flag]
coinbash.sh:    This was disabled in latest version of Coinmarketcap.com API.
coinbash.sh: --top, -n
coinbash.sh:    TOP: How many crypto currencies should be displayed [type: integer] [default: 10]
coinbash.sh: --fiat, -f
coinbash.sh:    FIAT: Specify fiat currency for prices [type: string] [default: USD]
coinbash.sh: --eur, -e
coinbash.sh:    EUR: Use EUR as fiat currency instead of default USD, shortcut for -f EUR [type: flag]
coinbash.sh: --listbysymbols, -l
coinbash.sh:    LIST-BY-SYMBOLS: List of crypto currencies to display, 
coinbash.sh:    comma-separated space-less string of symbols like "btc,eth,ltc" [type: string]
coinbash.sh:    If option -l is used then options -n and -i should not be used.
coinbash.sh: --listbynames, -i
coinbash.sh:    LIST-BY-NAMES: List of crypto currencies to display, comma-separated 
coinbash.sh:    space-less string of names like "bitcoin-cash,ethereum-classic" [type: string]
coinbash.sh:    If option -i is used then options -n, -p and -l should not be used.
coinbash.sh: --depth, -p
coinbash.sh:    DEPTH: When listing by symbols (-l) search the top "depth" 
coinbash.sh:    crypto currencies for the symbols [type: integer] [default: 100]
coinbash.sh:    The larger the value for -p the longer execution will take.
coinbash.sh: --verbose, -w
coinbash.sh:    VERBOSE: Verbose listing of information including supply data, etc. [type: flag]
```

## Screenshots

![screenshot 1](https://raw.githubusercontent.com/8go/coinbash/master/coinbash-screenshot.png)

![screenshot 2](https://raw.githubusercontent.com/8go/coinbash/master/coinbash-screenshot-top12.png)

![screenshot 3](https://raw.githubusercontent.com/8go/coinbash/master/coinbash-screenshot-listbysymbols.png)

![screenshot 4](https://raw.githubusercontent.com/8go/coinbash/master/coinbash-screenshot-listbynames.png)

![screenshot 5](https://raw.githubusercontent.com/8go/coinbash/master/coinbash-screenshot-all.png)

## Enjoy!

Built with :heart: for your enjoyment!


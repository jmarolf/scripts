#! /usr/bin/env bash

which -s brew
if [[ $? != 0 ]] ; then
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
    brew update
    brew upgrade
fi

## Applications
brew install discord
brew install eloston-chromium
brew install vlc

## CLI Applications
brew install git
brew install oh-my-posh
brew install gh
brew install neovim
brew install ripgrep

## Git Extras 
brew install git-credential-manager-core
brew install git-delta
brew install git-extras
brew install git-lfs

## CLI Setup
brew install fish

## Dev Env
brew install ack
brew install autoconf
brew install automake
brew install bdw-gc
brew install betterzip
brew install brotli
brew install c-ares
brew install ca-certificates
brew install cmake
brew install coreutils
brew install findutils
brew install gnupg
brew install gdbm
brew install gettext
brew install glances
brew install gmp
brew install gnutls
brew install go
brew install guile
brew install icu4c
brew install jq
brew install libassuan
brew install libevent
brew install libffi
brew install libgcrypt
brew install libgpg-error
brew install libidn2
brew install libksba
brew install libnghttp2
brew install libssh2
brew install libtasn1
brew install libtool
brew install libunistring
brew install libusb
brew install libuv
brew install m4
brew install moreutils
brew install mpdecimal
brew install ncurses
brew install nettle
brew install node
brew install npth
brew install oniguruma
brew install openssl@1.1
brew install openssl@3
brew install p11-kit
brew install p7zip
brew install pandoc
brew install pcre2
brew install pinentry
brew install pkg-config
brew install platypus
brew install powershell
brew install python@3.10
brew install qlcolorcode
brew install qlimagesize
brew install qlmarkdown
brew install qlprettypatch
brew install qlstephen
brew install qlvideo
brew install quicklook-csv
brew install quicklook-json
brew install quicklookase
brew install rar
brew install readline
brew install rename
brew install rust
brew install sqlite
brew install tree
brew install unbound
brew install webpquicklook
brew install wget
brew install xz
brew install yarn
brew install youtube-dl

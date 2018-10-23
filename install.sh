#!/usr/bin/env bash

# Install brew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Install command-line tools using Homebrew.

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade --all

# Install GNU core utilities (those that come with macOS are outdated).
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
brew install coreutils
ln -s /usr/local/bin/gsha256sum /usr/local/bin/sha256sum

# Install some other useful utilities like `sponge`.
brew install moreutils
# Install GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed.
brew install findutils
# Install GNU `sed`, overwriting the built-in `sed`.
brew install gnu-sed --with-default-names

# Install zsh
brew install zsh

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# jcl theme
wget https://raw.github.com/jasonlewis/jcl-zsh-theme/master/jcl.zsh-theme
mv jcl.zsh-theme ~/.oh-my-zsh/themes/jcl.zsh-theme

# Note: don’t forget to add `/usr/local/bin/zsh` to `/etc/shells` before
# running `chsh`.
chsh -s $(which zsh)

# Install `wget` with IRI support.
brew install wget --with-iri

# Install more recent versions of some macOS tools.
brew install vim --with-override-system-vi
brew install grep
brew install openssh
brew install screen

# Install PHP, MySQL, redis and beanstalkd
brew install php72
brew install mysql@5.7 && brew link mysql@5.7 --force
brew install redis
brew install beanstalkd

cp ./../config/php-memory-limits.ini /usr/local/etc/php/7.2/conf.d/php-memory-limits.ini

# Install Python and usefull stuff
brew install pkg-config libffi openssl python
env LDFLAGS="-L$(brew --prefix openssl)/lib" CFLAGS="-I$(brew --prefix openssl)/include" pip install cryptography==1.9
pip install stronghold

# Install node, npm, yarn, gulp and grunt
brew install node
brew postinstall node
npm -g install yarn
# npm -g install gulp
# npm -g install grunt-cli

# Launch Redis on mac starts
ln -sfv /usr/local/opt/redis/*.plist ~/Library/LaunchAgents

# Install font tools.
brew tap bramstein/webfonttools
brew install sfnt2woff
brew install sfnt2woff-zopfli
brew install woff2

# Install some CTF tools; see https://github.com/ctfs/write-ups.
sudo ln -s /System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport /usr/local/sbin/airport
brew install aircrack-ng
brew install bfg
brew install binutils
brew install binwalk
brew install cifer
brew install dex2jar
brew install dns2tcp
brew install fcrackzip
brew install foremost
brew install hashpump
brew install hashcat
brew install hashcat-utils
brew install hydra
brew install john
brew install knock
brew install netpbm
brew install nmap
brew install ngrep
brew install pngcheck
brew install socat
brew install sqlmap
brew install tcpflow
brew install tcpreplay
brew install tcptrace
brew install ucspi-tcp # `tcpserver` etc.
brew install xpdf
brew install xz

# Install other useful binaries.
brew install ack
brew install dark-mode
brew install git
brew install git-extras
brew install imagemagick --with-webp
brew install p7zip
brew install speedtest-cli
brew install ssh-copy-id
brew install tmux
brew install pandoc # convert doc files
brew install ghi
brew install git-town
brew install hub
brew install htop
brew install mackup
brew install innotop #innodb top cmd
brew install mycli  
brew install mas
#brew tap git-time-metric/gtm
#brew install gtm
# brew install testssl
# brew install git-lfs
# brew install lua
# brew install lynx
# brew install pigz
# brew install pv
# brew install rename
# brew install tree
# brew install vbindiff
# brew install webkit2png
# brew install zopfli
# brew install xpdf

# Install brew cask and other apps
brew tap phinze/homebrew-cask
brew install brew-cask
brew cask install alfred
brew cask install iterm2
brew cask install caffeine
brew cask install spectacle
brew cask install imageoptim
brew cask install dropbox
brew cask install github
brew cask install sequel-pro
brew cask install sublime-text
brew cask install the-unarchiver
brew cask install java
brew cask install flux
brew cask install flycut
brew cask install qlmarkdown # Add quicklook view for markdown files
brew cask install cakebrew
brew cask install vlc
brew cask install steam
brew cask install keybase
brew cask install kap
#brew cask install slack
#brew cask install 0ad
#brew cask install docker
#brew cask install https://raw.githubusercontent.com/Mortennn/Dozer/master/dozer.rb
#brew cask install sandman

# Install apps from App Store
mas lucky Things3
mas lucky Bear
mas lucky Wallcat

# Add sublime command
ln -s "/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl" /usr/local/bin/subl
ln -s "/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl" /usr/local/bin/sublime

# Remove outdated versions from the cellar.
brew cleanup & brew prune

# Install composer 
curl -sS https://getcomposer.org/installer | php

sudo mv composer.phar /usr/local/bin/composer

composer global require laravel/valet
composer global require laravel/installer
composer global require phpunit/phpunit
composer global require friendsofphp/php-cs-fixer

~/.composer/vendor/bin/valet install

# Park valet in ~/Projects
mkdir -p ~/Projects && cd ~/Projects
~/.composer/vendor/bin/valet park

# Install Fonts
sh fonts.sh

# Install Xdebug -> https://xdebug.org/wizard.php
cd ~/Projects
wget -qO- http://xdebug.org/files/xdebug-2.6.0.tgz | tar -xvz
cd xdebug-2.6.0 && phpize && ./configure && make
cp modules/xdebug.so "$(php-config --extension-dir)"/xdebug.so
rm -Rf ~/Projects/xdebug-2.6.0

# List services to check them
brew services list
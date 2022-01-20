# docker-compose-mediawiki-mysql-redis-elasticsearch

Docker Compose for MediaWiki with MariaDB, Redis and Elastic Search.

### Requirements

**MacOS:**
Install [Docker](https://docs.docker.com/docker-for-mac/install/) and [docker-sync](http://docker-sync.io/)

**Linux:** 
Install [Docker](https://docs.docker.com/engine/installation/linux/docker-ce/ubuntu/) and [Docker-compose](https://docs.docker.com/compose/install/#install-compose).
> on Debian based OS (Example: Ubuntu, Linux Mint) use `bin/docker.sh` instead of following the above two links 

### Automated docker nginx proxy integrated with letsencrypt

In front of the containers you can configure an nginx reverse proxy (with auto letsencrypt) that creates the "proxy" network:

> https://github.com/evertramos/nginx-proxy-automation

Configuration

    cd ~
    mkdir docker; 
    cd docker;
    git clone --recurse-submodules https://github.com/evertramos/nginx-proxy-automation.git proxy
    cd proxy
    cp .env.sample .env
    vim .env  (changed only DEFAULT_EMAIL=user@domain.com)
    cd bin && ./fresh-start.sh --yes -e user@domain.com --skip-docker-image-check

### Mediawiki install and conf
    
    git clone https://github.com/allanext/docker-compose-mediawiki-mysql-redis-elasticsearch.git
## Configuration

    cp .env.sample .env
     
> Change the environment variable in the .env file

> Change the docker-compose.yml configuration

I find it convenient to associate an IP address to the database container in order to ssh tunnel the server and connect directly to the db.
## Install

    docker-compose up --build

## Install MediaWiki

> Open your browser and go to your newly configured domain to install the MediaWiki web app

> Download the LocalSettings.php and copy it to the config folder

Copy the installed database and wiki extensions to the host:

    docker cp wiki_db:/var/lib/mysql db
    docker cp wiki:/var/www/html/extensions extensions

> In the LocalSettings.php uncomment the volumes map entries for the ./config/LocalSettings.php and ./extensions folder:

    volumes:
      - ./images:/var/www/html/images
      # After initial setup, download LocalSettings.php and extensions to the same directory 
      # (e.g. docker cp wiki:/var/www/html/LocalSettings.php ./ ) as this yaml and uncomment
      # the following lines and use compose to restart the mediawiki service
      - ./config/LocalSettings.php:/var/www/html/LocalSettings.php
      - ./extensions:/var/www/html/extensions/
  
Restart your containers:

    docker-compose stop
    docker-compose start
    
## Install Elastic Search

> To install elasticsearch follow these guides:

    https://www.mediawiki.org/wiki/Extension:CirrusSearch#Configuration
    https://gerrit.wikimedia.org/g/mediawiki/extensions/CirrusSearch/%2B/HEAD/README

Chante the permissions to the elastic_data mapped volume:

    chown -R 1000:1000 elastic_data/

> The host needs to set something like:
    
    sudo sysctl -w vm.max_map_count=262144

#### Support
If you encounter any problems or bugs, please create an issue on [GitHub](https://github.com/allanext/docker-compose-mediawiki-mysql-redis-elasticsearch/issues).

#### Contribute
Please Contribute by creating a fork of this repository.  
Follow the instructions here: https://help.github.com/articles/fork-a-repo/

#### License
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://openng.de/source.org/licenses/MIT)
FROM debian/eol:jessie

ENV http_proxy=http://10.55.3.120:3128
ENV https_proxy=http://10.55.3.120:3128
COPY apt.conf /etc/apt/apt.conf
COPY sources.list /etc/apt/sources.list

# CONFIGURA LOCALE
ENV OS_LOCALE="en_US.UTF-8"

RUN \
    apt-get update && apt-get upgrade -y \
    && apt-get install -y --no-install-recommends --no-install-suggests locales \
    && sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen \
    && locale-gen

ENV LANG=${OS_LOCALE} \ 
    LANGUAGE=${OS_LOCALE} \
    LC_ALL=${OS_LOCALE} \
    DEBIAN_FRONTEND=noninteractive

RUN \
    dpkg-reconfigure --frontend=noninteractive locales \
    && apt-get install -y --no-install-recommends --no-install-suggests curl \
      apache2 \
      libapache2-mod-php5 \
      php5 \
      php5-cli \
      php5-common \
      php5-curl \
      php5-dev \
      php5-gd \
      php5-json \
      php5-ldap \
      php5-mcrypt \
      php5-mysql \
      php5-odbc \
      php5-readline \
      php5-sybase \
      php5-xdebug \
      php5-xmlrpc \
    && a2enmod rewrite php5 \
    && apt-get autoremove -y \
    && apt-get clean


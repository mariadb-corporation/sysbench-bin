# Sysbench

## About

This repo contains [sysbench](https://github.com/akopytov/sysbench) binary version (CentoOS 7) along with lua scrips which MariaDB performance team uses for performance testings.

## Building sysbench from the source

Commands below applies to the CentOS 7. Sysbench will be linked with MariaDB libraries (not MySQL). 

Install operating system support packages:

```bash
yum -y install make automake libtool pkgconfig libaio-devel
yum -y install openssl-devel zlib-devel
```

Setup MariaDB repo:
```bash
curl -sS https://downloads.mariadb.com/MariaDB/mariadb_repo_setup | sudo bash
sudo yum -y install MariaDB-shared MariaDB-devel    # this will also install MariaDB-client MariaDB-common 
```

Clone and build sysbench:
```bash
sudo yum install git
mkdir tools 
git clone https://github.com/hgxl64/sysbench-1.x-mariadb
cd sysbench-1.x-mariadb
./autogen.sh
./configure  --with-mysql-includes=/usr/include/mysql   --with-mysql-libs=/usr/lib64/ --disable-shared --enable-static

make 
sudo make install
sysbench --version
```
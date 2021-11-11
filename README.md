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

Setup MariaDB repo (See Amazon Linux below):

```bash
curl -sS https://downloads.mariadb.com/MariaDB/mariadb_repo_setup | sudo bash
sudo yum -y install MariaDB-shared MariaDB-devel    # this will also install MariaDB-client MariaDB-common 
```

For Amazon Linux setup the repo using old way:

```bash
sudo tee /etc/yum.repos.d/mariadb.repo<<EOF
[mariadb]
name = MariaDB
baseurl = http://yum.mariadb.org/10.6/centos7-amd64/
gpgkey=https://yum.mariadb.org/RPM-GPG-KEY-MariaDB
gpgcheck=1
EOF
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
/usr/local/bin/sysbench --version
```

## Known issues

You might experience 'unsupported encoding' error:

```bash
[1024] Generic Error: unsupported encoding 4
```

Please check all possible locations for my.cnf and check if the character set was set to anything from UTF8. The last resort is to use ‘SET NAMES utf8’ as the first statement in the sysbench Lua file.

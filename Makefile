install: install-netdata install-kataribe install-slowquery

install-netdata:
	bash <(curl -Ss https://my-netdata.io/kickstart-static64.sh) --dont-wait --no-updates

install-kataribe:
	cd /tmp
	wget -O kataribe.zip https://github.com/matsuu/kataribe/releases/download/v0.4.1/kataribe-v0.4.1_linux_amd64.zip
	unzip kataribe.zip

install-slowquery:
	mysql -uroot -e "SET GLOBAL slow_query_log_file = '/var/log/mysql/slow_query.log';"
	mkdir /var/log/mysql
	touch /var/log/mysql/slow_query.log
	chown mysql.mysql -R /var/log/mysql

install-passenger:
	sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 561F9B9CAC40B2F7
	sudo apt-get install -y apt-transport-https ca-certificates
	sudo sh -c 'echo deb https://oss-binaries.phusionpassenger.com/apt/passenger bionic main > /etc/apt/sources.list.d/passenger.list'
	sudo apt-get update
	sudo apt-get install -y passenger
	passenger-config validate-install

# shortcut commands

kataribe:
	cat /var/log/nginx/access.log | kataribe/kataribe -f kataribe/kataribe.toml

slowquery:
	mysqldumpslow -s t -t 5 /var/log/mysql/mysql-slow.log

claerlog:
	cp /dev/null /var/log/nginx/access.log
	cp /dev/null /var/log/mysql/mysql-slow.log


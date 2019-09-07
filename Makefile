install: install-netdata install-kataribe install-slowquery

install-netdata:
	bash <(curl -Ss https://my-netdata.io/kickstart-static64.sh) --dont-wait --no-updates

install-kataribe:
	wget -O kataribe.zip https://github.com/matsuu/kataribe/releases/download/v0.4.1/kataribe-v0.4.1_linux_amd64.zip
	unzip kataribe.zip
	./kataribe -generate

install-slowquery:
	mysql -uroot -e "SET GLOBAL slow_query_log = ON;" isucari
	mysql -uroot -e "SET GLOBAL long_query_time = 5;" isucari
	mysql -uroot -e "SET GLOBAL slow_query_log_file = '/var/log/mysql/slow_query.log';" isucari
	touch /var/log/mysql/slow_query.log
	chown mysql.mysql -R /var/log/mysql

install-passenger:
	sudo apt-get install -y dirmngr gnupg
	sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 561F9B9CAC40B2F7
	sudo apt-get install -y apt-transport-https ca-certificates
	sudo sh -c 'echo deb https://oss-binaries.phusionpassenger.com/apt/passenger bionic main > /etc/apt/sources.list.d/passenger.list'
	sudo apt-get update
	sudo apt-get install -y libnginx-mod-http-passenger
	if [ ! -f /etc/nginx/modules-enabled/50-mod-http-passenger.conf ]; then sudo ln -s /usr/share/nginx/modules-available/mod-http-passenger.load /etc/nginx/modules-enabled/50-mod-http-passenger.conf ; fi
	sudo ls /etc/nginx/conf.d/mod-http-passenger.conf
	passenger-memory-stats


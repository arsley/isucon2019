up-db:
	docker-compose up -d db
	docker-compose exec db /sql/wait-for-it.sh db:3306
	docker-compose exec db mysql -uroot -hlocalhost -e 'source /sql/00_create_database.sql'
	docker-compose exec db mysql -uroot -hlocalhost -e 'source /sql/01_schema.sql'
	docker-compose exec db mysql -uroot -hlocalhost -e 'source /sql/02_categories.sql'

init-app:
	docker-compose run --rm webapp npm i

build-app:
	docker-compose run --rm webapp npm run build

up-app:
	docker-compose up -d webapp

up: up-db init-app build-app up-app

down:
	docker-compose down

stop:
	docker-compose stop

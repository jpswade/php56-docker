#!make

build:
	docker build . -t php56-docker

run:
	docker run -d -p 80:80 --name my-laravel-app -v "$PWD":/var/www php56-docker

up:
	docker-compose up -d --build

push:
	docker tag php56-docker jpswade/php56-docker
	docker push jpswade/php56-docker

bash:
	docker run -it --entrypoint bash php56-docker

exec:
	docker-compose exec web bash
#!make

build:
	docker build . -t php56-docker

up:
	docker-compose up -d --build

push:
	docker tag php56-docker jpswade/php56-docker
	docker push jpswade/php56-docker

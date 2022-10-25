# 도커 컴포즈를 돌리는 Makefile

kill:
	cd src && docker-compose kill

build:
	cd src && docker-compose up

down:
	cd src && docker-compose down

.PHONY: kill build down

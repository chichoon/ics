# 도커 컴포즈를 돌리는 Makefile

kill:
	docker-compose kill

build:
	cd src && docker-compose up

down:
	docker-compose down

.PHONY: kill build down

# 도커 컴포즈를 돌리는 Makefile

kill:
	cd srcs && docker-compose kill

build:
	cd srcs && docker-compose up

down:
	cd srcs && docker-compose down

.PHONY: kill build down

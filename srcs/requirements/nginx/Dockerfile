# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: jiychoi <jiychoi@student.42seoul.kr>       +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/11/18 10:59:57 by jiychoi           #+#    #+#              #
#    Updated: 2022/11/21 16:32:37 by jiychoi          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM debian:buster

#  penultimate stable version of Alpine Linux => 가장 최신에서 두 번째 버전을 사용하라는 뜻
# alpine은 apt-get 을 못 씀
# gnu 대신 busybox를 쓰기 때문에 gnu 옵션들을 못 씀
# busybox 는 모든 명령어가 하나의 실행 파일에 들어있기 때문에 용량이 줄어듦 (중복 파일 등이 다 사라지기 때문)

# 도커에서는 모든 명령이 sudo 로 들어가기 때문에 (root 계정임) sudo를 붙일 필요가 없다

# TLS란? Transportation Layer Security
# 버전을 높일 수록 보안성이 높아지지만 호환성을 위해 버전을 낮추는 경우가 있음
# 버전별로 보안에 대한 규격이 다르다 => 1.2 이상을 사용해야 하고, 1.2와 1.3을 같이 사용하면 옛날 버전까지 커버할 수 있음


RUN apt-get update -y && apt-get upgrade -y && \
	apt-get -y install nginx openssl
# -y 플래그는 yes 라는 뜻: apt-get update, upgrade를 할 때 나오는 질문에 자동으로 대답해 줌
# apt-get update를 통해 가장 최신 버전으로 설치할 수 있게 하기

RUN	mkdir /etc/nginx/ssl
# 이거 안하면 ssl 폴더가 없어서 아래 명령어에서 못찾음

RUN openssl req -newkey rsa:2048 -nodes -x509 \
	-subj "/C=KR/ST=Seoul/L=Gangnam/O=Gaepodong/OU=42Seoul/CN=jiychoi.42.fr" \
	-keyout /etc/nginx/ssl/jiychoi.42.fr.key \
	-out /etc/nginx/ssl/jiychoi.42.fr.crt
# 키와 인증서 동시에 생성: https://www.ibm.com/docs/ko/api-connect/5.0.x?topic=profiles-generating-self-signed-certificate-using-openssl
# 각 플래그 해설: https://www.openssl.org/docs/man1.0.2/man1/openssl-req.html
# req: pkcs#10 포맷의 인증서를 생성하고 요청을 처리하는 역할을 한다
# -newkey: arg에 해당하는 키도 같이 생성한다 (rsa:2048 => rsa, 2048비트)
# -days: 인증서 만료 기간 (기본값은 30일이기 때문에 명시 X)
# -nodes: private key가 생성될 경우, 암호화되지 않도록 막는다
# -x509: certificate request 대신 self-signed 인증서를 생성하며, x509는 인증서와 알고리즘 표준 중 하나이다
# -subj: 원래 대화형으로 인증 요청 인자를 받아오지만, subj 플래그를 통해 한 줄로 인자를 넣어줄 수 있다
# -keyout: 인증 키 파일명
# -out: 인증서 파일명
# C: Country code, ST: State or Province, L: Locality, O: Organization, OU: Organization Unit, CN: Common Name (hostname)

COPY ./tools/setup.sh ./
# setup.sh 파일 이동
COPY ./conf/nginx.conf /etc/nginx/conf.d/default.conf
# 실행용 nginx config 파일 경로는 /etc/nginx/conf.d/default에 넣어야한다

EXPOSE 443
# Docker-compose에서의 ports는 도커파일 포트와 로컬 포트를 연결, 여기서는 도커파일 포트를 OPEN

RUN chmod +x ./setup.sh

ENTRYPOINT ["sh", "-c", "./setup.sh"]
# 이미지 빌드 후 바로 setup.sh 실행

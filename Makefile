init:
	docker-compose up -d coredns
	echo COREDNS_IP=`docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' dns-test_coredns_1` > .env
	docker-compose up -d

build:
	docker build --tag hello-forge .

run:
	docker run -p 127.0.0.1:80:3000/tcp hello-forge

sh:
	docker run -it hello-forge sh


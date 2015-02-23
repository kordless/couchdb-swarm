PROJECT = couchdb
REGISTRY = registry.giantswarm.io
USERNAME :=  $(shell swarm user)

docker-build:
	docker build -t $(REGISTRY)/$(USERNAME)/$(PROJECT) .

docker-run:
	docker run -ti -p 5984:5984 -e COUCHDB_PASS="mypass" $(REGISTRY)/$(USERNAME)/$(PROJECT)

docker-push: docker-build
	docker push $(REGISTRY)/$(USERNAME)/$(PROJECT)

docker-pull:
	docker pull $(REGISTRY)/$(USERNAME)/$(PROJECT)

swarm-up: docker-push
	swarm up swarm.json --var=username=$(USERNAME)


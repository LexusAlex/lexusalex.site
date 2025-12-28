docker-build:
	docker compose build --no-cache --pull
	docker image prune -f
docker-build-cache:
	docker compose build --pull
	docker image prune -f
docker-up:
	docker compose up -d
docker-up-build:
	docker compose up -d --remove-orphans --build
docker-down:
	docker compose down --remove-orphans
docker-logs:
	docker compose logs -f
docker-prune-images:
	docker image prune -f
nginx-reload:
	docker compose exec nginx nginx -s reload
nginx-test:
	docker compose exec nginx nginx -t


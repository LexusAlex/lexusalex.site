docker compose -f docker-compose-development.yml run --rm development-backend-benchmark ab -V
docker compose -f docker-compose-development.yml run --rm development-backend-benchmark ab -n 100 -c 100 -d -r http://development-backend-nginx/

Все выполнять только на своих серверах!!!

Тип шифрования можно менять и мерить скорость

https://blog.sedicomm.com/2018/03/22/ispolzovanie-apache-bench-dlya-testirovaniya-nagruzki-na-veb-server/


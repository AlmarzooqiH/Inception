start:
	cd srcs
	docker compose up
	cd ..
stop:
	cd srcs
	docker compose down
	cd ..

restart:
	cd srcs
	docker compose down
	docker compose up
	cd ..

.PHONY: start stop restart
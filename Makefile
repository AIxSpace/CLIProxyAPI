build:
	go build -o cli-proxy-api ./cmd/server

run:
	./cli-proxy-api

start:
	mkdir -p logs
	nohup ./cli-proxy-api > logs/server.log 2>&1 & echo $$! > logs/server.pid

stop:
	if [ -f logs/server.pid ]; then \
		kill $$(cat logs/server.pid) && rm logs/server.pid && echo "Server stopped"; \
	else \
		echo "Server is not running"; \
	fi

restart:
	$(MAKE) stop
	$(MAKE) start

status:
	if [ -f logs/server.pid ]; then \
		if ps -p $$(cat logs/server.pid) > /dev/null; then \
			echo "Server is running (PID: $$(cat logs/server.pid))"; \
		else \
			echo "Server is not running (stale PID file)"; \
			rm logs/server.pid; \
		fi \
	else \
		echo "Server is not running"; \
	fi

.PHONY: build run start stop restart status
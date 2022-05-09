build:
	docker build -t tsvlad/wayd-event:1.0.0 .
run:
	docker run -d -p 8082:8082 --name wayd-event --rm tsvlad/wayd-event:1.0.0
stop:
	docker stop wayd-event
start:
	make build
	make run
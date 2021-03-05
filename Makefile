IMAGE_NAME := minecraft

all:
	docker build -t "$(IMAGE_NAME)" .

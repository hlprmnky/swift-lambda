request_handler: request_handler.swift
	mkdir build
	swiftc -o build/request_handler request_handler.swift

clean:
	rm -rf build

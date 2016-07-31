build/lambda.zip: build/request_handler
	zip -rj build/lambda.zip build/request_handler src/js/wrapper.js

build/request_handler: src/swift/request_handler.swift
	# When this becomes more complex, consider using Swift Package with `swift build`
	mkdir -p build
	swiftc -o build/request_handler src/swift/request_handler.swift

clean:
	rm -rf build

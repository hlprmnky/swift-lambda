build/lambda.zip: build/request_handler src/js/wrapper.js build/lib
	cp src/js/wrapper.js build
	cd build; zip -r lambda.zip request_handler wrapper.js lib

# Copy necessary libraries
# courtesy of https://medium.com/@gigq/using-swift-in-aws-lambda-6e2a67a27e03
# I suspect we can avoid copying some of the sys libs by building on an image
# that better matches the AWS Î runtime environment
swift_libs := $(wildcard /usr/local/lib/swift/linux/*.so) 
sys_lib_dir = /usr/lib/x86_64-linux-gnu
sys_libs = $(sys_lib_dir)/libicui18n.so.55 \
	$(sys_lib_dir)/libicuuc.so.55 \
	$(sys_lib_dir)/libicudata.so.55 \
	$(sys_lib_dir)/libstdc++.so.6
build/lib: $(swift_libs) $(sys_libs)
	mkdir -p build/lib
	cp $(swift_libs) $(sys_libs) build/lib
	#cp $(sys_lib_dir)/libc.so build/lib/libc.so.6

# Compile Swift code
build/request_handler: src/swift/request_handler.swift
	# When this becomes more complex,
	# consider using Swift Package with `swift build`
	mkdir -p build
	swiftc -o build/request_handler src/swift/request_handler.swift
	#swiftc -L /usr/local/lib/swift/linux/ -lpthread -ldl -licui18n -licuuc \
		#-o build/request_handler src/swift/request_handler.swift

.PHONY: clean
clean:
	rm -rf build

SRC = src/bridge.c src/cache.c src/parse-schema.c src/schema.c rtosc/rtosc.c
CFLAGS_ = -std=gnu99 -Wall -Wextra -I .

all: mock-test remote-test lib


mock-test: $(SRC) test/mock-test.c
	$(CC) $(CFLAGS_) -o mock-test $(SRC) test/mock-test.c -lrtosc -luv -g -O0

remote-test: $(SRC) test/basic-remote.c
	$(CC) $(CFLAGS_) -o remote-test $(SRC) test/basic-remote.c -lrtosc -luv -g -O0

lib: $(SRC)
	$(CC) $(CFLAGS) $(CFLAGS_) -O3 -g -fPIC -c $(SRC)
	$(AR) rcs libosc-bridge.a bridge.o cache.o parse-schema.o schema.o

clean:
	rm libosc-bridge.a bridge.o cache.o parse-schema.o schema.o remote-test mock-test

GO=go
EXE=marlowc
BINDATA=go-bindata

COMPILE=$(GO) build
LDFLAGS="-s -w"
BUILD_FLAGS=-x -v -ldflags $(LDFLAGS)

LIBRARY_EXAMPLE_DIR=./
LIBRARY_EXAMPLE_SRC=$(filter-out %.marlow.go, $(wildcard ./**/*.go))
LIBRARY_EXAMPLE_OBJS=$(patsubst %.go,%.marlow.go,$(LIBRARY_EXAMPLE_SRC))
LIBRARY_EXAMPLE_MAIN=./main.go
LIBRARY_DATA_DIR=./data
LIBRARY_EXAMPLE_MODEL_DIR=./models
LIBRARY_BIN_DATA=$(LIBRARY_DATA_DIR)/schema.go
LIBRARY_EXAMPLE_EXE=./library-demo

.PHONY: all clean

all: $(LIBRARY_EXAMPLE_EXE)

$(LIBRARY_EXAMPLE_EXE): $(LIBRARY_EXAMPLE_SRC) $(LIBRARY_EXAMPLE_MAIN)
	$(GO) get -v github.com/lib/pq
	$(GO) get -v github.com/mattn/go-sqlite3
	$(GO) install -v -x github.com/mattn/go-sqlite3
	$(GO) install -v -x github.com/marlow/marlowc
	$(GO) get -u github.com/jteeuwen/go-bindata/...
	$(EXE) -input=$(LIBRARY_EXAMPLE_MODEL_DIR)
	$(BINDATA) -o $(LIBRARY_BIN_DATA) -pkg data data
	$(COMPILE) $(BUILD_FLAGS) -o $(LIBRARY_EXAMPLE_EXE) $(LIBRARY_EXAMPLE_MAIN)

clean:
	rm -rf $(LIBRARY_EXAMPLE_OBJS)
	rm -rf $(LIBRARY_EXAMPLE_EXE)
	rm -rf $(LIBRARY_BIN_DATA)

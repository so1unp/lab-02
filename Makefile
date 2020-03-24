CC=gcc
BIN=./bin
CFLAGS=-Wall -g

PROG=hola ej2 ej3 sh

LIST=$(addprefix $(BIN)/, $(PROG))

.PHONY: all
all: $(LIST)

$(BIN)/%: %.c
	$(CC) -o $@ $< $(CFLAGS)

%: %.c
	$(CC) -o $(BIN)/$@ $< $(CFLAGS)

.PHONY: clean
clean:
	rm -f $(BIN)/ej* $(BIN)/hola $(BIN)/sh

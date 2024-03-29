CC=gcc
BIN=./bin
CFLAGS=-g -Wall -Wextra -Wshadow -Wconversion -Wunreachable-code

PROG=hola scopy sh

LIST=$(addprefix $(BIN)/, $(PROG))

.PHONY: all
all: $(LIST)

$(BIN)/%: %.c
	$(CC) -o $@ $< $(CFLAGS)

%: %.c
	$(CC) -o $(BIN)/$@ $< $(CFLAGS)

test:
	@./test.sh ||:

.PHONY: clean
clean:
	rm -f $(LIST)

dist:
	git archive --format zip --output ${USER}-lab02.zip master

html:
	pandoc -o README.html -f gfm README.md

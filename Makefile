.PHONY: all clean docs

CFLAGS  = -O5
LDFLAGS = -static

all: jt docs

clean:
	rm -f *.o *.a

libjsmn.a: jsmn.o
	$(AR) rc $@ $^

%.o: %.c jsmn.h
	$(CC) -c $(CFLAGS) $< -o $@

jt: jt.o libjsmn.a
	$(CC) $(LDFLAGS) $^ -o $@

jt.1: jt.1.ronn
	cat jt.1.ronn |ronn -r --pipe > jt.1

jt.1.html: jt.1.ronn
	cat jt.1.ronn |ronn -5 --pipe > jt.1.html

docs: jt.1 jt.1.html

GHDL=ghdl
NAME=decoder
GHDLFLAGS=--ieee=synopsys
MODULES=\
    $(NAME).o \
    $(NAME)_tb


test: $(MODULES)
	./$(NAME)_tb --wave=$(NAME)_tb.ghw

# Binary depends on the object file
%: %.o
	$(GHDL) -e $(GHDLFLAGS) $@

# Object file depends on source
%.o: %.vhdl
	$(GHDL) -a $(GHDLFLAGS) $<

clean:
	echo "Cleaning up..."
	rm -f *.o *_tb *.ghw $(NAME) adder work*.cf e*.lst 

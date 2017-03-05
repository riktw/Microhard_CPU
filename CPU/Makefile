GHDL=ghdl
NAME=cpu
GHDLFLAGS=--ieee=synopsys
MODULES=\
	mux16b \
	adder \
	adder16b \
	counter16b \
	alu16b \
	decoder \
	reg16	\
    $(NAME).o \
    $(NAME)_tb
DIRS=\
	..\Mux 


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
	rm -f *.o *_tb *.ghw $(NAME) mux16b adder adder16b alu16b counter16b decoder reg16 work*.cf e*.lst 

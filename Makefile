PYNAME  = mymodule
LIBNAME = mylib
LIBSONAME = lib$(LIBNAME).so

PYTHON ?= python2

CFLAGS += -Wall -O2 -Werror=missing-prototypes -fPIC

$(PYNAME).so: $(LIBSONAME)
$(PYNAME).so:
	LDFLAGS=-L. CFLAGS=-I. $(PYTHON) setup.py build_ext --inplace

$(LIBSONAME): $(LIBNAME).o
	$(CC) $^ -shared -o $@ $(LDLIBS)

test: $(PYNAME).so
	LD_LIBRARY_PATH=. $(PYTHON) -c 'from mymodule import Node; r = Node("root"); r.set_children(Node("c1"), Node("c2"), Node("c3"))'

clean:
	$(RM) $(LIBSONAME) $(PYNAME) $(PYNAME).c *.o

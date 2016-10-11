from libc.stdlib cimport calloc, free

cdef extern from "mylib.h":
    cdef struct node_ctx

    node_ctx *node_alloc(const char *name)
    void node_set_children(node_ctx *node, int nb_children,
                           node_ctx **children)
    void node_free(node_ctx *node)

cdef class Node:
    cdef node_ctx *ctx

    def __cinit__(self, name):
        self.ctx = <node_ctx*>node_alloc(name)
        if self.ctx is NULL:
            raise MemoryError()

    cdef _set_one_children(self, node_ctx **clist, int i, Node node):
        clist[i] = node.ctx

    def set_children(self, *children):
        children_c = <node_ctx **>calloc(len(children), sizeof(node_ctx *))
        if children_c is NULL:
            raise MemoryError()

        for i, item in enumerate(children):
            # FIXME: the following doesn't build:
            #children_c[i] = item.ctx

            self._set_one_children(children_c, i, item)

        node_set_children(self.ctx, len(children), children_c)
        free(children_c)

    def __dealloc__(self):
        node_free(self.ctx)

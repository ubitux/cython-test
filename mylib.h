#ifndef MYLIB_H
#define MYLIB_H

struct node_ctx;

struct node_ctx *node_alloc(const char *name);
void node_set_children(struct node_ctx *node, int nb_children,
                       struct node_ctx **children);
void node_free(struct node_ctx *node);

#endif

#include <stdlib.h>
#include <string.h>
#include <stdio.h>

#define _XOPEN_SOURCE 500 // strdup

#include "mylib.h"

struct node_ctx {
    char *name;
    struct node_ctx **children;
    int nb_children;
};

struct node_ctx *node_alloc(const char *name)
{
    struct node_ctx *s = calloc(1, sizeof(*s));
    if (!s)
        return NULL;
    s->name = strdup(name);
    if (!s->name) {
        free(s);
        return NULL;
    }
    return s;
}

void node_set_children(struct node_ctx *node, int nb_children,
                      struct node_ctx **children)
{
    int i;

    node->children = calloc(nb_children, sizeof(*node->children));
    node->nb_children = nb_children;
    for (i = 0; i < nb_children; i++) {
        printf("add %s to %s\n", children[i]->name, node->name);
        node->children[i] = children[i];
    }
}

void node_free(struct node_ctx *node)
{
    if (node) {
        printf("node free %s\n", node->name);
        free(node->name);
        free(node);
    }
}

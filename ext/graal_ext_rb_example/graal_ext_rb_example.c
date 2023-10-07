#include "graal_ext_rb_example.h"
#include "libgraal_ext_rb_example_java.h"

VALUE rb_mGraalExtRbExample;

// https://www.graalvm.org/latest/reference-manual/native-image/guides/build-native-shared-library/
static VALUE
wrap_add(VALUE self, VALUE a, VALUE b)
{
  graal_isolate_t *isolate = NULL;
  graal_isolatethread_t *thread = NULL;

  if (graal_create_isolate(NULL, &isolate, &thread) != 0) {
    fprintf(stderr, "initialization error\n");
    return 1;
  }

  VALUE result = INT2FIX(add(thread, FIX2INT(a), FIX2INT(b)));

  graal_tear_down_isolate(thread);

  return result;
}

void
Init_graal_ext_rb_example(void)
{
  rb_mGraalExtRbExample = rb_define_module("GraalExtRbExample");
  rb_define_singleton_method(rb_mGraalExtRbExample, "wrap_add", wrap_add, 2);
}

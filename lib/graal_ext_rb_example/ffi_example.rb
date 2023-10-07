# frozen_string_literal: true

require "ffi"
require "graaf"

module GraalExtRbExample
  module FFIExample
    extend Graaf::Library

    graaf_lib File.expand_path("../../ext/graal_ext_rb_example/graal/libgraal_ext_rb_example_java.so", __dir__)

    graaf_attach_function :add, %i[int int], :int
  end
end

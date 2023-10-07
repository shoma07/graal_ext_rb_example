# frozen_string_literal: true

require "ffi"

module GraalExtRbExample
  module FFIExample
    extend FFI::Library

    ffi_lib File.expand_path("../../ext/graal_ext_rb_example/graal/libgraal_ext_rb_example_java.so", __dir__)

    class GraalCreateIsolateParams < FFI::Struct
      layout(:version, :int)
    end
    private_constant :GraalCreateIsolateParams

    attach_function :graal_create_isolate, [GraalCreateIsolateParams.by_ref, :pointer, :pointer], :int
    attach_function :graal_tear_down_isolate, %i[pointer], :int
    private_class_method :graal_create_isolate, :graal_tear_down_isolate

    attach_function :add, %i[pointer int int], :int

    class << self
      def wrap_add(a, b)
        thread = FFI::MemoryPointer.new(:pointer)
        isolate = FFI::MemoryPointer.new(:pointer)
        graal_create_isolate(nil, isolate, thread)
        add(thread.read_pointer, a, b)
      ensure
        graal_tear_down_isolate(thread.read_pointer)
      end
    end
  end
end

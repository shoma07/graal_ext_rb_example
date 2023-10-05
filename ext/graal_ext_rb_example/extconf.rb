# frozen_string_literal: true

require 'mkmf'
require 'fileutils'

ext_path = __dir__
graal_path = "#{ext_path}/graal"

File.write("#{ext_path}/.gitignore", <<~GITIGNORE)
graal
GITIGNORE

system(<<~COMMAND)
  javac -d #{graal_path} #{ext_path}/*.java \
  && \
  native-image \
    -cp #{graal_path} \
    -march=native \
    --enable-sbom \
    --strict-image-heap \
    -o #{graal_path}/libgraal_ext_rb_example_java \
    --shared \
    -H:+UnlockExperimentalVMOptions \
  && \
  rm -r #{graal_path}/*.class
COMMAND

dir_config("graal_ext_rb_example_java", graal_path, graal_path)
have_library("graal_ext_rb_example_java")
have_header("#{graal_path}/libgraal_ext_rb_example_java.h")
create_makefile("graal_ext_rb_example/graal_ext_rb_example")

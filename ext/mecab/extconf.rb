require 'rbconfig'
RbConfig::MAKEFILE_CONFIG['CXX'] = ENV['CXX'] if ENV['CXX']
RbConfig::MAKEFILE_CONFIG['CC'] = ENV['CC'] if ENV['CC']

require 'mkmf'

find_executable('make')

mecab_config = with_config('mecab-config', 'mecab-config')
use_mecab_config = enable_config('mecab-config')

$LDFLAGS += ' -L' + `#{mecab_config} --libs-only-L`.chomp

unless `#{mecab_config} --version`.chomp =~ /^0\.996/
  puts "[ERROR] Mecab 0.996 requires libmecab version 0.996."
  exit 1
end

have_library('stdc++')
`#{mecab_config} --libs-only-l`.chomp.split.each { | lib |
  have_library(lib)
}

$CFLAGS += ' ' + `#{mecab_config} --cflags`.chomp + ' -x c++'

have_header('mecab.h') && create_makefile('mecab')

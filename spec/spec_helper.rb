require "rubygems"
require "spec"

require File.join(File.dirname(__FILE__), *%w[.. lib blend])

def t(name)
  File.join(File.dirname(__FILE__), '..', 'fixtures', 'templates', name)
end
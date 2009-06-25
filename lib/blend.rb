require "rubygems"
require "hpricot"

require File.join(File.dirname(__FILE__), 'collection')
require File.join(File.dirname(__FILE__), 'template')
require File.join(File.dirname(__FILE__), 'renderer')

module Blend
  class UnknownReference < StandardError
    def initialize(ref)
      @reference = ref
    end
    
    def to_s
      "Blend: the reference symbol :#{@reference} was used but this has not been defined"
    end
  end
end
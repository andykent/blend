module Blend
  class Template
    attr_reader :doc
    attr_accessor :references
    
    def initialize(doc, references={})
      @doc, @references = doc, references
    end
    
    def self.from_file(file, references={})
      new(File.read(file), references)
    end
    
    def render(data)
      selector_map = replace_references(data)
      Blend::Renderer.new(@doc, selector_map).output
    end
    
    private
    
    def replace_references(data)
      ret = data.dup
      return ret unless @references.any?
      ret.each do |k, v|
        ret[k] = v.map { |i| replace_references(i) } unless v.is_a?(String)
        next unless k.is_a?(Symbol)
        if @references.has_key?(k)
          val = ret.delete(k)
          ret[@references[k]] = val
        else
          raise Blend::UnknownReference.new(k)
        end
      end
      ret
    end
  end
end
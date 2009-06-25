module Blend
  class Renderer
    def initialize(doc, selector_map)
      @doc, @selector_map = Hpricot(doc), selector_map
    end
    
    def output
      run_replacements
      @doc.to_html
    end
    
    private
    
    def run_replacements
      
      @selector_map.each do |selector, data|
        (@doc / selector).html = case data.class.name
          when 'String' : data
          when 'Array'  : loop_replacement(selector, data)
          else
            data.to_s
        end
      end
    end
    
    def loop_replacement(selector, data_array)
      (@doc / selector).html = data_array.map { |data| Renderer.new((@doc / selector).html, data).output }.join
    end
  end
end
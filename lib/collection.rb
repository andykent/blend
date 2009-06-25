module Blend
  class Collection
    def initialize
      @templates = {}
    end
    
    def configure_template(file, refs)
      @templates[file] = Blend::Template.from_file(file, refs)
    end
    
    def render_template(file, vars)
      (@templates[file] || Blend::Template.from_file(file, {})).render(vars)
    end
  end
end
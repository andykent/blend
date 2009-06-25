require File.join(File.dirname(__FILE__), *%w[.. lib blend])

require "rubygems"
require "sinatra"

# this is an extension to add blend support to Sinatra, 
# Sinatra allows for the fairly modular addition of new rendering engines
# so I haven't monkey-patched anything, just added 3 new methods.
module Sinatra
  module Templates
    BLEND_REF_MAP = Hash.new({})
    
    def html(template, options={}, locals={})
      require_warn('Blend') unless defined?(::Blend)

      render :html, template, options, locals
    end

     def render_html(template, data, options, locals, &block)
       Blend::Template.new(data, BLEND_REF_MAP[template]).render(locals)
     end
  end
end

def configure_template(template, references)
  Sinatra::Templates::BLEND_REF_MAP[template] = references
end


# set the views directory so sinatra can find our templates
set :views, File.join(File.dirname(__FILE__), *%w[.. spec fixtures templates])

# this is the most basic example, it shows swapping out a css selector for some text content
# ruby server.rb then visit http://localhost:4567/basic
get '/basic' do
  html :basic, :locals => { 'head>title, h1' => 'Welcome to my page!' }
end

configure_template(:basic, 
  :title => 'head>title, h1', 
  :links => 'ul.links',
  :link_body => 'li',
  :note => 'p.note'
)

# this is more advanced example, it shows using the above references, looping and removing nil elements
# ruby server.rb then visit http://localhost:4567/advanced
get '/advanced' do
  html :basic, :locals => {
    :title => 'Welcome to my page!',
    :note => nil,
    :links => [
      { :link_body => '<a href="http://google.com">Google</a>' },
      { :link_body => '<a href="http://yahoo.com">Yahoo!</a>' }
    ]
  }
end
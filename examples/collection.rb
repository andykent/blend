require File.join(File.dirname(__FILE__), *%w[.. lib blend])

file = File.join(File.dirname(__FILE__), *%w[.. spec fixtures templates hello.html])

collection = Blend::Collection.new

collection.configure_template(file, :heading => 'h1')

puts collection.render_template(file, :heading => 'hello world')
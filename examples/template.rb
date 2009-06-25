require File.join(File.dirname(__FILE__), *%w[.. lib blend])

file = File.join(File.dirname(__FILE__), *%w[.. spec fixtures templates hello.html])

template = Blend::Template.from_file(file, :heading => 'h1')

puts template.render(:heading => 'hello world')
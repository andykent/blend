require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Blend::Renderer do
  it "renders output given an input and selector map" do
    Blend::Renderer.new("<h1>foo</h1>", 'h1' => 'bar').output.should == "<h1>bar</h1>"
  end
  
  it "handles arrays in the selector map as loops" do
    Blend::Renderer.new("<ul><li>foo</li></ul>", 'ul' =>[{'li' => 'bar'},{'li' => 'baz'}]).output.should == "<ul><li>bar</li><li>baz</li></ul>"
  end
end
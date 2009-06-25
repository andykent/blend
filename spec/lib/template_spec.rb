require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Blend::Template do
  describe "from_file" do
    it "intializes from a file" do
       Blend::Template.from_file(t('hello.html')).doc.should == '<h1>hello</h1>'
    end
  end
  
  describe "references" do
    it "takes references in the constructor" do
      Blend::Template.new('', {:ref => 'selector'}).references.should == {:ref => 'selector'}
    end
    
    it "allows modifying references" do
      template = Blend::Template.new('', {:ref => 'selector'})
      template.references[:new] = 'body'
      template.references.should == {:ref => 'selector', :new => 'body'}
    end
  end
  
  describe "replace_references" do
    it "swaps reference symbols for selectors" do
      Blend::Template.new('', {:ref => 'selector'}).send(:replace_references, {:ref => 'hello!'}).should == {'selector' => 'hello!'}
    end
    
    it "recursively swaps out nested reference symbols for selectors" do
      Blend::Template.new('', {:loop => 'ul', :ref => 'selector'}).send(:replace_references, {:loop => [{:ref => 'hello!'}]}).should == {'ul' => [{'selector' => 'hello!'}]}      
    end
    
    it "leaves string keys untouched as they are assumed to be selectors" do
      Blend::Template.new('', {:ref => 'selector'}).send(:replace_references, {'ref' => 'hello!'}).should == {'ref' => 'hello!'}
    end
    
    it "raises an UnknownReference error if you try to refer to an undefined refeence symbol" do
      lambda {
        Blend::Template.new('', {:ref => 'selector'}).send(:replace_references, {:eeek => 'hello!'}) 
      }.should raise_error(Blend::UnknownReference)
    end
  end
  
  describe "render" do
    it "passes replaced references to a new renderer object and renders a result string" do
      Blend::Template.from_file(t('hello.html'), :content => 'h1').render(:content => 'My Content').should == '<h1>My Content</h1>'
    end
  end
end
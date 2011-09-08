require 'spec_helper'

describe Grapiw::Session do
  it 'should return correct version string' do
    Grapiw.version.should == Grapiw::VERSION
  end

  it 'should return nil' do
    Grapiw.auth().should == nil
  end
  
  it 'should return nil' do
    Grapiw::Session.new().should == Grapiw::Session
  end
  
  
  
end
require 'spec_helper'

describe PuppetSyntax::Hiera do
  let(:subject) { PuppetSyntax::Hiera.new }

  it 'should expect an array of files' do
    expect { subject.check(nil) }.to raise_error(/Expected an array of files/)
  end

  it "should return nothing from valid YAML" do
    files = fixture_hiera('hiera_good.yaml')
    res = subject.check(files)
    res.should == []
  end

  it "should return an error from invalid YAML" do
    files = fixture_hiera('hiera_bad.yaml')
    res = subject.check(files)
    res.should_not == []
  end
end

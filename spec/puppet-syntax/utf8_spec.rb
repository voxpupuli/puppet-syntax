require 'spec_helper'

describe PuppetSyntax::NonASCII do
  let(:subject) { PuppetSyntax::NonASCII.new }

  it 'should expect an array of files' do
    expect { subject.check(nil) }.to raise_error(/Expected an array of files/)
  end

  it 'should return nothing from an ASCII manifest' do
    files = fixture_manifests('pass.pp')
    res = subject.check(files)

    res.should == []
  end

  it 'should return nothing from an ASCII template' do
    files = fixture_templates('pass.erb')
    res = subject.check(files)

    res.should == []
  end

  it 'should return an error from a non-ASCII manifest' do
    files = fixture_manifests('fail_utf8.pp')
    res = subject.check(files)

    res.should have(1).items
    res.first.should match(/:2: Non-ASCII characters:   notify { 'snowperson! .': }$/)
  end

  it 'should return an error from a non-ASCII template' do
    files = fixture_templates('fail_utf8.erb')
    res = subject.check(files)

    res.should have(1).items
    res.first.should match(/:2: Non-ASCII characters: snowperson! .$/)
  end
end

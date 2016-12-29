require 'spec_helper'

describe PuppetSyntax::Hiera do
  let(:subject) { PuppetSyntax::Hiera.new }

  it 'should expect an array of files' do
    expect { subject.check(nil) }.to raise_error(/Expected an array of files/)
  end

  it "should return nothing from valid YAML" do
    files = fixture_hiera('hiera_good.yaml')
    res = subject.check(files)
    expect(res).to be == []
  end

  it "should return an error from invalid YAML" do
    hiera_yaml = RUBY_VERSION =~ /1.8/ ? 'hiera_bad_18.yaml' : 'hiera_bad.yaml'
    files = fixture_hiera(hiera_yaml)
    expected = /ERROR: Failed to parse #{files[0]}:/
    res = subject.check(files)
    expect(res.size).to be == 1
    expect(res.first).to match(expected)
  end

  it "should return warnings for invalid keys" do
    hiera_yaml = 'hiera_badkey.yaml'
    examples = 5
    files = fixture_hiera(hiera_yaml)
    res = subject.check(files)
    (1..examples).each do |n|
      expect(res).to include(/::warning#{n}/)
    end
    expect(res.size).to be == examples
  end

  it "should check eyaml file" do
    PuppetSyntax.check_eyaml = true
    files = fixture_hiera('hiera_egood.eyaml')
    res = subject.check(files)
    expect(res.size).to be == 0
  end

  it "should report malformed eyaml blob" do
    # PuppetSyntax.check_eyaml is still true
    files = fixture_hiera('hiera_ebad.eyaml')
    examples = 7
    res = subject.check(files)
    (1..examples).each do |n|
      expect(res).to include(/::bad#{n}/)
    end
    expect(res.size).to be == examples
  end

end

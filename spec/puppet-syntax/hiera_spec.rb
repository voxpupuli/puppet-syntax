# frozen_string_literal: true

require 'spec_helper'

describe PuppetSyntax::Hiera do
  let(:subject) { described_class.new }

  it 'expects an array of files' do
    expect { subject.check(nil) }.to raise_error(/Expected an array of files/)
  end

  it 'returns nothing from valid YAML' do
    files = fixture_hiera('hiera_good.yaml')
    res = subject.check(files)
    expect(res).to eq []
  end

  it 'returns an error from invalid YAML' do
    files = fixture_hiera('hiera_bad.yaml')
    expected = /ERROR: Failed to parse #{files[0]}:/
    res = subject.check(files)
    expect(res.size).to eq 1
    expect(res.first).to match(expected)
  end

  it 'returns warnings on malformed keys' do
    files = fixture_hiera('hiera_key_no_value.yaml')
    expected = /ERROR: #{files[0]} doesn't contain a valid Hash, datatype is/
    res = subject.check(files)
    expect(res.size).to eq 1
    expect(res.first).to match(expected)
  end

  context 'check_hiera_keys = true' do
    before do
      PuppetSyntax.check_hiera_keys = true
      PuppetSyntax.check_hiera_data = true
    end

    it 'returns warnings for invalid keys' do
      hiera_yaml = 'hiera_badkey.yaml'
      examples = 9
      files = fixture_hiera(hiera_yaml)
      res = subject.check(files)
      (1..examples).each do |n|
        expect(res).to include(/warning#{n}:/)
      end
      expect(res.size).to eq examples
      expect(res[0]).to match('Key :typical:typo::warning1: Looks like a missing colon')
      expect(res[1]).to match('Key ::notsotypical::warning2: Puppet automatic lookup will not use leading \'::\'')
      expect(res[2]).to match('Key :noCamelCase::warning3: Not a valid Puppet variable name for automatic lookup')
      expect(res[3]).to match('Key :root::noCamelCase::warning4: Not a valid Puppet variable name for automatic lookup')
      expect(res[4]).to match('Key :Leading_caps_warning5: Not a valid Puppet variable name for automatic lookup')
      expect(res[5]).to match('Key :namespace::Leading_warning6: Not a valid Puppet variable name for automatic lookup')
      expect(res[6]).to match('Key :no-hyphens::warning7: Not a valid Puppet variable name for automatic lookup')
      expect(res[7]).to match('Key :picky::warning8: Puppet automatic lookup will not look up symbols')
      expect(res[8]).to match('Key :this_is::warning9: string after a function call but before `}` in the value')
    end

    it 'returns warnings for invalid values' do
      hiera_yaml = 'hiera_badvalue.yaml'
      examples = 3
      files = fixture_hiera(hiera_yaml)
      res = subject.check(files)
      (1..examples).each do |n|
        expect(res).to include(/warning#{n}:/)
      end
      expect(res.size).to eq examples
      expect(res[0]).to match('Key :this_is::warning1: string after a function call but before `}` in the value')
      expect(res[1]).to match('Key :this_is::warning2: string after a function call but before `}` in the value')
      expect(res[2]).to match('Key :this_is::warning3: string after a function call but before `}` in the value')
    end

    it 'returns warnings for bad eyaml values' do
      hiera_yaml = 'hiera_bad.eyaml'
      examples = 6
      files = fixture_hiera(hiera_yaml)
      res = subject.check(files)
      (1..examples).each do |n|
        expect(res).to include(/::warning#{n}/)
      end
      expect(res.size).to eq examples
      expect(res[0]).to match('Key acme::warning1 has unknown eyaml method unknown-method')
      expect(res[1]).to match('Key acme::warning2 has unterminated eyaml value')
      expect(res[2]).to match('Key acme::warning3 has unpadded or truncated base64 data')
      expect(res[3]).to match('Key acme::warning4 has corrupt base64 data')
      expect(res[4]).to match('Key acme::warning5\[\'key2\'\] has corrupt base64 data')
      expect(res[5]).to match('Key acme::warning6\[\'hash_key\'\]\[2\] has corrupt base64 data')
    end

    it 'handles empty files' do
      hiera_yaml = 'hiera_key_empty.yaml'
      files = fixture_hiera(hiera_yaml)
      res = subject.check(files)
      expect(res).to be_empty
    end
  end
end

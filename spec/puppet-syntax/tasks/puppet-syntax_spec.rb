require 'spec_helper'
require 'puppet-syntax/tasks/puppet-syntax'

known_pp = 'spec/fixtures/test_module/manifests/pass.pp'
known_erb = 'spec/fixtures/test_module/templates/pass.erb'
known_yaml = 'spec/fixtures/hiera/hiera_good.yaml'

describe 'PuppetSyntax rake tasks' do
  it 'should filter directories' do
    list = PuppetSyntax::RakeTask.new.filelist(['**/lib', known_pp])
    expect(list.count).to eq 1
    expect(list).to include(known_pp)
  end

  it 'should generate FileList of manifests relative to Rakefile' do
    list = PuppetSyntax::RakeTask.new.filelist_manifests
    expect(list).to include(known_pp)
    expect(list.count).to be >= 7
  end

  it 'should generate FileList of templates relative to Rakefile' do
    list = PuppetSyntax::RakeTask.new.filelist_templates
    expect(list).to include(known_erb)
    expect(list.count).to be >= 5
  end

  it 'should generate FileList of Hiera yaml files relative to Rakefile' do
    # Default path does not find any files in this project
    PuppetSyntax.hieradata_paths = ["spec/**/*.yaml"]
    list = PuppetSyntax::RakeTask.new.filelist_hiera_yaml
    expect(list).to include(known_yaml)
    expect(list.count).to be >= 3
  end

  it 'should check manifests relative to Rakefile' do
    if RSpec::Version::STRING < '3'
      pending
    else
      skip('needs to be done')
    end
  end

  it 'should check templates relative to Rakefile' do
    if RSpec::Version::STRING < '3'
      pending
    else
      skip('needs to be done')
    end
  end

end

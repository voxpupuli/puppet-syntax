require 'spec_helper'
require 'puppet-syntax/tasks/puppet-syntax'

known_pp = 'spec/fixtures/test_module/manifests/pass.pp'
known_erb = 'spec/fixtures/test_module/templates/pass.erb'
known_yaml = 'spec/fixtures/hiera/data/hiera_1.yaml'
known_eyaml = 'spec/fixtures/hiera/data/hiera_2.eyaml'
known_yaml_subdir = 'spec/fixtures/hiera/data/test/hiera_3.yaml'
known_eyaml_subdir = 'spec/fixtures/hiera/data/test/hiera_4.eyaml'

describe 'PuppetSyntax rake tasks' do
  describe 'with default excludes' do
    it 'filters directories' do
      list = PuppetSyntax::RakeTask.new.filelist(['**/lib', known_pp])
      expect(list.count).to eq 0
      expect(list).not_to include(known_pp)
    end
  end

  describe 'with custom excludes' do
    before do
      list = PuppetSyntax.exclude_paths
      PuppetSyntax.exclude_paths = list - ['spec/fixtures/**/*']
    end

    it 'filters directories' do
      list = PuppetSyntax::RakeTask.new.filelist(['**/lib', known_pp])
      expect(list.count).to eq 1
      expect(list).to include(known_pp)
    end

    it 'generates FileList of manifests relative to Rakefile' do
      list = PuppetSyntax::RakeTask.new.filelist_manifests
      expect(list).to include(known_pp)
      expect(list.count).to eq 9
    end

    it 'generates FileList of templates relative to Rakefile' do
      list = PuppetSyntax::RakeTask.new.filelist_templates
      expect(list).to include(known_erb)
      expect(list.count).to eq 9
    end

    it 'generates FileList of Hiera yaml files relative to Rakefile' do
      list = PuppetSyntax::RakeTask.new.filelist_hiera_yaml
      expect(list).to include(known_yaml)
      expect(list).to include(known_eyaml)
      expect(list).to include(known_yaml_subdir)
      expect(list).to include(known_eyaml_subdir)
      expect(list.count).to eq 4
    end
  end
end

# frozen_string_literal: true

require 'spec_helper'

describe PuppetSyntax do
  after do
    described_class.exclude_paths = []
  end

  it 'defaults exclude_paths to include the pkg directory' do
    expect(described_class.exclude_paths).to include('pkg/**/*')
  end

  it 'supports setting exclude_paths' do
    described_class.exclude_paths = ['foo', 'bar/baz']
    expect(described_class.exclude_paths).to eq(['foo', 'bar/baz'])
  end

  it 'supports appending exclude_paths' do
    described_class.exclude_paths << 'foo'
    expect(described_class.exclude_paths).to eq(['foo'])
  end

  it 'supports a fail_on_deprecation_notices setting' do
    described_class.fail_on_deprecation_notices = false
    expect(described_class.fail_on_deprecation_notices).to be(false)
  end

  it 'supports forcing EPP only templates' do
    described_class.epp_only = true
    expect(described_class.epp_only).to be(true)
  end

  it 'supports setting paths for manifests, templates and hiera' do
    described_class.hieradata_paths = []
    expect(described_class.hieradata_paths).to eq([])
    described_class.manifests_paths = ['**/environments/production/**/*.pp']
    expect(described_class.manifests_paths).to eq(['**/environments/production/**/*.pp'])
    described_class.templates_paths = []
    expect(described_class.templates_paths).to eq([])
  end
end

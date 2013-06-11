require 'spec_helper'

describe PuppetSyntax::Manifests do
  it 'should return nothing from a valid file' do
    pending
  end

  it 'should return an error from an invalid file' do
    pending
  end

  it 'should return a warning from an invalid file' do
    # "Unrecognised escape sequence \[\]"
    pending
  end

  it 'should ignore warnings about storeconfigs' do
    # @@notify { 'foo': }
    pending
  end

  it 'should read more than one valid file' do
    pending
  end

  it 'should continue after finding an error in the first file' do
    pending
  end
end

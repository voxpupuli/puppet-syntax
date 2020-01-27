require 'spec_helper'
require 'puppet'

describe PuppetSyntax::Manifests do
  let(:subject) { PuppetSyntax::Manifests.new }

  it 'should expect an array of files' do
    expect { subject.check(nil) }.to raise_error(/Expected an array of files/)
  end

  it 'should return nothing from a valid file' do
    files = fixture_manifests('pass.pp')
    output, has_errors = subject.check(files)

    expect(output).to eq([])
    expect(has_errors).to eq(false)
  end

  it 'should return nothing from a valid file with a class using tag parameter' do
    files = fixture_manifests('tag_notice.pp')
    output, has_errors = subject.check(files)

    expect(output).to eq([])
    expect(has_errors).to eq(false)
  end

  it 'should return an error from an invalid file' do
    files = fixture_manifests('fail_error.pp')
    output, has_errors = subject.check(files)

    if Puppet.version.to_i >= 4
      expect(output.size).to eq(3)
      expect(output[2]).to match(/2 errors. Giving up/)
      expect(has_errors).to eq(true)
    else
      expect(output.size).to eq(1)
      expect(output[0]).to match(/Syntax error at .*:3$/)
      expect(has_errors).to eq(true)
    end
  end

  it 'should return a warning from an invalid file' do
    files = fixture_manifests('fail_warning.pp')
    output, has_errors = subject.check(files)

    expect(output.size).to eq(2)
    expect(has_errors).to eq(true)

    expect(output[0]).to match(/Unrecogni(s|z)ed escape sequence '\\\['/)
    expect(output[1]).to match(/Unrecogni(s|z)ed escape sequence '\\\]'/)
  end

  it 'should ignore warnings about storeconfigs' do
    files = fixture_manifests('pass_storeconfigs.pp')
    output, has_errors = subject.check(files)

    expect(output).to eq([])
    expect(has_errors).to eq(false)

  end

  it 'should read more than one valid file' do
    files = fixture_manifests(['pass.pp', 'pass_storeconfigs.pp'])
    output, has_errors = subject.check(files)

    expect(output).to eq([])
    expect(has_errors).to eq(false)
  end

  it 'should continue after finding an error in the first file' do
    files = fixture_manifests(['fail_error.pp', 'fail_warning.pp'])
    output, has_errors = subject.check(files)

    expect(has_errors).to eq(true)
    if Puppet.version.to_i >= 4
      expect(output.size).to eq(5)
      expect(output[0]).to match(/This Name has no effect. A Host Class Definition can not end with a value-producing expression without other effect \(file: \S*\/fail_error.pp, line: 2, column: 32\)$/)
      expect(output[1]).to match(/This Name has no effect. A value was produced and then forgotten \(one or more preceding expressions may have the wrong form\) \(file: \S*\/fail_error.pp, line: 2, column: 3\)$/)
      expect(output[2]).to match('2 errors. Giving up')
      expect(output[3]).to match(/Unrecogni(s|z)ed escape sequence '\\\['/)
      expect(output[4]).to match(/Unrecogni(s|z)ed escape sequence '\\\]'/)
    else
      expect(output.size).to eq(3)
      expect(output[0]).to match(/Syntax error at '\}' .*:3$/)
      expect(output[1]).to match(/Unrecogni(s|z)ed escape sequence '\\\['/)
      expect(output[2]).to match(/Unrecogni(s|z)ed escape sequence '\\\]'/)
    end
  end

  describe 'deprecation notices' do
    case Puppet.version.to_f
    when 4.0..4.99
      context 'on puppet 4.0.0 and above' do
        it 'should instead be failures' do
          files = fixture_manifests('deprecation_notice.pp')
          output, has_errors = subject.check(files)

          expect(has_errors).to eq(true)
          expect(output.size).to eq(1)
          expect(output[0]).to match (/Node inheritance is not supported in Puppet >= 4.0.0/)
        end
      end
    when 3.7, 3.8
      context 'on puppet 3.7 and 3.8' do
        it 'should return deprecation notices as warnings' do
          files = fixture_manifests('deprecation_notice.pp')
          output, has_errors = subject.check(files)

          expect(has_errors).to eq(false)
          expect(output.size).to eq(2)
          expect(output[0]).to match(/The use of 'import' is deprecated/)
          expect(output[1]).to match(/Deprecation notice:/)
        end
      end
    when 3.5, 3.6
      context 'on puppet 3.5 and 3.6' do
        it 'should return deprecation notices as warnings' do
          files = fixture_manifests('deprecation_notice.pp')
          output, has_errors = subject.check(files)

          expect(has_errors).to eq(false)
          expect(output.size).to eq(1)
          expect(output[0]).to match(/The use of 'import' is deprecated/)
        end
      end
    when 3.0..3.4
      context 'on puppet 3.0 to 3.4' do
        it 'should not print deprecation notices' do
          files = fixture_manifests('deprecation_notice.pp')
          output, has_errors = subject.check(files)

          expect(output).to eq([])
          expect(has_errors).to eq(false)
        end
      end
    end
  end
end

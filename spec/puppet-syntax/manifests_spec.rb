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

    if Puppet::PUPPETVERSION.to_i >= 4
      expect(output.size).to eq(3)
      expect(output[2]).to match(/Found 2 errors. Giving up/)
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
    if Puppet::PUPPETVERSION.to_i >= 4
      expect(output.size).to eq(5)
      expect(output[0]).to match(/This Name has no effect. A Host Class Definition can not end with a value-producing expression without other effect at \S*\/fail_error.pp:2:32$/)
      expect(output[1]).to match(/This Name has no effect. A value(-producing expression without other effect may only be placed last in a block\/sequence| was produced and then forgotten.*) at \S*\/fail_error.pp:2:3$/)
      expect(output[2]).to match('Found 2 errors. Giving up')
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

  describe 'future_parser' do
    context 'future_parser = false (default)' do
      if Puppet::Util::Package.versioncmp(Puppet.version, '4.0') < 0
        it 'should fail without setting future option to true on future manifest on Puppet < 4.0.0' do
          expect(PuppetSyntax.future_parser).to eq(false)

          files = fixture_manifests(['future_syntax.pp'])
          output, has_errors = subject.check(files)

          expect(output.size).to eq(1)
          expect(output[0]).to match(/Syntax error at '='; expected '\}' .*:2$/)
          expect(has_errors).to eq(true)
        end
      else
        it 'should succeed on Puppet >= 4.0.0' do
          expect(PuppetSyntax.future_parser).to eq(false)

          files = fixture_manifests(['future_syntax.pp'])
          output, has_errors = subject.check(files)

          expect(output.size).to eq(0)
          expect(has_errors).to eq(false)
        end
      end
    end

    context 'future_parser = true' do
      before(:each) {
        PuppetSyntax.future_parser = true
      }

      if Puppet::Util::Package.versioncmp(Puppet.version, '3.2') >= 0 and Puppet::PUPPETVERSION.to_i < 4
        context 'Puppet >= 3.2 < 4' do
          it 'should pass with future option set to true on future manifest' do
            files = fixture_manifests(['future_syntax.pp'])
            output, has_errors = subject.check(files)

            expect(output).to eq([])
            expect(has_errors).to eq(false)
          end
        end
        context 'Puppet >= 3.7 < 4' do
          # Certain elements of the future parser weren't added until 3.7
          if Puppet::Util::Package.versioncmp(Puppet.version, '3.7') >= 0
            it 'should fail on what were deprecation notices in the non-future parser' do
              files = fixture_manifests('deprecation_notice.pp')
              output, has_errors = subject.check(files)

              expect(output.size).to eq(1)
              expect(output[0]).to match(/Node inheritance is not supported/)
              expect(has_errors).to eq(true)
            end
          end
        end
      elsif Puppet::Util::Package.versioncmp(Puppet.version, '3.2') < 0
        context 'Puppet < 3.2' do
          it 'should return an error that the parser option is not supported' do
            files = fixture_manifests(['future_syntax.pp'])
            output, has_errors = subject.check(files)

            expect(output.size).to eq(1)
            expect(output[0]).to match("Attempt to assign a value to unknown configuration parameter :parser")
            expect(has_errors).to eq(true)
          end
        end
      end
    end
  end

end

require 'spec_helper'

describe PuppetSyntax::Templates do
  let(:subject) { PuppetSyntax::Templates.new }

  it 'should expect an array of files' do
    expect { subject.check(nil) }.to raise_error(/Expected an array of files/)
  end

  it 'should return nothing from a valid file' do
    files = fixture_templates('pass.erb')
    res = subject.check(files)

    expect(res).to match([])
  end

  it 'should ignore NameErrors from unbound variables' do
    files = fixture_templates('pass_unbound_var.erb')
    res = subject.check(files)

    expect(res).to match([])
  end

  it 'should catch SyntaxError' do
    files = fixture_templates('fail_error.erb')
    res = subject.check(files)

    expect(res.size).to eq(1)
    expect(res[0]).to match(/2: syntax error, unexpected/)
  end

  it 'should catch Ruby warnings' do
    files = fixture_templates('fail_warning.erb')
    res = subject.check(files)

    expect(res.size).to eq(1)
    expect(res[0]).to match(/2: warning: found = in conditional/)
  end

  it 'should read more than one valid file' do
    files = fixture_templates(['pass.erb', 'pass_unbound_var.erb'])
    res = subject.check(files)

    expect(res).to match([])
  end

  it 'should continue after finding an error in the first file' do
    files = fixture_templates(['fail_error.erb', 'fail_warning.erb'])
    res = subject.check(files)

    expect(res.size).to eq(2)
    expect(res[0]).to match(/2: syntax error, unexpected/)
    expect(res[1]).to match(/2: warning: found = in conditional/)
  end

  it 'should ignore a TypeError' do
    files = fixture_templates('typeerror_shouldwin.erb')
    res = subject.check(files)

    expect(res).to match([])
  end

  if Puppet::PUPPETVERSION.to_f < 3.7
    context 'on Puppet < 3.7' do
      it 'should throw an exception when parsing EPP files' do
        file = fixture_templates('pass.epp')
        expect{ subject.check(file) }.to raise_error(/Cannot validate EPP without Puppet 4/)
      end

      context "when the 'epp_only' options is set" do
        before(:each) {
          PuppetSyntax.epp_only = true
        }

        it 'should throw an exception for any file' do
          file = fixture_templates('pass.erb')
          expect{ subject.check(file) }.to raise_error(/Cannot validate EPP without Puppet 4/)
        end
      end
    end
  end

  if Puppet::PUPPETVERSION.to_f >= 3.7
    context 'on Puppet >= 3.7' do
      it 'should return nothing from a valid file' do
        files = fixture_templates('pass.epp')
        res = subject.check(files)

        expect(res).to match([])
      end

      it 'should catch SyntaxError' do
        files = fixture_templates('fail_error.epp')
        res = subject.check(files)

        expect(res.size).to eq(1)
        expect(res[0]).to match(/This Type-Name has no effect/)
      end

      it 'should read more than one valid file' do
        files = fixture_templates(['pass.epp', 'pass_also.epp'])
        res = subject.check(files)

        expect(res).to match([])
      end

      it 'should continue after finding an error in the first file' do
        files = fixture_templates(['fail_error.epp', 'fail_error_also.epp'])
        res = subject.check(files)

        expect(res.size).to eq(2)
        expect(res[0]).to match(/This Type-Name has no effect/)
        expect(res[1]).to match(/Syntax error at '}' at \S*\/fail_error_also.epp:2:4/)
      end

      context "when the 'epp_only' options is set" do
        before(:each) {
          PuppetSyntax.epp_only = true
        }

        it 'should process an ERB as EPP and find an error' do
          files = fixture_templates('pass.erb')
          res = subject.check(files)

          expect(res.size).to eq(1)
        end
      end
    end
  end
end

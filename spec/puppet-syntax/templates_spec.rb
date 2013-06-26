require 'spec_helper'

describe PuppetSyntax::Templates do
  let(:subject) { PuppetSyntax::Templates.new }

  it 'should return nothing from a valid file' do
    files = fixture_templates('pass.erb')
    res = subject.check(files)

    res.should == []
  end

  it 'should ignore NameErrors from unbound variables' do
    files = fixture_templates('pass_unbound_var.erb')
    res = subject.check(files)

    res.should == []
  end

  it 'should catch SyntaxError' do
    files = fixture_templates('fail_error.erb')
    res = subject.check(files)

    res.should have(1).items
    res.first.should match(/2: syntax error, unexpected/)
  end

  it 'should catch Ruby warnings' do
    files = fixture_templates('fail_warning.erb')
    res = subject.check(files)

    res.should have(1).items
    res.first.should match(/2: warning: found = in conditional/)
  end

  it 'should read more than one valid file' do
    files = fixture_templates(['pass.erb', 'pass_unbound_var.erb'])
    res = subject.check(files)

    res.should == []
  end

  it 'should continue after finding an error in the first file' do
    files = fixture_templates(['fail_error.erb', 'fail_warning.erb'])
    res = subject.check(files)

    res.should have(2).items
    res[0].should match(/2: syntax error, unexpected/)
    res[1].should match(/2: warning: found = in conditional/)
  end
end

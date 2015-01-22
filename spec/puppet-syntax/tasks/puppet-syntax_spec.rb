require 'rake'
require 'spec_helper'

shared_context "rake" do
  let(:rake)      { Rake::Application.new }
  let(:task_name) { self.class.top_level_description }
  let(:task_path) { File.join(File.expand_path(File.dirname(__FILE__)), "/../../../lib/puppet-syntax/tasks/puppet-syntax.rb") }
  subject         { rake[task_name] }

  before(:each) do
    # See: http://apidock.com/ruby/Rake/Application/rake_require - only looks for files ending in .rake
    # Rake.application.rake_require(task_path)

    Rake.application = rake
    Rake.load_rakefile(task_path)
  end
end

shared_examples_for "a successful rake task" do
  it "does not raise an exception" do
    expect { subject.invoke }.not_to raise_exception
  end
end

shared_examples_for "a failing rake task" do
  it "raises a RuntimeError exception" do
    expect { subject.invoke }.to raise_exception(RuntimeError)
  end
end

describe "syntax:manifests" do
  include_context "rake"

  context "manifest without errors" do
    before(:each) do
      expect(FileList).to receive(:new).and_return(FileList[fixture_manifests('pass.pp').first])
    end

    it_behaves_like "a successful rake task"
  end

  context "manifest with errors" do
    before(:each) do
      expect(FileList).to receive(:new).and_return(FileList[fixture_manifests('fail_error.pp').first])
    end

    describe "always fails regardless that fail_on_warnings is set to true" do
      PuppetSyntax.fail_on_warnings = true
      it_behaves_like "a failing rake task"
    end

    describe "always fails regardless that fail_on_warnings is set to false" do
      PuppetSyntax.fail_on_warnings = false
      it_behaves_like "a failing rake task"
    end
  end

  context "manifest with deprecation notices" do
    before(:each) do
      expect(FileList).to receive(:new).and_return(FileList[fixture_manifests('deprecation_notice.pp').first])
    end

    describe "and fail_on_warnings is set to default" do
      it_behaves_like "a failing rake task"
    end

    describe "and fail_on_warnings is set to true" do
      PuppetSyntax.fail_on_warnings = true
      it_behaves_like "a failing rake task"
    end

    describe "and fail_on_warnings is set to false" do
      PuppetSyntax.fail_on_warnings = false
      it_behaves_like "a successful rake task"
    end
  end
end

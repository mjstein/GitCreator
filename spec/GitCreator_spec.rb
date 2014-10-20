require 'fileutils'
require_relative 'spec_helper'


describe GitRecordCreator, "Git Repository" do
    it "is created when git_repo does not exists" do
      allow(GitRecordCreator).to receive(:git_repository_exists?){false}
      expect {GitRecordCreator.new}.to output(/creating/).to_stdout
    end
    it "is not created when git_repo exists"
    after(:all) do
      FileUtils.rm_rf('./configuration') if Dir.exists?('./configuration')
    end

end

require 'fileutils'
require_relative 'spec_helper'

describe GitRecordCreator, "Git Repository" do

  let(:git_record){GitRecordCreator.new}
  before(:all) do
    FileUtils.rm_rf('./configuration/.git') if Dir.exists?('./configuration/.git')
  end

  it "is created when git_repo does not exist" do
    allow(git_record).to receive(:git_repository_exists?){false}
    expect {git_record.to output(/creating/).to_stdout}
    expect(git_record.instance_variable_get(:@g)).to_not eq(nil)
    expect(git_record.instance_variable_get(:@g).config["user.name"]).to eq("User")
    expect(git_record.instance_variable_get(:@g).config["user.email"]).to eq("user@user.com")
  end

  it "is not created when git_repo exists" do 
    allow(git_record).to receive(:git_repository_exists?){true}
    expect {git_record.to_not output(/creating/).to_stdout}
    expect(git_record.instance_variable_get(:@g)).to eq(nil)
  end


  after(:all) do
    FileUtils.rm_rf('./configuration/.git') if Dir.exists?('./configuration/.git')
  end

end

describe GitRecordCreator, "Git commit" do
  let(:git_record1){GitRecordCreator.new.commit_configuration_file}
  before(:all) do
    FileUtils.rm_rf('./configuration/.git') if Dir.exists?('./configuration/.git')
  end
  it "should commit without error" do
   expect(git_record1).to eq true 
  end
  it "should commit with a message showing file diffs"
  it "should commit with a message showing time and date"
  after(:all) do
    FileUtils.rm_rf('./configuration/.git') if Dir.exists?('./configuration/.git')
  end
end

# == Schema Information
#
# Table name: vidposts
#
#  id         :integer          not null, primary key
#  vid_id     :string(255)
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Vidpost do

  let(:user) { FactoryGirl.create(:user) }
  before do
    @vidpost = user.vidposts.build(vid_id: "qjBRNqwDPrU")
  end

  subject { @vidpost }

  it { should respond_to(:vid_id) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }

  it { should be_valid }

  describe "when user_id is not present" do
    before { @vidpost.user_id = nil }
    it { should_not be_valid }
  end

  describe "accessible attributes" do

    it "should not allow access to user_id" do
      expect do
        Vidpost.new(user_id: user.id)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
  end

  describe "when user_id is not present" do
    before { @vidpost.user_id = nil }
    it { should_not be_valid }
  end

  describe "with blank content" do
    before { @vidpost.vid_id = " " }
    it { should_not be_valid }
  end

  describe "with non-video content" do
    before { @vidpost.vid_id = 'youtube.com/no_vid-here'}
    it { should_not be_valid }
  end
end

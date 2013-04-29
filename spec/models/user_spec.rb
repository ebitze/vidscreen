# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  email           :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  password_digest :string(255)
#

require 'spec_helper'

describe User do
  
  before { @user = User.new(  name: "Example User", email: "user@example.com", 
                              password: "lovesexsecretgod", password_confirmation: "lovesexsecretgod") }

  subject { @user }

  it { should be_valid }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:authenticate) }

  describe "when name is not present" do
    before { @user.name = " " }
    it { should_not be_valid }
  end

  describe "when email is not present" do
    before { @user.email = " " }
    it { should_not be_valid }
  end

  describe "when name is too long" do
    before { @user.name = "a" * 21 }
    it { should_not be_valid }
  end

  describe "when password too short" do
    before { @user.password = @user.password_confirmation = "a" * 8 }
    it { should be_invalid }
  end

  describe "when email format invalid" do
    it "should be invalid" do
      addresses =   [ "plainaddress", 
                      "@%^%#$@#$@#.com",
                      "@example.com",
                      "Joe Smith <email@example.com>",
                      "email.example.com",
                      "email@example@example.com",
                      ".email@example.com",
                      "email.@example.com",
                      "email..email@example.com",
                      "email@example.com (Joe Smith)",
                      "email@example",
                      "email@-example.com",
                      "email@111.222.333.44444",
                      "email@example..com",
                      "Abc..123@example.com" ]
      addresses.each do |invalid_address|
        @user.email = invalid_address
        @user.should_not be_valid
      end
    end
  end 

  describe "when email format valid" do
    it "should be valid" do
      addresses = %w[ email@example.com
                      firstname.lastname@example.com
                      email@subdomain.example.com
                      firstname+lastname@example.com
                      email@123.123.123.123
                      email@[123.123.123.123]
                      1234567890@example.com
                      email@example-one.com
                      _______@example.com
                      email@example.name
                      email@example.museum
                      email@example.co.jp
                      firstname-lastname@example.com ]
      addresses.each do |valid_address|
        @user.email = valid_address
        @user.should be_valid
      end
    end
  end

  describe "when email already taken" do
    before do
      user_with_duplicate_email = @user.dup
      user_with_duplicate_email.email = @user.email.upcase
      user_with_duplicate_email.save
    end

    it { should_not be_valid }

    before do
      user_with_duplicate_email = @user.dup
      user_with_duplicate_email.email = @user.email.downcase
      user_with_duplicate_email.save
    end

    it { should_not be_valid }
  end

  describe "email address with mixed case" do
    let(:mixed_case_email) { "jIfeOeNd@ooenNVIEieNVE.cOm" }

    it "should be saved all lower-case" do
      @user.email = mixed_case_email
      @user.save
      @user.reload.email.should == mixed_case_email.downcase
    end
  end

  describe "when password is not present" do
    before { @user.password = @user.password_confirmation = " " }
    it { should_not be_valid }
  end

  describe "when password does not match confirmation" do
    before { @user.password_confirmation = "typo" }
    it { should_not be_valid }
  end

  describe "when password confirmation is nil" do
    before { @user.password_confirmation = nil }
    it { should_not be_valid }
  end

  describe "password too short" do
    before { @user.password = @user.password_confirmation = "a" }
    it { should_not be_valid }
  end

  describe "return value of authenticate method" do
    before { @user.save }
    let(:found_user) { User.find_by_email(@user.email) }

    describe "with valid password" do
      it { should == found_user.authenticate(@user.password) }
    end

    describe "with invalid password" do
      let(:user_for_invalid_password) { found_user.authenticate("invalid") }

      it { should_not == user_for_invalid_password }
      specify { user_for_invalid_password.should be_false }
    end
  end
end


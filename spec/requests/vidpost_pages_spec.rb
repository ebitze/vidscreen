require 'spec_helper'

describe "Vidpost pages" do

  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  describe "vidpost creation" do
    before { visit root_path }

    describe "with invalid information" do

      it "should not create a vidpost" do
        expect { click_button "Post" }.not_to change(Vidpost, :count)
      end

      describe "error messages" do
        before { click_button "Post" }
        it { should have_content('error') } 
      end
    end

    describe "with valid information" do

      before { fill_in 'vidpost_vid_id', with: "www.youtube.com/watch?v=LQaOB44Iy5E" }
      it "should create a vidpost" do
        expect { click_button "Post" }.to change(Vidpost, :count).by(1)
      end
    end
  end

  describe "vidpost destruction" do
    before { FactoryGirl.create(:vidpost, user: user) }

    describe "as correct user" do
      before { visit root_path }

      it "should delete a vidpost" do
        expect { click_link "delete" }.to change(Vidpost, :count).by(-1)
      end
    end
  end
end

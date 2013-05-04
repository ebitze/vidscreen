require 'spec_helper'

describe "StaticPages" do

  subject { page }

  shared_examples_for "all static pages" do
    it { should have_selector('h1', text: heading) }
    it { should have_selector('title', text: full_title(page_title)) }
  end

  describe "Home page" do 

    before { visit root_path }
    let(:heading)     { 'VIDSCREEN' }
    let(:page_title)  { '' }

    it_should_behave_like "all static pages"
    
    describe "Click sign up button" do
      before { click_link "signup" }
      it { should have_selector('title', text: 'Sign up') }
    end

    describe "for signed-in users" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        FactoryGirl.create(:vidpost, user: user, vid_id: "www.youtube.com/watch?v=LQaOB44Iy5E")
        FactoryGirl.create(:vidpost, user: user, vid_id: "www.youtube.com/watch?v=rwnnX2MNYGw")
        sign_in user
        visit root_path
      end

      it "should render the user's feed" do
        user.feed.each do |item|
          page.should have_selector("li##{item.id}", text: item.vid_id)
        end
      end

      describe "follower/following counts" do
        let(:other_user) { FactoryGirl.create(:user) }
        before do
          other_user.follow!(user)
          visit root_path
        end

        it { should have_link("0 following", href: following_user_path(user)) }
        it { should have_link("1 followers", href: followers_user_path(user)) }
      end 
    end
  end

  describe "Help page" do
    
    before { visit help_path }
    let(:heading)     { 'Help' }
    let(:page_title)  { 'Help' }

    it_should_behave_like "all static pages"
  end
  
  describe "Contact page" do
    
    before { visit contact_path}
    let(:heading)     { 'Contact' }
    let(:page_title)  { 'Contact' }

    it_should_behave_like "all static pages"

    it { should_not have_content 'eric.bitzegaio@gmail.com' }
  end
  
  describe "FAQ page" do
    
    before { visit faq_path }
    let(:heading)     { 'Frequently Asked Questions' }
    let(:page_title)  { 'FAQ' }

    it_should_behave_like "all static pages"
  end
end

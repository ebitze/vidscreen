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

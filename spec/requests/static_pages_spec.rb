require 'spec_helper'
  
    describe "StaticPages" do  
      let(:base_title){"Sample App Tutorials"}
  	 	subject{page}
      shared_examples_for "All Static Pages" do
        it{should have_selector('h1'),text: heading}
        it{should have_selector('title',text: full_title(page_title))}
      end
      describe "Home page" do
          before { visit root_path }
          let(:heading){'Sample App'}
          let(:page_title){''}
          it { should_not have_selector 'title', text: '| Home'}
      end
      describe "Help Page" do
          before {visit help_path}
          let(:heading){'Help'}
          it {should have_content('Help')}
          #it {should have_selector('title'), full_title('Help')}
      end
      describe "About Us" do
        before {visit about_path}
        it {should have_content('About Us')}
        let(:heading){'About Us'}   
        let(:page_title){'About'}     
      end
      describe "Contact Us" do
        before {visit contact_path}
        let(:heading){'Help'}
        let(:page_title){'Help'}
        it {should have_content('Help')}
        
      end
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
     # get static_pages_index_path
      #response.status.should be(200)
      it "should have the right links on the layout" do
        visit root_path
        click_link "About"
        page.should have_selector 'title', text: full_title('About')
        click_link "Help"
        page.should have_selector 'title', text: full_title('Help')
        click_link "Contact"
        page.should have_selector 'title', text: full_title('Contact')
        click_link "Home"
        click_link "Sign up now!"
        page.should have_selector 'title', text: full_title('Signup')
        click_link "sample app"
       page.should have_selector 'title', text: full_title('')
      end
end

require 'spec_helper'
  
    describe "StaticPages" do  
      let(:base_title){"Sample App Tutorials"}
  	 	subject{page}
      describe "Home page" do
          before { visit root_path }
          it { should have_selector('h1'), text: 'Sample App' }
          it { should have_selector 'title',text: 'Sample App' }
          it { should_not have_selector 'title', text: '| Home'}
      end
      describe "Help Page" do
          before {visit help_path}
          it {should have_content('Help')}
          it {should have_selector('title'), full_title('Help')}
      end
      describe "About Us" do
        before {visit about_path}
        it {should have_content('About Us')}
        it {should have_selector('title'),text:full_title('About')} 
      end
      describe "Contact Us" do
        before {visit contact_path}
        it {should have_content('Contact Us')}
        it {should have_selector('title'),text:full_title('Contact')}        
      end
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
     # get static_pages_index_path
      #response.status.should be(200)
end

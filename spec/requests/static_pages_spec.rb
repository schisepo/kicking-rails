require 'spec_helper'
describe "StaticPages" do  
      let(:base_title){"Sample App Tutorial "}
  	 	describe "Home Page" do
  	 		it "should have the content 'Sample App'" do
  	 			visit '/static_pages/home'
  	 			page.should have_content('Sample App')      
  	 		end
        it "should have the title 'Home'" do
          visit '/static_pages/home'
          page.should have_selector('title',
            :text =>"#{base_title}|Home")
        end
  	 	end
  	 	describe "Help Page" do
        it "should have the content 'Help'" do
          visit '/static_pages/help'
          page.should have_content('Help')
        end
        it "should have the title 'Help'" do
          visit '/static_pages/help'
          page.should have_selector('title',
          :text =>"#{base_title}|Help")
        end
      end
      describe "About Us" do
        it "should have the content 'About Us'" do
          visit '/static_pages/about'
          page.should have_content('About Us')
        end
        it "should have the title 'About'" do
          visit '/static_pages/about'
          page.should have_selector('title',
          :text =>"#{base_title}|About")
        end
      end
      describe "Contact Us" do
        it "should have the content 'Contact Us" do
          visit '/static_pages/contact'
            page.should have_content('Contact Us')
        end
        it "should have the title 'Contact'" do
          visit '/static_pages/contact'
          page.should have_selector('title',
            :text =>"#{base_title}|Contact")
        end
      end
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
     # get static_pages_index_path
      #response.status.should be(200)
end

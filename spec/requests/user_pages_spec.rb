require 'spec_helper'
describe "UserPages" do
  subject{page}
  describe "Sign Up Page" do
  	before{visit signup_path}
  	it {should have_selector 'title',title: full_title('Signup')}
  	it {should have_content('Sign Up')}
  end
end

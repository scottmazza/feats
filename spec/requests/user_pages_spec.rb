require 'spec_helper'

describe "User pages" do
  describe "User pages" do
    
    subject { page }
    
    describe "signup page" do
      before { visit signup_path }
      
      it { should have_selector('h3', text: 'New to feats of?')}
    end
  end
end

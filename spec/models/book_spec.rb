# == Schema Information
#
# Table name: books
#
#  id               :integer          not null, primary key
#  call_number      :string(255)
#  title            :string(255)
#  author           :string(255)
#  publication_year :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  user_id          :integer
#  borrowed_at      :datetime
#

require 'spec_helper'

describe Book do
  
  before(:each) do
    @user = Factory(:user)
    @attr = { :call_number => "AB100.2", :title => "Environmental Studies", :author => "James Thompson", :publication_year => 1990}
  end
  
  it "should create a new instance with valid attributes" do
    @user.books.create!(@attr)
  end
  
  describe "user associations" do
    
    before(:each) do
      @book = @user.books.create(@attr)
    end
    
    it "should have a user attribute" do
      @book.should respond_to(:user)
    end
    
    it "should have the right associated user" do
      @book.user_id.should be == @user.id
      @book.user.should == @user
    end
  end
  
  describe "validations" do
    
    it "should require non-blank title" do
      invalid_attr = @attr
      invalid_attr[:title] = "    "
      @user.books.build(invalid_attr).should_not be_valid
    end
    
    it "should reject long titles" do
      invalid_attr = @attr
      invalid_attr[:title] = "a" * 61
      @user.books.build(invalid_attr).should_not be_valid
    end
    
    it "should require non-blank author" do
      invalid_attr = @attr
      invalid_attr[:author] = "    "
      @user.books.build(invalid_attr).should_not be_valid
    end
    
    it "should reject long authors" do
      invalid_attr = @attr
      invalid_attr[:author] = "a" * 41
      @user.books.build(invalid_attr).should_not be_valid
    end
    
    it "should reject long call numbers" do
      invalid_attr = @attr
      invalid_attr[:call_number] = "a" * 41
      @user.books.build(invalid_attr).should_not be_valid
    end
    
    it "should require a 4 digit publication year" do
      invalid_attr = @attr
      invalid_attr[:publication_year] = 123
      @user.books.build(invalid_attr).should_not be_valid
      invalid_attr[:publication_year] = 12345
      @user.books.build(invalid_attr).should_not be_valid
    end
  end
end

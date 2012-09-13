require 'spec_helper'

describe BooksController do
  render_views
  
  describe "access control" do
    it "should deny access to 'create'" do
      post :create
      response.should redirect_to(signin_path)
    end
    
    it "should deny access to 'destroy'" do
      delete :destroy, :id => 1
      response.should redirect_to(signin_path)
    end
  end
  
  describe "POST 'create'" do
    before(:each) do
      @user = test_sign_in(Factory(:user))
    end
    
    describe "failure" do
      
      before(:each) do
        @attr = { :title => "", :author => "",
                  :call_number => "", :publication_year => 0,
                  :borrowed_at => Time.now}
      end

      it "should not create a book" do
        lambda do
          post :create, :book => @attr
        end.should_not change(Book, :count)
      end

      it "should have the right title" do
        post :create, :book => @attr
        response.should have_selector('title', :content => "Create book")
      end
      
      it "should render the 'new' page" do
        post :create, :book => @attr
        response.should render_template('new')
      end
    end
    
    describe "success" do
      
      before(:each) do
        @attr = { :title => "Book title", :author => "Book author", :publication_year => 2000}
      end
      
      it "should create a book" do
        lambda do
          post :create, :book => @attr
        end.should change(Book, :count).by(1)
      end
      
      it "should redirect to the book show page" do
        post :create, :book => @attr
        test_book = assigns(:book)
        test_book.should_not be_nil
        response.should redirect_to(book_path(test_book)) # assigns(:book) returns the @book defined in the given controller's action method  
      end
      
      it "should have a success message" do
        post :create, :book => @attr
        flash[:success].should =~ /added/i
      end
      
    end
  end
end
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

  describe "GET 'index'" do

    describe "for non-signed-in users" do

      it "should redirect to signin page" do
        get :index
        response.should redirect_to(signin_path)
      end
    end


    describe "for signed-in users" do

      before(:each) do
        @user = Factory(:user)
        test_sign_in(@user)
        @book = Factory(:book)

        40.times do
          Factory(:book)
        end
      end

      it "should be successful" do
        get :index
        response.should be_success
      end

      it "should have the correct title" do
        get :index
        response.should have_selector('title', :content => "All books")
      end

      it "should have an element for each book" do
        get :index
        Book.paginate(:page => 1) do |book|
          response.should have_selector('span', :content => book.title)
        end
      end

      it "should paginate books" do
        get :index
        #check for a div with class="pagination"
        response.should have_selector('div.pagination')
        response.should have_selector('span.disabled', :content => "Previous")
        response.should have_selector('a', :href => "/books?page=2",
                                           :content => "2")
        response.should have_selector('a', :href => "/books?page=2",
                                           :content => "Next")
      end

      it "should have delete links for admins" do
        @user.toggle!(:admin)
        book = Book.first
        get :index
        response.should have_selector('a', :href => book_path(book),
                                           :content => "delete")
      end
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

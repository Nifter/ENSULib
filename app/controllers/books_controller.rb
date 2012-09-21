class BooksController < ApplicationController
  before_filter :authenticate
  before_filter :admin_user_authenticate, :only => [:new, :create, :edit, :update, :destroy]

  def index
    @books = Book.paginate(:page => params[:page], :per_page => 30)
    @title = "All books"
  end

  def show
    @book = Book.find(params[:id])
    @title = @book.title
  end

  def new
    @book = Book.new
    @title = "Create book"
  end

  def create
    @book = Book.new(params[:book])
    if @book.save
      redirect_to book_path(@book),
      :flash => { :success => "New book has been added to the database." }
    else
      @title = "Create book"
      render 'new'
    end
  end

  def edit

  end

  def update

  end

  def destroy

  end

end

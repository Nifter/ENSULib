class BooksController < ApplicationController
  before_filter :authenticate

  def index
    @books = Book.paginate(:page => params[:page], :per_page => 30)
    @title = "All books"
  end

  def show
    @book = Book.find(params[:id])
    @title = "Show book"
  end

  def new
    @book = Book.new
    @title = "Create book"
  end

  def create
    #raise params[:book].inspect    # Raises an exception with the params shown
    @book = Book.new(params[:book])
    if @book.save
      redirect_to book_path(@book), :flash => { :success => "New book has been added to the database." }
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

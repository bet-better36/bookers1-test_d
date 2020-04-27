class BooksController < ApplicationController
#それぞれの状況で各アクションにおいてどの変数の形が良いのか
#＠有無、単数複数
  def index
  	@books = Book.all
    @book = Book.new #eachを回すためには空の変数が必要
  end

  def show
  	@book = Book.find(params[:id])
  end

  def new
  	@book = Book.new
  end

  def create
  	@book = Book.new(book_params)　#errorを返すには＠を付けた変数が必要
  	if @book.save
  	flash[:notice] = "Book was successfully created."
  	redirect_to book_path(@book)
    else

      @books = Book.all
      render action: :index
    end
  end

  def edit
  	@book =  Book.find(params[:id])
  end

  def update
  	@book = Book.find(params[:id])　#errorを返すには＠を付けた変数が必要
  	if @book.update(book_params)
  	flash[:notice] = "Book was successfully updated."
  	redirect_to book_path(@book.id)
    else
      render action: :edit
    end
  end

  def destroy
  	book = Book.find(params[:id])
  	book.destroy
  	flash[:notice] = "Book was successfully destroyed."
  	redirect_to books_path
  end

  private
    def book_params
      params.require(:book).permit(:title,:body)
    end
  end


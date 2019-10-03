BOOKS = [
  { title: "Hidden Figures", author: "Margot Lee Shetterly"},
  { title: "Practical Object-Oriented Design in Ruby", author: "Sandi Metz"},
  { title: "Kindred", author: "Octavia E. Butler"}
]

class BooksController < ApplicationController
  def index
    @books = Book.all
  end

  def show
    book_id = params[:id]
    puts "#{params}"

    @book = Book.find_by(id: book_id)
    if @book.nil?
      head :not_found
      return
    end
  end

  def new
    @book = Book.new#(title: "Hello!")
    # @book.save
    #puts "#{params}"
  end

  def create
    @book = Book.new(author: params[:book][:author], title: params[:book][:title], description: params[:book][:description]) #instantiate a new book
    if @book.save # save returns true if the database insert succeeds
      redirect_to books_path # go to the index so we can see the book in the list
      return
    else # save failed :(
      render :new # show the new book form view again
      return
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])

    @book.update(author: params[:book][:author], title: params[:book][:title], description: params[:book][:description])

    if @book.save # save returns true if the database insert succeeds
      redirect_to books_path # go to the index so we can see the book in the list
      return
    else # save failed :(
      render :edit # show the new book form view again
      return
    end
  end

  def destroy
    book_id = params[:id]
    @book = Book.find_by(id: book_id)

    if @book.nil?
      head :not_found
      return
    end

    @book.destroy

    redirect_to books_path
  end
  
end

class AuthorsController < ApplicationController
    def index
      @authors = Authors.all
    end
  
    def show
      author_id = params[:id]
      @author = Author.find_by(id: book_id)
      
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
end

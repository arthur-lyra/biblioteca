# app/controllers/books_controller.rb
class BooksController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show, :search]

  def index
    @q = params[:q].to_s.strip
    @category = params[:category]
    @author = params[:author]

    scope = policy_scope(Book)
    scope = scope.where("title ILIKE ? OR author ILIKE ?", "%#{@q}%", "%#{@q}%") if @q.present?
    scope = scope.where(category: @category) if @category.present?
    scope = scope.where(author: @author) if @author.present?

    @books = scope.order(:title).page(params[:page]).per(10)
  end

  def show
    @book = Book.find(params[:id])
    authorize @book
    @review = current_user ? @book.reviews.find_or_initialize_by(user: current_user) : Review.new
    @reviews = @book.reviews.order(created_at: :desc).page(params[:page]).per(5)
  end

  def new
    @book = Book.new
    authorize @book
  end

  def create
    @book = Book.new(book_params)
    authorize @book
    @book.available_quantity = @book.total_quantity
    if @book.save
      redirect_to @book, notice: "Livro criado."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @book = Book.find(params[:id])
    authorize @book
  end

  def update
    @book = Book.find(params[:id])
    authorize @book
    if @book.update(book_params)
      redirect_to @book, notice: "Livro atualizado."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @book = Book.find(params[:id])
    authorize @book
    @book.destroy
    redirect_to books_path, notice: "Livro removido."
  end

  # Autocomplete JSON
def search
  query = params[:q].to_s.strip
  if query.present?
    scope = policy_scope(Book)
    results = scope.where("title ILIKE ? OR author ILIKE ?", "%#{query}%", "%#{query}%")
                   .limit(10)
                   .pluck(:id, :title, :author, :available_quantity)
    render json: results.map { |id, title, author, available_quantity| { id: id, title: title, author: author, available_quantity: available_quantity } }
  else
    render json: [], status: :bad_request
  end
end

  def borrow
    @book = Book.find(params[:id])
    authorize @book # opcional: política própria para empréstimo
    Loan.transaction do
      if @book.available_quantity > 0
        @book.decrement!(:available_quantity)
        current_user.loans.create!(book: @book, borrowed_at: Time.current)
        redirect_to @book, notice: "Empréstimo realizado!"
      else
        redirect_to @book, alert: "Sem exemplares disponíveis."
      end
    end
  end

  def give_back
    @book = Book.find(params[:id])
    authorize @book
    loan = current_user.loans.where(book: @book, status: :active).order(created_at: :desc).first
    if loan
      loan.update!(status: :returned, returned_at: Time.current)
      @book.increment!(:available_quantity)
      redirect_to @book, notice: "Devolução registrada!"
    else
      redirect_to @book, alert: "Nenhum empréstimo ativo encontrado."
    end
  end

  private

  def book_params
    params.require(:book).permit(:title, :author, :category, :total_quantity, :available_quantity, :synopsis)
  end
end

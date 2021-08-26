class TransactionsController < ApplicationController
  before_action :check_isBuyer?, only: %i[ index new create show edit update destroy ]
  before_action :set_stock, only: %i[ show edit update destroy ]
  before_action :set_transaction, only: %i[ show edit update destroy ]

  # GET /transactions or /transactions.json
  def index
    @transactions = Transaction.all
  end

  # GET /transactions/1 or /transactions/1.json
  def show
  end

  # GET /transactions/new
  def new
    @transaction = Transaction.new
  end

  # GET /transactions/1/edit
  def edit
  end

  # POST /transactions or /transactions.json
  def create
    # @transaction = Transaction.new(transaction_params)
    # respond_to do |format|
    #   if @transaction.save
    #     format.html { redirect_to @transaction, notice: "Transaction was successfully created." }
    #     format.json { render :show, status: :created, location: @transaction }
    #   else
    #     format.html { render :new, status: :unprocessable_entity }
    #     format.json { render json: @transaction.errors, status: :unprocessable_entity }
    #   end
    # end

    @stock = Stock.find(params[:stock_id])

    @transaction = @stock.transactions.create(transaction_params)
    redirect_to transactions_path()
  end

  # PATCH/PUT /transactions/1 or /transactions/1.json
  def update
    respond_to do |format|
      if @transaction.update(transaction_params)
        format.html { redirect_to @transaction, notice: "Transaction was successfully updated." }
        format.json { render :show, status: :ok, location: @transaction }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /transactions/1 or /transactions/1.json
  def destroy
    @transaction.destroy
    respond_to do |format|
      format.html { redirect_to transactions_url, notice: "Transaction was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def check_isBuyer?
    if current_user.isadmin == false
      if current_user.role.name != "buyer"
        redirect_to root_path, notice: "404 Not found"
      end
    else
    end
  end

  private

  def set_stock
    @stock = Stock.find(params[:stock_id])
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_transaction
    @transaction = @stock.transactions.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def transaction_params
    params.require(:transaction).permit(:share, :price, :value, :stock_id, :user_id)
  end
end

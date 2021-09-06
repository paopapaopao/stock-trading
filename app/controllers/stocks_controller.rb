class StocksController < ApplicationController
  before_action :set_stock, only: %i[ show edit update destroy ]
  before_action :correct_user, only: [:edit, :update, :destroy]
  before_action :check_isAdminBroker?, only: %i[ new create ]
  before_action :check_isStatus?, only: %i[ index show new create ]

  # GET /stocks or /stocks.json
  def index
    @stocks = Stock.all
  end

  # GET /stocks/1 or /stocks/1.json
  def show
  end

  # GET /stocks/new
  def new
    # @stock = Stock.new
    @stock = current_user.stocks.build

    client = IEX::Api::Client.new(
      publishable_token: ENV['IEX_API_PUBLISHABLE_TOKEN'],
      endpoint: 'https://cloud.iexapis.com/v1'
      # endpoint: 'https://sandbox.iexapis.com/v1'
    )
    symbols = client.ref_data_symbols.sample(20).map { |s| s.symbol }

    @company_names = [['-- Select a Company --', '']]
    @company_names += symbols.map { |s| [client.key_stats(s).company_name, s] }
  end

  def get_data
    client = IEX::Api::Client.new(
      publishable_token: ENV['IEX_API_PUBLISHABLE_TOKEN'],
      endpoint: 'https://cloud.iexapis.com/v1'
      # endpoint: 'https://sandbox.iexapis.com/v1'
    )
    symbol = params[:symbol]

    latest_price = client.quote(symbol).latest_price
    market_cap = client.key_stats(symbol).market_cap
    render json: [latest_price, market_cap]
  end

  # GET /stocks/1/edit
  def edit
  end

  # POST /stocks or /stocks.json
  def create
    # @stock = Stock.new(stock_params)
    @stock = current_user.stocks.build(stock_params)

    respond_to do |format|
      if @stock.save
        format.html { redirect_to @stock, notice: "Stock was successfully created." }
        format.json { render :show, status: :created, location: @stock }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @stock.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /stocks/1 or /stocks/1.json
  def update
    respond_to do |format|
      if @stock.update(stock_params)
        format.html { redirect_to @stock, notice: "Stock was successfully updated." }
        format.json { render :show, status: :ok, location: @stock }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @stock.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stocks/1 or /stocks/1.json
  def destroy
    @stock.destroy
    respond_to do |format|
      format.html { redirect_to stocks_url, notice: "Stock was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def correct_user
    @stock = current_user.stocks.find_by(id: params[:id])
    redirect_to stocks_path, notice: "404 Not found" if @stock.nil?
  end

  def check_isAdminBroker?
    if current_user.isadmin == true || current_user.role.name == "broker"
    else
      redirect_to root_path, notice: "404 Not found"
    end
  end

  def check_isStatus?
    if current_user.status == "approved"
    else
      redirect_to pending_index_path()
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_stock
    @stock = Stock.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def stock_params
    params.require(:stock).permit(:company_name, :price, :market_cap, :user_id)
  end
end

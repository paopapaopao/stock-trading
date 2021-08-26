class Transaction < ApplicationRecord
  # validates :transaction_type,
  #   presence: true, inclusion: { in: %w(buy sell) }
  # validates :value,
  #   presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :value,
    presence: true

  belongs_to :user
  belongs_to :stock
  before_save :update_balance

  def update_balance
    @balance = Stock.find_by(id: stock_id)
    @balance.update(market_cap: @balance.market_cap - value)
  end
end

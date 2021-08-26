class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  # validates :role,
  #   presence: true, inclusion: { in: %w(buyer broker buyer_and_broker) }
  # validates :password,
  #   presence: true, length: { in: 8..50 }
  # validates :first_name,
  #   presence: true
  # validates :last_name,
  #   presence: true

  # optional true so that we can add in active record with role_id nil
  before_save :check_status

  def check_status
    if self.status?
    else
      if role.name == "broker"
        self.status = "pending"
      else
        self.status = "approved"
      end
    end
  end

  belongs_to :role, optional: true
  has_many :stocks
  has_many :transactions
end

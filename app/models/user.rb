class User < ApplicationRecord
  
  # before_save { self.email = email.downcase }
  validates :name, presence: true, length: { maximum: 50 } 

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
end

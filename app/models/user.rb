class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :tickets, dependent: :destroy
  # NB : on pourrait aussi mettre > dependent: :nullify > pour attribuer un user_id : nil et donc garder les tickets en historique
  has_many :favorites, dependent: :destroy
end

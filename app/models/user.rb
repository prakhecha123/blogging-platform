class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: [:regular, :admin]
  after_initialize :set_default_role, if: :new_record?

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy

  private

  def set_default_role
    self.role ||= :regular
  end
end
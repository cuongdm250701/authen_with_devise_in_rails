class User < ApplicationRecord

  attr_accessor :login

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # khi gọi warden.authenticate!(auth_options) method này được sử dụng
  # warden_condition sẽ chứa các thông tin được gửi từ form
  def self.find_for_database_authentication warden_condition
    binding.pry
    # sử dung dup để clone ra bản khác tránh làm ảnh hưởng đến phần tử gốc
    conditions = warden_condition.dup
    # nếu không dùng delete mà dùng dig thì sẽ gây lỗi ở câu điều kiện where
    login = conditions.delete(:login)
    # định nghĩa điều kiện bổ sung
    where(conditions).where(
      ["lower(username) = :value OR lower(email) = :value",
      {value: login.strip.downcase}]).first
  end
end

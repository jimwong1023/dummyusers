class User < ActiveRecord::Base
  # Remember to create a migration!
  validates :first_name, :presence => true
  validates :last_name, :presence => true
  validates :email, :format => { :with => /.{2,}\@.+\.(com|net|edu)/ }
  validates :email, :presence => true, :uniqueness => true
  validates :password, :presence => true, :length => 6..20

  def self.authenticate(user_hash)
    if (user = User.find_by_email(user_hash[:email]))
      user.password == user_hash[:password] ? user : nil
    end
  end
end

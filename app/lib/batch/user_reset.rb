class Batch::UserReset
  def self.user_reset
    users = User.where(is_deleted: true)
    users.each do |user|
      user.destroy
    end
  end
end

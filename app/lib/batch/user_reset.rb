class Batch::UserReset
  def self.user_reset
    p 1.month.ago
    User.where(deleted_at: 2.month.ago..1.month.ago).delete_all
  end
end

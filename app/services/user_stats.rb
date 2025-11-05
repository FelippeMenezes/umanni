class UserStats
  def initialize
    @total_users = User.count
    @admin_users = User.admin.count
    @regular_users = User.user.count
  end

  def total_users
    @total_users
  end

  def admin_users
    @admin_users
  end

  def regular_users
    @regular_users
  end

  def admin_percentage
    return 0 if @total_users.zero?
    ((@admin_users.to_f / @total_users) * 100).round(1)
  end

  def regular_users_percentage
    return 0 if @total_users.zero?
    ((@regular_users.to_f / @total_users) * 100).round(1)
  end

  def to_h
    {
      total_users: total_users,
      admin_users: admin_users,
      regular_users: regular_users,
      admin_percentage: admin_percentage,
      regular_users_percentage: regular_users_percentage
    }
  end
end
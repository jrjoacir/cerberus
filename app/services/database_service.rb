class DatabaseService
  def self.status
    ActiveRecord::Base.establish_connection
    ActiveRecord::Base.connection
    return :operational if ActiveRecord::Base.connected?

    :warning
  rescue StandardError
    :error
  end
end

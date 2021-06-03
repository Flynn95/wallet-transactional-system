class BaseService
  def execute
    raise NotImplementedError
  end

  def self.execute(params = {})
    new(params).execute
  end
end

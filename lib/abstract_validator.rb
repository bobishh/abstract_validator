class AbstractValidator
  VALIDATIONS = []
  attr_reader :model, :is_valid, :errors
  alias_method :valid?, :is_valid
  def initialize(model)
    @model = model
    validate!
    @is_valid = @errors.length == 0
  end
  private
  def validate!
    raise NotImplementedError.new "You must implement VALIDATIONS hash in your child class" if self.class::VALIDATIONS.size == 0
    @errors = []
    self.class::VALIDATIONS.each do |validation|
      values = get_values(validation[:keys])
      @errors << validation[:message] unless validation[:method].call(*values)
    end
  end
  def get_values(keys)
    keys.map do |k|
      @model.send(k)
    end
  end
end

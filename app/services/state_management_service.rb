class StateManagementService
  def initialize(object)
    @object = object
  end

  def update_state(new_state)
    if [true, false].include?(new_state)
      @object.update(active: new_state)
    else
      raise ArgumentError, 'Invalid state'
    end
    true
  end
end
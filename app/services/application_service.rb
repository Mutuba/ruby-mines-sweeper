class ApplicationService

  def self.call(**options)
    new(**options).call
  end
  
  private_class_method :new
end
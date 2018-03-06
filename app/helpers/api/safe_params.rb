module Api::SafeParams
  def safe_params
    ActionController::Parameters.new(params)
  end
end

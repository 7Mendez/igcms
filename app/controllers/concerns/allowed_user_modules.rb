# frozen_string_literal: true

module AllowedUserModules
  def current_module
    self.class.name.underscore.gsub(/_controller$/, '')
  end

  def user_allowed_to_access_module?
    Current.user.modules.include?(current_module)
  end

  def user_is_allowed_to_access_module?
    return false if Current&.user&.blank?

    redirect_to errors_not_found_path unless user_allowed_to_access_module?

    true
  end
end

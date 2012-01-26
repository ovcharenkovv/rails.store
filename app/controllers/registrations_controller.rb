# -*- encoding : utf-8 -*-
class RegistrationsController < Devise::RegistrationsController

  def create
    if verify_recaptcha
      super
    else
      build_resource
      clean_up_passwords(resource)
      flash.now[:alert] = "Recaptcha wrong "
      render_with_scope :new
    end
  end
end

# -*- encoding : utf-8 -*-
class Admin::AdminController < ApplicationController
  before_filter :authenticate_user!,:check_permissions
  layout "admin"

  def check_permissions
    if !current_user.is_admin?
      raise CanCan::AccessDenied
    end
  end

end


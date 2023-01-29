# frozen_string_literal: true

class Admin
  class AdminController < ApplicationController
    before_action :authenticate_user!
    before_action :admin?

    layout 'admin'

    protected

    def admin?
      redirect_to root_path, alert: 'У Вас нет прав доступа к данной странице' unless current_user.admin?
    end
  end
end

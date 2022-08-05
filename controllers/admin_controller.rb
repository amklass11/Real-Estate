# frozen_string_literal: true

class AdminController < ApplicationController
  before_action :can_access?

  def accounts
    @account = Account.where(admin: false)
  end

  def can_access?
    @show_sidebar = true
    unless current_account.admin?
      redirect_to root_url, flash: { danger: 'You do not have access to view this page' } && return
    end
  end
  
end

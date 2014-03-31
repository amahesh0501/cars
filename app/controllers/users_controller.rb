class UsersController < ApplicationController
  def show
    authenticate_user!
    @user = User.find(params[:id])
    @expenses = Expense.where(user_id: @user.id)
  end
end
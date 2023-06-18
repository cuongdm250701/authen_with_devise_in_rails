class UsersController < ApplicationController
    def index
        # binding.pry
        page = params[:page].to_i
        per_page = 5
        offset = (page- 1) * per_page
        @users = User.limit(per_page).offset(offset)
        @total_pages = (User.count.to_f / per_page).ceil
    end
end

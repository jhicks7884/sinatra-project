class UsersController < ApplicationController

    get '/signup' do
       if logged_in?
         redirect to '/deliveries'
        end
         erb :'/users/new'
      end

      post '/signup' do
        @user = User.new(params)
        if @user.valid?
          @user.save
          session["user_id"] = @user.id
          redirect to '/deliveries'
        else
         # flash[:message] = "Missing Signup Field, Please Try Again"
         # redirect to '/signup'
        end
      end

      get '/login' do
        if logged_in?
         redirect to '/users'
        end

        erb :'/users/login'
      end

      post '/login' do
        @user = User.find_by(username: params["username"])

        if @user && @user.authenticate(params[:password])
          session[:user_id] = @user.id
          redirect to '/users'
        else
          #flash[:login_error] = "Login Info Incorrect.  Please try again."
           erb :'/users/login'
        end
      end

      get '/users' do
        if logged_in?
          @user = current_user
          @deliveries = Delivery.new(content: params["contents"], address: params["address"], name: params["name"], user_id: @user.id)

         erb :'/users/users'

        end
      end

      get '/logout' do


        if logged_in?
          session.clear
          redirect to '/login'
        else
          redirect to '/'
        end
    end
end

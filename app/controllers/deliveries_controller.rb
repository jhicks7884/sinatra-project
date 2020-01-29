class DeliveriesController < ApplicationController

  get '/deliveries' do  # shows index
    if logged_in?
      @user = current_user
      erb :'/deliveries/index'
    else
      redirect to '/login'
    end
  end

  get '/deliveries/new' do  # makes new deliveries
    if !logged_in?
      @user = current_user

      erb :'/deliveries/new'
    else
      redirect to '/login'
    end
  end


  get '/deliveries/:id' do # shows show page

    if !logged_in?
      redirect to '/login'
    end
    @delivery = Delivery.find_by_id(params[:id])
    erb :'/deliveries/show'
  end

  get '/deliveries/' do  # shows index
    if !logged_in?
      @user =current_user
      erb :'/deliveries/index'
    else
      redirect to '/login'
    end
  end


  post '/deliveries/new' do   # shows new deliveries and validates
    if !logged_in?

      redirect to '/login'
    end

    @user = current_user
    @deliveries = Delivery.new(content: params["content"], address: params["address"], name: params["name"], user_id: @user.id)
    if @deliveries.valid?
      @deliveries.save

     redirect  '/deliveries'
    else
      flash[:message] = "No Content"
      redirect to '/deliveries/new'
    end
  end

  get '/deliveries/:id/edit' do   #edit's a delivery
    @delivery = Delivery.find_by(id: params[:id])

    if @delivery.user_id == current_user.id
      erb :'/deliveries/edit'
    else
      #flash[:message] = "You cant edit Deliveries sign in?"
      redirect to 'deliveries/new'
    end

  end

  patch '/deliveries/:id' do #saves updated delivery
    @deliveries = Delivery.find_by(id: params[:id])

    if @deliveries.user_id == current_user.id

     @deliveries.update(params[:delivery])
     @deliveries.save
     redirect to "/deliveries/#{@deliveries.id}"
    else
      erb :'/users/users'
    end
  end

  delete '/deliveries/:id/delete' do  #deletes a delivery
    @deliveries = Delivery.find_by(id: params[:id])
    if @deliveries.user_id == current_user.id
      @deliveries.delete
      erb :'/users/users'
    else
      redirect to 'deliveries/new'
    end
  end
end
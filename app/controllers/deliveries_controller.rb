class DeliveriesController < ApplicationController

  get '/deliveries' do  # shows index
    if !logged_in?
      redirect to '/login'
    else
     @user = current_user
      erb :'/deliveries/index'
    end
  end

  get '/deliveries/new' do  # makes new deliveries
    if !logged_in?
       redirect to '/login'
    else
      @user = current_user
      erb :'/deliveries/new'
    end
  end


  get '/deliveries/:id' do # shows show page
    if !logged_in?
      redirect to '/login'
    end
    @delivery = Delivery.find_by_id(params[:id])
    erb :'/deliveries/show'
  end


  post '/deliveries/new' do   # shows new deliveries and validates
    if !logged_in?

      redirect to '/login'
    end

    @user = current_user
    @delivery = Delivery.new(content: params["content"], address: params["address"], name: params["name"], user_id: @user.id)
    if @delivery.valid?
      @delivery.save

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
    @delivery = Delivery.find_by(id: params[:id])

    if @delivery.user_id == current_user.id

     @delivery.update(params[:delivery])
     @delivery.save
     redirect to "/deliveries/#{@delivery.id}"
    else
      redirect to '/deliveries'
    end
  end

  delete '/deliveries/:id/delete' do  #deletes a delivery
    @delivery = Delivery.find_by(id: params[:id])
    if @delivery.user_id == current_user.id
      @delivery.delete
      redirect '/users'
    else
      redirect to 'deliveries/new'
    end
  end
end
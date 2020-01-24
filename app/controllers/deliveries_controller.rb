class DeliveriesController < ApplicationController

  get '/deliveries' do
   # if Helpers.is_logged_in?(session)
    #  @user = Helpers.current_user(session)
      erb :'/deliveries/new'
    #else
     # redirect to '/login'
    #end
  end

  get '/deliveries/' do
    if Helpers.is_logged_in?(session)
      @user = Helpers.current_user(session)
      erb :'/deliveries/index'
    else
      redirect to '/login'
    end
  end

  post '/deliveries' do
    if !Helpers.is_logged_in?(session)
      redirect to '/login'
    end
    @user = Helpers.current_user(session)
    @deliveries = Deliveries.new(content: params["content"], address: params["address"], name: params["name"], user_id: @user.id)
    if @deliveries.valid?
      @deliveries.save
      redirect to '/deliveries/'
    else
      flash[:message] = "No Content"
      redirect to '/deliveries/new'
    end
  end

  get '/deliveries/:id' do
    if !Helpers.is_logged_in?(session)
      redirect to '/login'
    end
    @user = Helpers.current_user(session)
    @deliveries = Deliveries.new(content: params["content"], address: params["address"], name: params["name"], user_id: @user.id)
    @deliveries = Deliveries.find_by_id(params[:id])
    erb :'/deliveries/edit'
  end

  get '/deliveries/:id/edit' do
     @deliveries = Deliveries.find_by(params[:id])
    if logged_in? && current_user == @deliveries.user
    
     erb :'/deliveries/edit'
    else
      flash[:message] = "You cant edit Deliveries sign in?"
      redirect to 'deliveries/new'
    end

  end
  post '/deliveries/' do
    erb :'/deliveries/show'
  end

  patch 'deliveries/' do
    erb :deliveries/show
  end

  patch '/deliveries/:id' do
    @deliveries = deliveries.find_by_id(params[:id])
    if params["content", "name", "address"].empty?
      redirect to "/deliveries/#{@deliveries.id}/edit"
    end
  
    @deliveries.update(content: params["content"], name: params["name"], address: params["address"])
    @deliveries.save
    redirect to "/deliveries/#{@deliveries.id}"

  end

  delete '/deliveries/:id/delete' do
    @deliveries = Deliveries.find_by(params[:id])
    @deliveries.delete
    redirect to '/deliveries/'
  end
end
class DeliveriesController < ApplicationController

  get '/deliveries' do
    if Helpers.is_logged_in?(session)
      @user = Helpers.current_user(session)
      erb :'/deliveries/new'
    else
      redirect to '/login'
    end
  end

  get '/deliveries/' do
    if Helpers.is_logged_in?(session)
      @user = Helpers.current_user(session)
      erb :'/deliveries/show'
    else
      redirect to '/login'
    end
  end

  post '/deliveries' do
    if !Helpers.is_logged_in?(session)
      redirect to '/login'
    end
    @user = Helpers.current_user(session)
    @deliveries = Deliveries.new(content: params["contents"], address: params["address"], name: params["name"], user_id: @user.id)
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
    @deliveries = Deliveries.new(content: params["contents"], address: params["address"], name: params["name"], user_id: @user.id)
    @deliveries = Deliveries.find_by_id(params[:id])
    erb :'/deliveries/edit'
  end

  get '/deliveries/:id/edit' do
    @deliveries = Deliveries.find(params[:id])
    erb :'/deliveries/edit'
  end

  patch 'deliveries/' do
    erb :deliveries/show
  end

  patch '/deliveries/:id' do
    @deliveries = deliveries.find_by_id(params[:id])
    if params["contents", "name", "address"].empty?
      redirect to "/deliveries/#{@deliveries.id}/edit"
    end
  
    @deliveries.update(content: params["contents"], name: params["name"], address: params["address"])
    @deliveries.save
    redirect to "/deliveries/#{@deliveries.id}"

  end

  delete '/deliveries/:id/delete' do
    if Helpers.is_logged_in?(session)
      @deliveries = Deliveries.find(params[:id])
      if @deliveries == Helpers.current_user(session)
      @deliveries.destroy
      redirect to '/deliveries/'
      else
        redirect to '/deliveries'
      end
    else
      redirect to '/login'
    end
  end
end
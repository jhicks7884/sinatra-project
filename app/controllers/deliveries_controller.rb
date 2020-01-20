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
    @deliveries = deliveries.find(params[:id])
    erb :'/deliveries/edit'
  end

  get '/deliveries/:id/edit' do
    if !Helpers.is_logged_in?(session)
      redirect to '/login'
    end
    @deliveries = deliveries.find(params[:id])
    if @deliveries.user == Helpers.current_user(session)
        erb :'/deliveries/edit'
    else
      redirect to '/login'
    end
  end

  patch '/deliveries/:id' do
    @deliveries = deliveries.find(params[:id])
     if params[:contents].empty?
      redirect to "/deliveries/#{@deliveries.id}/edit"
    end

    @deliveries.update(contents: params["contents"])
    @deliveries.save
    redirect to "/deliveries/#{@deliveries.id}"

  end

  delete '/deliveries/:id/delete' do
    if Helpers.is_logged_in?(session)
      @deliveries = deliveries.find(params[:id])
      if @deliveries.user == Helpers.current_user(session)
        @deliveries = deliveries.find_by_id(params[:id])
        @deliveries.delete
        redirect to '/deliveries'
      else
        redirect to '/deliveries'
      end
    else
      redirect to '/login'
    end
  end

end

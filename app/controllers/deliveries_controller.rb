class DeliveriesController < ApplicationController

  get '/deliveries' do  # shows index
    if Helpers.is_logged_in?(session)
      @user = Helpers.current_user(session)
      erb :'/deliveries/index'
    else
      redirect to '/login'
    end
  end

  get '/deliveries/new' do  # makes new deliveries
    if Helpers.is_logged_in?(session)
      @user = Helpers.current_user(session)
      erb :'/deliveries/new'
    else
      redirect to '/login'
    end
  end


 get '/deliveries/:id' do # shows show page
  
    if !Helpers.is_logged_in?(session)
      redirect to '/login'
    end
    @delivery = Deliveries.find_by_id(params[:id])
    erb :'/deliveries/show'
  end

  get '/deliveries/' do  # shows index
    if Helpers.is_logged_in?(session)
      @user = Helpers.current_user(session)
      erb :'/deliveries/index'
    else
      redirect to '/login'
    end
  end


  post '/deliveries/new' do   # shows new deliveries and validates
    if !Helpers.is_logged_in?(session)
      redirect to '/login'
    end
    @user = Helpers.current_user(session)
    @deliveries = Deliveries.new(content: params["content"], address: params["address"], name: params["name"], user_id: @user.id)
    if @deliveries.valid?
      @deliveries.save
      erb :'/users/users'
    else
      flash[:message] = "No Content"
      redirect to '/deliveries/new'
    end
  end

 

  get '/deliveries/:id/edit' do   #edit's delivery
    
      @delivery = Deliveries.find_by(id: params[:id])
    
    if @delivery.user_id == current_user.id
      erb :'/deliveries/edit'
    else
      #flash[:message] = "You cant edit Deliveries sign in?"
      redirect to 'deliveries/new'
    end

  end

  patch '/deliveries/:id' do #saves updated delivery
    @deliveries = Deliveries.find_by(id: params[:id])
  

    if @deliveries.user_id == current_user.id
     # redirect to "/deliveries/#{deliveries.id}/edit"
   

     @deliveries.update(params[:delivery])
     @deliveries.save
     redirect to "/deliveries/#{@deliveries.id}"
    else
      erb :'/users/users'
    end

  end

  delete '/deliveries/:id/delete' do  #deletes a deliver
    @deliveries = Deliveries.find_by(params[:id])
    @deliveries.delete
    redirect to '/deliveries/'
  end
end
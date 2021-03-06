class UsersController < ApplicationController

  # GET: /users
  get "/users" do
    if logged_in?
      erb :"/users/index.html"
    else
      redirect "/users/new"
    end
  end

  # GET: /users/new
  get "/users/new" do
    if logged_in?
      redirect "/users/" + current_user.id.to_s
    else
      erb :"/users/new.html"
    end
  end

  # POST: /users
  post "/users" do
    if params[:username] != "" && params[:email] != "" && params[:password] != ""

      if User.find_by(username: params[:username]) != nil || User.find_by(email: params[:email]) != nil
        redirect "/login"
      end

      user = User.new(username: params[:username], email: params[:email], password: params[:password])

      if user.save
        session[:user_id] = user.id
        redirect "/users/" + user.id.to_s
      else
        redirect "/users/new"
      end
    else
      redirect "/users/new"
    end
  end

  # GET: /users/5
  get "/users/:id" do
    if logged_in?
      @user = User.find(params[:id])
      erb :"/users/show.html"
    else
      redirect "/login"
    end
  end

  # GET: /users/5/edit
  get "/users/:id/edit" do
    if logged_in?
      @user = User.find(params[:id])
      erb :"/users/edit.html"
    else
      redirect "/login"
    end
  end

  # PATCH: /users/5
  patch "/users/:id" do
    if session[:user_id] == User.find(params[:id])
      redirect '/users'
    end

    if params[:email] == "" || params[:username] == ""
      id = params[:id].to_s
      redirect '/users/'+id+'/edit'
    end

    if params[:username] != ""
      user = User.find(params[:id])
      user.username = params[:username]
      user.save
    end

    if params[:email] != ""
      user = User.find(params[:id])
      user.email = params[:email]
      user.save
    end

    id = params[:id].to_s
    redirect '/users/'+id
  end

  # DELETE: /users/5/delete
  delete "/users/:id/delete" do
    if logged_in?
      if session[:user_id] == params[:id].to_i
        User.find(params[:id]).destroy
        session[:user_id] = {}
        erb :welcome
      else
        id = params[:id].to_s
        redirect '/users/'+id
      end
    else
      id = params[:id].to_s
      redirect '/users/'+id
    end
  end
end

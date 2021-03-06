class RecipesController < ApplicationController

  # GET: /recipes
  get "/recipes" do
    if logged_in?
      erb :"/recipes/index.html"
    else
      redirect "/users/new"
    end
  end

  # GET: /recipes/new
  get "/recipes/new" do
    if logged_in?
      erb :"/recipes/new.html"
    else
      redirect "/users/new"
    end
  end

  # POST: /recipes
  post "/recipes" do
    # binding.pry
    if params[:recipe][:name] != "" && params[:recipe][:description] != "" && params[:recipe][:content] != ""
      if Recipe.find_by(name: params[:recipe][:name] != nil)
        redirect "/recipes/new"
      end

      recipe = Recipe.new(name: params[:recipe][:name], description: params[:recipe][:description], content: params[:recipe][:content])
      user = current_user

      user.recipes << recipe
      user.save
      recipe.save
      redirect "/users/" + user.id.to_s
    else
      redirect "/recipes/new"
    end
  end

  # GET: /recipes/5
  get "/recipes/:id" do
    if logged_in?
      @recipe = Recipe.find(params[:id])
      erb :"/recipes/show.html"
    else
      redirect "/login"
    end
  end

  # GET: /recipes/5/edit
  get "/recipes/:id/edit" do
    if logged_in?
      @recipe = Recipe.find(params[:id])
      erb :"/recipes/edit.html"
    else
      redirect "/login"
    end
  end

  # PATCH: /recipes/5
  patch "/recipes/:id" do
    if session[:user_id] != Recipe.find(params[:id]).user_id
      redirect '/users/'
    end

    if params[:name] == "" || params[:description] == "" || params[:content] == ""
      id = params[:id].to_s
      redirect '/recipes/'+id+'/edit'
    end

    if params[:name] != ""
      recipe = Recipe.find(params[:id])
      recipe.name = params[:name]
      recipe.save
    end

    if params[:description] != ""
      recipe = Recipe.find(params[:id])
      recipe.description = params[:description]
      recipe.save
    end

    if params[:content] != ""
      recipe = Recipe.find(params[:id])
      recipe.content = params[:content]
      recipe.save
    end

    id = Recipe.find(params[:id]).user_id.to_s
    redirect '/users/'+id
  end

  # DELETE: /recipes/5/delete
  delete "/recipes/:id/delete" do
    if logged_in?
      if session[:user_id] == current_user.id
        Recipe.find(params[:id]).destroy
          redirect "/recipes"
      else
        id = params[:id].to_s
        redirect '/recipes/'+id
      end
    else
      id = params[:id].to_s
      redirect '/recipes/'+id
    end
  end
end

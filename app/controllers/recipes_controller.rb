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
    if params[:name] != "" && params[:description] != "" && params[:content] != ""
      if Recipe.find_by(name: params[:name] != nil)
        redirect "/recipes/new"
      end

      recipe = Recipe.new(name: params[:name], description: params[:description], content: params[:content])
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
    erb :"/recipes/show.html"
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
    # binding.pry
    # if session[:user_id] == User.find(params[:id])
    #   redirect '/users'
    # end

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

    id = params[:id].to_s
    redirect '/users/'+id
  end

  # DELETE: /recipes/5/delete
  delete "/recipes/:id/delete" do
    redirect "/recipes"
  end
end

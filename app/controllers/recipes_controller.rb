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

      recipe = Recipe.new
# binding.pry
      recipe.name = params[:name]
      recipe.description = params[:description]
      recipe.content = params[:content]
      # recipe = Recipe.new(name: params[:name], description: params[:description], content: params[:content])
      # recipe = Recipe.create(name: params[:name], description: params[:description], content: params[:content])
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
    erb :"/recipes/edit.html"
  end

  # PATCH: /recipes/5
  patch "/recipes/:id" do
    redirect "/recipes/:id"
  end

  # DELETE: /recipes/5/delete
  delete "/recipes/:id/delete" do
    redirect "/recipes"
  end
end

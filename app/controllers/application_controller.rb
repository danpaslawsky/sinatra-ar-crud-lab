
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    redirect to "/articles"
  end

  # index
  get "/articles" do
    @articles = Article.all
    erb :index
  end

  # new   First, create a route in your controller: get '/articles/new', that renders the new.erb view. This view will be a blank form that should submit a POST request to /articles
  get "/articles/new" do
    @article = Article.new
    erb :new
  end

  # create  tell your controller what to do when your form sends that POST request, so create a route on your controller post '/articles' that creates a new article from the params from the form, then redirects to that new article's show page.
  post "/articles" do
    @article = Article.create(params)
    redirect to "/articles/#{ @article.id }"
  end

  # show    use Active Record to grab the article with the id that is in the params and set it equal to @article. Then, it should render the show.erb view page. That view should use ERB to render the @article's title and content.
  get "/articles/:id" do
    @article = Article.find(params[:id])
    erb :show
  end

  # edit   renders the view edit.erb. This view should contain a form to update a specific article--similar to the form you made for a new article, but the fields should be pre-populated with the existing title and content of the article.
  get "/articles/:id/edit" do
    @article = Article.find(params[:id])
    erb :edit
  end

  # update   WEIRD
  patch "/articles/:id" do
    @article = Article.find(params[:id])
    @article.update(params[:article])
    redirect to "/articles/#{ @article.id }"
  end

  #destroy
  delete "/articles/:id" do
    Article.destroy(params[:id])
    redirect to "/articles"
  end


end
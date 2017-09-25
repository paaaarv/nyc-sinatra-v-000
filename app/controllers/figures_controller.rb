require 'pry'
class FiguresController< ApplicationController

  get '/figures' do
    @figures = Figure.all
    erb :'/figures/index'
  end

  get '/figures/new' do
    @figure = Figure.new
    @titles = Title.all
    @landmarks = Landmark.all
    erb :'figures/new'
  end

  post '/figures' do
    @figure = Figure.create(name: params["figure"]["name"])
    if params["title"]["name"].empty?
      @figure.title_ids = params["figure"]["title_ids"]
      @figure.save
    else
      @title = Title.find_or_create_by(name: params["title"]["name"])
      @figure.titles << @title
      @figure.save
    end
    if !params["landmark"]["name"].empty?
      @landmark = Landmark.find_or_create_by(name: params["landmark"]["name"])
      @figure.landmarks << @landmark
      @figure.save
    else
      @figure.landmark_ids = params["figure"]["landmark_ids"]
      @figure.save
    end
    redirect("/figures/#{@figure.id}")
  end

  get '/figures/:id' do
    @figure = Figure.find(params[:id])

    erb :'/figures/show'
  end

  get "/figures/:id/edit" do
    @figure = Figure.find(params[:id])
    @titles = Title.all
    @landmarks = Landmark.all
    erb :'/figures/edit'
  end

  patch "/figures/:id" do
    binding.pry
    @figure = Figure.find(params[:id])
    if params["title"]["name"].empty?
      @figure.title_ids = params["figure"]["title_ids"]
      @figure.save
    else
      @title = Title.find_or_create_by(name: params["title"]["name"])
      @figure.titles << @title
      @figure.save
    end
    if !params["landmark"]["name"].empty?
      @landmark = Landmark.find_or_create_by(name: params["landmark"]["name"])
      @figure.landmarks << @landmark
      @figure.save
    else
      @figure.landmark_ids = params["figure"]["landmark_ids"]
      @figure.save
    end
    redirect("/figures/#{@figure.id}")
  end

end

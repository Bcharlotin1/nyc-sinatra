class FiguresController < ApplicationController
  # add controller methods

  
  get '/figures/new' do
 
    @figures = Figure.all
    @landmarks = Landmark.all
    @titles = Title.all
    erb :'/figures/new'
  end

  post '/figures' do
  
    @figure = Figure.create(params[:figure])
  
      
    if !params["title"]["name"].empty?
      title = Title.create(name: params[:title][:name])
      @figure.titles << title
      @figure.save
    end

    if !params["landmark"]["name"].empty?
      landmark = Landmark.create(name: params[:landmark][:name])
     
      @figure.landmarks << landmark
      @figure.save
    end
  end

  get "/figures" do
    @figures = Figure.all 
    erb :'figures/index'
  end

  get '/figures/:id/edit' do 
    @figure = Figure.find(params[:id])
    @landmarks = Landmark.all
    @titles = Title.all 
    erb :'/figures/edit'
  end

  patch '/figures/:id' do
# binding.pry
    @figure = Figure.find(params[:id])
    @figure.update(params[:figure])

    if !params["title"]["name"].empty?
      title = Title.create(name: params[:title][:name])
      @figure.titles << title
      # @figure.save
    end
    
    if !params["landmark"]["name"].empty?
      Landmark = Landmark.create(name: params[:landmark][:name])
      @figure.landmarks << Landmark
      # @figure.save
    end
    # binding.pry
    @figure.save
    redirect "/figures/#{@figure.id}"
  end

  get "/figures/:id" do
    @figure = Figure.find(params[:id])
    erb :'/figures/show'
  end
end


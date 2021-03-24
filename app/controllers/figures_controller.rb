class FiguresController < ApplicationController
  # add controller methods
  get "/figures" do
    @figures = Figure.all 
    erb :'figures/index'
  end

  get '/figures/new' do
 
    @figures = Figure.all
    @landmarks = Landmark.all
    @titles = Title.all
    erb :'/figures/new'
  end

  get "/figures/:id" do
    @figure = Figure.find(params[:id])
    erb :'/figures/show'
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


  get '/figures/:id/edit' do 
    @figure = Figure.find(params[:id])
    @landmarks = Landmark.all
    @titles = Title.all 
    erb :'/figures/edit'
  end

  patch '/figures/:id' do
    @figure = Figure.find(params[:id])
    @figure.update(params[:figure])

    if !params["title"]["name"].empty?
      title = Title.create(name: params[:title][:name])
      @figure.titles << title
    end
    # binding.pry
    if !params["landmark"]["name"].empty?
      landmark = Landmark.create(params[:landmark])
      @figure.landmarks << landmark
    end
    @figure.save
    redirect "/figures/#{@figure.id}"
  end


end


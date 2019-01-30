require 'pry'
class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index' 
  end

  get '/pets/new' do 
    @owners= Owner.all
    erb :'/pets/new'
  end

  post '/pets' do 
    @pet = Pet.create(:name =>params["pet_name"])
    
    if params["owner"] == nil
      @pet.owner = Owner.create(:name => params["owner_name"])
      @pet.save
    else
      @pet.owner = Owner.find_by(id: params["owners"].first)
      @pet.save  
    end
    redirect to "pets/#{@pet.id}"
  end
  
  get '/pets/:id/edit' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/edit'
  end
  

  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  patch '/pets/:id' do
    ####### bug fix
    binding.pry
    @pet = Pet.find(params[:id])
    if params[:owner_name]!= nil
    @owner = Owner.create(name: params["owner_name"])
    @pet.owner = @owner
    end
    #######
    
    @pet.name = params[:pet_name]
    @pet.owner = Owner.find(params[:owners].first)
    @pet.save
    redirect "pets/#{@pet.id}"
  end
  
end
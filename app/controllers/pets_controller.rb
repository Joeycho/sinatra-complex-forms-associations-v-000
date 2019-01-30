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
    if !params[:owners].keys.include?("owner_ids")
    params[:pet]["owner_ids"] = []
    end
    #######
 
    @pet = Pet.find(params[:id])
    @pet.update(params["pet"])
    if !params["pet_name"].empty?
      @pet.owners << Owner.create(name: params["owner_name"])
    end
    redirect "pets/#{@pet.id}"
  end
  
end
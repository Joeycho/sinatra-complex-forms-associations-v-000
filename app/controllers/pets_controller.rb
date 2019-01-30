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
    @pet = Pet.find(params[:id])
    if params[:owner][:name]!= nil
    @pet.name = params[:pet_name]
    @owner = Owner.create(name: params[:owner][:name])
    @pet.owner = @owner
    @pet.save
    #######
    else
    @pet.name = params[:pet_name]
    binding.pry
    @pet.owner = Owner.find(params[:owners].first)
    @pet.save
    end
    redirect "pets/#{@pet.id}"
  end
  
end
class ArtistsController < ApplicationController

    get '/artists' do
        @artists = Artist.all
        erb :"artists/index" 
    end

    get '/artists/:slug' do
        @artist = Artist.find_by_slug(params[:slug])
        erb :"artists/show"
    end

    get '/artists/:slug/edit' do
        @artist = Artist.find(params[:slug])
        erb :"artists/edit"
    end
    
end

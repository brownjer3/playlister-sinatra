class SongController < ApplicationController

    get '/songs' do
        @songs = Song.all
        erb :"songs/index"
    end

    get '/songs/new' do
        @artists = Artist.all
        @genres = Genre.all
        erb :"songs/new"
    end

    get '/songs/:slug' do 
        @song = Song.find_by_slug(params[:slug])
        erb :"/songs/show"
    end

    get '/songs/:slug/edit' do
        @song = Song.find_by_slug(params[:slug])
        @artists = Artist.all
        @genres = Genre.all
        erb :"songs/edit"
    end

    post '/songs' do
        @song = Song.create(params[:song])

        if !params[:genre][:name].empty?
            @song.genres << Genre.create(params[:genre])
        end

        if !params[:artist][:name].empty?
            if artist = Artist.find_by_name(params[:artist][:name])
                artist.songs << @song
            else
                Artist.create(params[:artist]).songs << @song
            end
        end

        redirect "/songs/#{@song.slug}"
    end

    patch '/songs/:slug' do
        @song = Song.find_by_slug(params[:slug])

        if !params[:genre][:name].empty?
            @song.genres << Genre.create(params[:genre])
        end

        if !params[:artist][:name].empty?
            if artist = Artist.find_by_name(params[:artist][:name])
                params[:song][:artist_id] = artist.id
                artist.songs << @song
            else
                artist = Artist.create(params[:artist])
                artist.songs << @song
                params[:song][:artist_id] = artist.id
            end
        end

        @song.update(params[:song])

        redirect "/songs/#{@song.slug}"
    end

end
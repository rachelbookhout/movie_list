require 'sinatra'
#require 'sinatra-reloader'
require 'pry'
require 'csv'

def read_csv(filename)
  data = []
  CSV.foreach(filename, headers:true) do |row|
    data << row.to_hash
  end
data
end

def list_movies(data)
 data.sort_by! do |movie|
  movie["title"]
  end
end

def id_finder(data, id)
data.select { |movie| id === movie["id"]}
end


before do
@data = read_csv('movies.csv')
end

get '/' do
  @sorted_movies = list_movies(@data)
  erb :index
end

get '/movies' do
search = params["movies"]
@sorted_movies = list_movies(@data)
  if search != nil
    @sorted_movies = list_movies(@data).select{|movie| search == movie["title"]}
    # binding.pry
    # "Found something!"
  end
  erb :index
end

get '/movies/:id' do
id = params[:id]
@sorted_data = id_finder(@data,id)
erb :show
end


require 'sinatra'
require 'data_mapper'
require File.dirname(__FILE__) + '/models.rb'
require 'json'
require 'Date'

# rendering json for everything (except /)
before do
    content_type 'application/json'
end

# send the frontend
get "/" do
    content_type 'html'
    erb :index
end

get "/items" do
    @items = Item.all
    @items.to_json
end
post "/items/new" do
    @item = Item.new
    @item.up_for_bid = false
    @item.description = params[:description]
    @item.awesomeness = 0;
    @item.created_at = DateTime.now
    @item.updated_at = null
end
put "/items/:id" do
    @item = Item.find(params[:id])
    @item.up_for_bid = params[:up_for_bid]
    @item.description = params[:description]
    @item.awesomeness += 1
    @item.updated_at = DateTime.now
    if @item.save
        {:item => @item, :status => "success"}.to_json
    else
        {:item => @item, :status => "failure"}.to_json
    end
end
delete "/items/:id" do
    @item = Item.find(params[:id])
    if @item.destroy
        {:item => @item, :status => "success"}.to_json
    else
        {:item => @item, :status => "failure"}.to_json
    end
end
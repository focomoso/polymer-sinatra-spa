DataMapper.setup(:default, 'postgres://localhost/polymer-sinatra-spa')

class Item
  include DataMapper::Resource

  property :id,           Serial
  property :up_for_bid,   Boolean
  property :description,  Text
  property :awesomeness,  Number
  property :created_at,   DateTime
  property :updated_at,   DateTime

end
DataMapper.auto_upgrade!
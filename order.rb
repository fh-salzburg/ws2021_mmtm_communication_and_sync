require "sinatra"
require_relative "base_code"

configure do
  set :orders, {}
end

get "/" do
  @orders = settings.orders.values
  slim :index
end

post "/order" do
  order = Order.new
  settings.orders[order.id] = order

  conn = Faraday.new('http://payment:4567') do |f|
    f.response :json
  end
  response = conn.post("pay?amount=#{params[:amount].to_i}")

  response.body["state"] == "success" ?  order.success! : order.failure!

  redirect "/"
end

require "sinatra"
require "erb"
require_relative "methods.rb"



enable :sessions



get "/" do
	session[:size] = []
	session[:crust] = []
	session[:sauce] = []
	session[:meats] = Array.new
	session[:toppings] = Array.new
	session[:address] = []
	session[:current_order] = Array.new
	session[:full_order] = []

	erb :welcome
end


post "/size_crust" do
	redirect "/size_crust"
end


get "/size_crust" do

	erb :size_crust
end


post "/sauce_meats" do
	session[:size].push(params[:size])
	session[:crust].push(params[:crust])
	redirect "/sauce_meats"
end


get "/sauce_meats" do
	erb :sauce_meats
end


post "/toppings" do
	session[:sauce].push(params[:sauce])
	session[:meats].push(params[:meats])
	redirect "/toppings"
end


get "/toppings" do
	erb :toppings
end


post "/delivery" do
	session[:toppings].push(params[:toppings])
	redirect "/delivery"
end


get "/delivery" do
	erb :delivery
end

post "/index" do
	session[:address].push(params[:f_name])
	session[:address].push(params[:l_name])
	session[:address].push(params[:address])
	session[:address].push(params[:city])
	session[:address].push(params[:state])

	session[:current_order].push(session[:size])
	session[:current_order].push(session[:crust])
	session[:current_order].push(session[:sauce])
	session[:current_order].push(session[:meats])
	session[:current_order].push(session[:toppings])

	redirect "/index"
end


get "/index" do
	# puts session[:current_order][0]
	session[:order_total] = current_order_total(session[:current_order])
	# puts "the order total is now #{session[:order_total]}"
	session[:current_order].push(session[:order_total])
	session[:full_order].push(session[:current_order])

	erb :index
end


post "/another" do
		session[:size] = []
		session[:crust] = []
		session[:sauce] = []
		session[:meats] = Array.new
		session[:toppings] = Array.new
		session[:current_order] = Array.new

		redirect "/size_crust"
end

post "/finalize" do
	session[:final_total] = overall_total(session[:full_order])

	redirect "/finalize"
end

get "/finalize" do
	erb :final
end

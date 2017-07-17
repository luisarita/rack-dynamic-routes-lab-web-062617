class Application

  @@items = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      search_term = req.path.split("/").last
      item = @@items.find do |item|
        item.name == search_term
      end
      if item.nil?
        resp.write "Item not found"
        resp.status = 400
      else
        resp.write item.price
      end
    else
      resp.write "Route not found"
      resp.status = 404
    end

    resp.finish
  end
end


def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      @@items.each do |item|
        resp.write "#{item}\n"
      end
    elsif req.path.match(/search/)
      search_term = req.params["q"]
      resp.write handle_search(search_term)
    elsif req.path.match(/cart/)
      resp.write "Your cart is empty" unless @@cart.count > 0
      @@cart.each do |item|
        resp.write "#{item}\n"
      end
    elsif req.path.match(/add/)
      search_term = req.params["item"]
      resp.write add_item(search_term)
    else
      resp.write "Path Not Found"
    end

    resp.finish
  end
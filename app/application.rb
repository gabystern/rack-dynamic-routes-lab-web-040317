class Application

  @@items = []

  def item_names
    @@items.collect do |item|
      item.name
    end
  end

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match("/items/")
    item_name = req.path.split("/items/").last
      if item_names.include?(item_name)
        item = @@items.find{|item| item.name == item_name}
        resp.write item.price
      else
        resp.write "Item not found"
        resp.status = 400
      end
    else
      resp.write "Route not found"
      resp.status = 404
    end

    resp.finish
  end


end

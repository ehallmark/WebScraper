json.array!(@products) do |product|
  json.extract! product, :id, :upc, :title, :original_price, :description
  json.url product_url(product, format: :json)
end

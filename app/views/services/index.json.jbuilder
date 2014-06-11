json.array!(@services) do |service|
  json.extract! service, :id, :name, :parent_id, :lft, :rgt, :depth
  json.url service_url(service, format: :json)
end

json.array!(@comentariu_licentas) do |comentariu_licenta|
  json.extract! comentariu_licenta, :user_id, :licenta_id, :continut
  json.url comentariu_licenta_url(comentariu_licenta, format: :json)
end
json.array!(@licentas) do |licenta|
  json.extract! licenta, :user_id, :tema_id
  json.url licenta_url(licenta, format: :json)
end
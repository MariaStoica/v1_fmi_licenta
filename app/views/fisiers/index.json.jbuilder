json.array!(@fisiers) do |fisier|
  json.extract! fisier, :name, :path, :adaugat, :user_id, :capitol_id
  json.url fisier_url(fisier, format: :json)
end
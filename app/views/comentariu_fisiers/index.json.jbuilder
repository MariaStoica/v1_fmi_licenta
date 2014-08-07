json.array!(@comentariu_fisiers) do |comentariu_fisier|
  json.extract! comentariu_fisier, :user_id, :fisier_id, :continut
  json.url comentariu_fisier_url(comentariu_fisier, format: :json)
end
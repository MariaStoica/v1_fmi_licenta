json.array!(@comentariu_temas) do |comentariu_tema|
  json.extract! comentariu_tema, :user_id, :tema_id, :continut
  json.url comentariu_tema_url(comentariu_tema, format: :json)
end
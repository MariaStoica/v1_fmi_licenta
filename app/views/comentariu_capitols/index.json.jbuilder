json.array!(@comentariu_capitols) do |comentariu_capitol|
  json.extract! comentariu_capitol, :user_id, :capitol_id, :continut
  json.url comentariu_capitol_url(comentariu_capitol, format: :json)
end
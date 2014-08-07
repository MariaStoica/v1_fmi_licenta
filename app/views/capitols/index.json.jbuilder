json.array!(@capitols) do |capitol|
  json.extract! capitol, :licenta_id, :nume, :numar
  json.url capitol_url(capitol, format: :json)
end
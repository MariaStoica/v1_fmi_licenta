json.array!(@todos) do |todo|
  json.extract! todo, :capitol_id, :continut, :este_gata
  json.url todo_url(todo, format: :json)
end
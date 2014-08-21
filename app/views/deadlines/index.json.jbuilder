json.array!(@deadlines) do |deadline|
  json.extract! deadline, :nume, :numar, :descriere, :data_start, :data_end
  json.url deadline_url(deadline, format: :json)
end
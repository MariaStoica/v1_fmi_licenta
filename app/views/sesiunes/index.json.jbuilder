json.array!(@sesiunes) do |sesiune|
  json.extract! sesiune, :data_start, :data_end
  json.url sesiune_url(sesiune, format: :json)
end
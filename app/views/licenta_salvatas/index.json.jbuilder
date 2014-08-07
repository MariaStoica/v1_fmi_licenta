json.array!(@licenta_salvatas) do |licenta_salvata|
  json.extract! licenta_salvata, :user_id, :tema_id, :sesiune_id
  json.url licenta_salvata_url(licenta_salvata, format: :json)
end
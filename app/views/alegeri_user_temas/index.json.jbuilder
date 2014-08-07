json.array!(@alegeri_user_temas) do |alegeri_user_tema|
  json.extract! alegeri_user_tema, :user_id, :tema_id, :status_profesor, :status_student, :sesiune_id
  json.url alegeri_user_tema_url(alegeri_user_tema, format: :json)
end
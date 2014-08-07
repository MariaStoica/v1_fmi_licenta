json.array!(@users) do |user|
  json.extract! user, :email, :nume, :prenume, :rol, :grupa, :grad, :este_eligibil_licenta, :token
  json.url user_url(user, format: :json)
end
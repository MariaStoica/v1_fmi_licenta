# Change this omniauth configuration to point to your registered provider
# Since this is a registered application, add the app id and secret here
APP_ID = 'ff28437f-56df-4b07-8075-6e76380532fe'
APP_SECRET = '33bc26e2b3ac2d74dba69e005bc9744d77da54cb3197ae6511'

CUSTOM_PROVIDER_URL = 'http://fmi-api.herokuapp.com'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :autentificare, APP_ID, APP_SECRET
end
require 'itout'

client_id = "80c5a655ad20e8819dc0cf580e5828cb5474cd5692c8b39acd5ea8410756cdde"
client_secret = "5ca12cb9a77f1d1c5ad0e8c6369d910a12862b2a8a138eaa152fcac931c8842c"

callback_url = "http://localhost:3000/"

# client init and auth
client = ITout.client(client_id, client_secret, callback_url, email:"tout@tout-dev.me", password:"139townsend")

#p client.user_auth()
p client.client_auth()

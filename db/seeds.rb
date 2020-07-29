# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

clients = { google: Client.create!(name: 'Google'), facebook: Client.create!(name: 'Facebook'), amazon: Client.create!(name: 'Amazon') }

products = { jmail: Product.create!(name: 'JMail', description: 'Jota Eletronic Mail'), jvideos: Product.create!(name: 'JVideos', description: 'Jota Videos'), jphotos: Product.create!(name: 'JPhotos', description: 'Jota Photos') }

users = { joacir: User.create!(login: 'joacir@email.com', name: 'Joacir'), junior: User.create!(login: 'junior@email.com', name: 'Junior'), joacirjunior: User.create!(login: 'joacir.junior@email.com.br', name: 'Joacir Junior'), oliveira: User.create!(login: 'oliveira@email.com.br', name: 'Oliveira'), santos: User.create!(login: 'santos@email.co.jp', name: 'Santos') }

google_products = { jmail: ClientsProduct.create!(product_id: products[:jmail].id, client_id: clients[:google].id), jvideos: ClientsProduct.create!(product_id: products[:jvideos].id, client_id: clients[:google].id) }
facebook_products = { jphotos: ClientsProduct.create!(product_id: products[:jphotos].id, client_id: clients[:facebook].id) }

jvideos_features = { post: Feature.create!(product_id: products[:jvideos].id, name: 'Post Videos'), watch: Feature.create!(product_id: products[:jvideos].id, name: 'Watch Videos') }
jmail_features = { send: Feature.create!(product_id: products[:jmail].id, name: 'Send Email'), remove: Feature.create!(product_id: products[:jmail].id, name: 'Remove Email') }
jphotos_features = { post: Feature.create!(product_id: products[:jphotos].id, name: 'Post Photo'), like: Feature.create!(product_id: products[:jphotos].id, name: 'Like Post') }

jmail_roles = { admin: Role.create!(name: 'admin', clients_products_id: google_products[:jmail].id), normal: Role.create!(name: 'normal', clients_products_id: google_products[:jmail].id)}
jvideos_roles = { admin: Role.create!(name: 'master', clients_products_id: google_products[:jvideos].id), normal: Role.create!(name: 'normal', clients_products_id: google_products[:jvideos].id)}
jphotos_roles = { liker: Role.create!(name: 'liker', clients_products_id: facebook_products[:jphotos].id), poster: Role.create!(name: 'poster', clients_products_id: facebook_products[:jphotos].id) }

# jvideos_features_roles
FeaturesRole.create!(features_id: jvideos_features[:post].id, roles_id: jvideos_roles[:admin].id)
FeaturesRole.create!(features_id: jvideos_features[:post].id, roles_id: jvideos_roles[:normal].id)
FeaturesRole.create!(features_id: jvideos_features[:watch].id, roles_id: jvideos_roles[:admin].id)
FeaturesRole.create!(features_id: jvideos_features[:watch].id, roles_id: jvideos_roles[:normal].id)

# jmail_features_roles
FeaturesRole.create!(features_id: jmail_features[:send].id, roles_id: jmail_roles[:admin].id)
FeaturesRole.create!(features_id: jmail_features[:send].id, roles_id: jmail_roles[:normal].id)
FeaturesRole.create!(features_id: jmail_features[:remove].id, roles_id: jmail_roles[:admin].id)

# jphotos_features_roles
FeaturesRole.create!(features_id: jphotos_features[:post].id, roles_id: jphotos_roles[:poster].id)
FeaturesRole.create!(features_id: jphotos_features[:like].id, roles_id: jphotos_roles[:liker].id)

# jmail_users_roles
UsersRole.create!(users_id: users[:joacir].id, roles_id: jmail_roles[:admin].id)
UsersRole.create!(users_id: users[:joacir].id, roles_id: jmail_roles[:normal].id)
UsersRole.create!(users_id: users[:junior].id, roles_id: jmail_roles[:normal].id)
UsersRole.create!(users_id: users[:oliveira].id, roles_id: jmail_roles[:admin].id)

# jvideos_users_roles
UsersRole.create!(users_id: users[:oliveira].id, roles_id: jvideos_roles[:admin].id)
UsersRole.create!(users_id: users[:oliveira].id, roles_id: jvideos_roles[:normal].id)
UsersRole.create!(users_id: users[:santos].id, roles_id: jvideos_roles[:normal].id)
UsersRole.create!(users_id: users[:junior].id, roles_id: jvideos_roles[:admin].id)

# jphotos_users_roles
UsersRole.create!(users_id: users[:joacir].id, roles_id: jphotos_roles[:poster].id)
UsersRole.create!(users_id: users[:santos].id, roles_id: jphotos_roles[:poster].id)

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

clients = { google: Client.create!(name: 'Google'), facebook: Client.create!(name: 'Facebook'), amazon: Client.create!(name: 'Amazon') }

products = { gmail: Product.create!(name: 'Gmail', description: 'Google Eletronic Mail'), youtube: Product.create!(name: 'YouTube', description: 'YouTube Video'), instagram: Product.create!(name: 'Instagram', description: 'Instagram *') }

users = { joacir: User.create!(login: 'joacir@email.com', name: 'Joacir'), junior: User.create!(login: 'junior@email.com', name: 'Junior'), joacirjunior: User.create!(login: 'joacir.junior@email.com.br', name: 'Joacir Junior'), oliveira: User.create!(login: 'oliveira@email.com.br', name: 'Oliveira'), santos: User.create!(login: 'santos@email.co.jp', name: 'Santos') }

google_products = { gmail: ClientsProduct.create!(product_id: products[:gmail].id, client_id: clients[:google].id), youtube: ClientsProduct.create!(product_id: products[:youtube].id, client_id: clients[:google].id) }
facebook_products = { instagram: ClientsProduct.create!(product_id: products[:instagram].id, client_id: clients[:facebook].id) }

youtube_features = { post: Feature.create!(product_id: products[:youtube].id, name: 'Post Videos'), watch: Feature.create!(product_id: products[:youtube].id, name: 'Watch Videos') }
gmail_features = { send: Feature.create!(product_id: products[:gmail].id, name: 'Send Email'), remove: Feature.create!(product_id: products[:gmail].id, name: 'Remove Email') }
instagram_features = { post: Feature.create!(product_id: products[:instagram].id, name: 'Post Photo'), like: Feature.create!(product_id: products[:instagram].id, name: 'Like Post') }

gmail_roles = { admin: Role.create!(name: 'admin', clients_products_id: google_products[:gmail].id), normal: Role.create!(name: 'normal', clients_products_id: google_products[:gmail].id)}
youtube_roles = { admin: Role.create!(name: 'master', clients_products_id: google_products[:youtube].id), normal: Role.create!(name: 'normal', clients_products_id: google_products[:youtube].id)}
instagram_roles = { liker: Role.create!(name: 'liker', clients_products_id: facebook_products[:instagram].id), poster: Role.create!(name: 'poster', clients_products_id: facebook_products[:instagram].id) }

# youtube_features_roles
FeaturesRole.create!(features_id: youtube_features[:post].id, roles_id: youtube_roles[:admin].id)
FeaturesRole.create!(features_id: youtube_features[:post].id, roles_id: youtube_roles[:normal].id)
FeaturesRole.create!(features_id: youtube_features[:watch].id, roles_id: youtube_roles[:admin].id)
FeaturesRole.create!(features_id: youtube_features[:watch].id, roles_id: youtube_roles[:normal].id)

# gmail_features_roles
FeaturesRole.create!(features_id: gmail_features[:send].id, roles_id: gmail_roles[:admin].id)
FeaturesRole.create!(features_id: gmail_features[:send].id, roles_id: gmail_roles[:normal].id)
FeaturesRole.create!(features_id: gmail_features[:remove].id, roles_id: gmail_roles[:admin].id)

# instagram_features_roles
FeaturesRole.create!(features_id: instagram_features[:post].id, roles_id: instagram_roles[:poster].id)
FeaturesRole.create!(features_id: instagram_features[:like].id, roles_id: instagram_roles[:liker].id)

# gmail_users_roles
UsersRole.create!(users_id: users[:joacir].id, roles_id: gmail_roles[:admin].id)
UsersRole.create!(users_id: users[:joacir].id, roles_id: gmail_roles[:normal].id)
UsersRole.create!(users_id: users[:junior].id, roles_id: gmail_roles[:normal].id)
UsersRole.create!(users_id: users[:oliveira].id, roles_id: gmail_roles[:admin].id)

# youtube_users_roles
UsersRole.create!(users_id: users[:oliveira].id, roles_id: youtube_roles[:admin].id)
UsersRole.create!(users_id: users[:oliveira].id, roles_id: youtube_roles[:normal].id)
UsersRole.create!(users_id: users[:santos].id, roles_id: youtube_roles[:normal].id)
UsersRole.create!(users_id: users[:junior].id, roles_id: youtube_roles[:admin].id)

# instagram_users_roles
UsersRole.create!(users_id: users[:joacir].id, roles_id: instagram_roles[:poster].id)
UsersRole.create!(users_id: users[:santos].id, roles_id: instagram_roles[:poster].id)

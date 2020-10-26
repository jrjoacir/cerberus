# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

clients = { google: Client.create!(name: 'Google'),
            facebook: Client.create!(name: 'Facebook'),
            amazon: Client.create!(name: 'Amazon') }

products = { jmail: Product.create!(name: 'JMail', description: 'Jota Eletronic Mail'),
             jvideos: Product.create!(name: 'JVideos', description: 'Jota Videos'),
             jphotos: Product.create!(name: 'JPhotos', description: 'Jota Photos') }

users = { joacir: User.create!(login: 'joacir@email.com', name: 'Joacir'),
          junior: User.create!(login: 'junior@email.com', name: 'Junior'),
          joacirjunior: User.create!(login: 'joacir.junior@email.com.br', name: 'Joacir Junior'),
          oliveira: User.create!(login: 'oliveira@email.com.br', name: 'Oliveira'),
          santos: User.create!(login: 'santos@email.co.jp', name: 'Santos') }

google_products = { jmail: Contract.create!(product_id: products[:jmail].id,
                                            client_id: clients[:google].id,
                                            enabled: true),
                    jvideos: Contract.create!(product_id: products[:jvideos].id,
                                              client_id: clients[:google].id,
                                              enabled: false) }
facebook_products = { jphotos: Contract.create!(product_id: products[:jphotos].id,
                                                client_id: clients[:facebook].id,
                                                enabled: true) }

jvideos_features = { post: Feature.create!(product_id: products[:jvideos].id, name: 'Post Videos', enabled: true),
                     watch: Feature.create!(product_id: products[:jvideos].id, name: 'Watch Videos', enabled: true) }
jmail_features = { send: Feature.create!(product_id: products[:jmail].id, name: 'Send Email', enabled: true),
                   remove: Feature.create!(product_id: products[:jmail].id, name: 'Remove Email', read_only: false) }
jphotos_features = { post: Feature.create!(product_id: products[:jphotos].id, name: 'Post Photo',
                                           read_only: true, enabled: false),
                     like: Feature.create!(product_id: products[:jphotos].id, name: 'Like Post') }

jmail_roles = { admin: Role.create!(name: 'admin', contract_id: google_products[:jmail].id),
                normal: Role.create!(name: 'normal', contract_id: google_products[:jmail].id, enabled: true) }
jvideos_roles = { admin: Role.create!(name: 'master', contract_id: google_products[:jvideos].id, enabled: true),
                  normal: Role.create!(name: 'normal', contract_id: google_products[:jvideos].id, enabled: false) }
jphotos_roles = { liker: Role.create!(name: 'liker', contract_id: facebook_products[:jphotos].id, enabled: true),
                  poser: Role.create!(name: 'poser', contract_id: facebook_products[:jphotos].id) }

# jvideos_features_roles
FeaturesRole.create!(feature_id: jvideos_features[:post].id, role_id: jvideos_roles[:admin].id)
FeaturesRole.create!(feature_id: jvideos_features[:post].id, role_id: jvideos_roles[:normal].id)
FeaturesRole.create!(feature_id: jvideos_features[:watch].id, role_id: jvideos_roles[:admin].id)
FeaturesRole.create!(feature_id: jvideos_features[:watch].id, role_id: jvideos_roles[:normal].id)

# jmail_features_roles
FeaturesRole.create!(feature_id: jmail_features[:send].id, role_id: jmail_roles[:admin].id)
FeaturesRole.create!(feature_id: jmail_features[:send].id, role_id: jmail_roles[:normal].id)
FeaturesRole.create!(feature_id: jmail_features[:remove].id, role_id: jmail_roles[:admin].id)

# jphotos_features_roles
FeaturesRole.create!(feature_id: jphotos_features[:post].id, role_id: jphotos_roles[:poser].id)
FeaturesRole.create!(feature_id: jphotos_features[:like].id, role_id: jphotos_roles[:liker].id)

# jmail_users_roles
UsersRole.create!(user_id: users[:joacir].id, role_id: jmail_roles[:admin].id)
UsersRole.create!(user_id: users[:joacir].id, role_id: jmail_roles[:normal].id)
UsersRole.create!(user_id: users[:junior].id, role_id: jmail_roles[:normal].id)
UsersRole.create!(user_id: users[:oliveira].id, role_id: jmail_roles[:admin].id)

# jvideos_users_roles
UsersRole.create!(user_id: users[:oliveira].id, role_id: jvideos_roles[:admin].id)
UsersRole.create!(user_id: users[:oliveira].id, role_id: jvideos_roles[:normal].id)
UsersRole.create!(user_id: users[:santos].id, role_id: jvideos_roles[:normal].id)
UsersRole.create!(user_id: users[:junior].id, role_id: jvideos_roles[:admin].id)

# jphotos_users_roles
UsersRole.create!(user_id: users[:joacir].id, role_id: jphotos_roles[:poser].id)
UsersRole.create!(user_id: users[:santos].id, role_id: jphotos_roles[:poser].id)

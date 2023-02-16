# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

User.find_or_create_by!(email: 'xandemacedo1712@gmail.com', password: 'Recdin2023!', uuid_session: SecureRandom.uuid)

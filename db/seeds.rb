# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

json_data = File.read(Rails.root.join('db', 'seeds', 'data.json'))
parsed_data = JSON.parse(json_data)

parsed_data.each do |person_data|
  person = Person.create(
    name: person_data['name'],
    email: person_data['info']['email']
  )

  person_data['info'].each do |key, value|
    next if key == 'email'
    Detail.create(
      person: person,
      detail_type: key,
      detail_value: value
    )
  end
end

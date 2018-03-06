# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)



start = Time.now
4000.times do |t|
  a = []
  500.times do |s|
    a << Thread.new do
      HTTParty.post("http://localhost:3000/api/v1/evaluations?entry_id=#{rand(1..10000)}&appraisal=#{rand(1..5)}")
      end
    end
  asd = a.map(&:value)
  puts asd
  puts Time.now - start
end
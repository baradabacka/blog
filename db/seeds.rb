#create users and entries
200000.times do |login|
  HTTParty.post("http://localhost:3000/api/v1/entries?login=#{rand(1..100)}&autor_ip=#{rand(1..50)}&content=asd&caption=test}")
end



#create_evaluations
entry_ids = Entry.ids
100000.times do |t|
  10.times do |s|
    Thread.new do
      HTTParty.post("http://localhost:3000/api/v1/evaluations?entry_id=#{rand(entry_ids)}&appraisal=#{rand(1..5)}")
    end
  end
end
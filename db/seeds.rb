# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Plan.create(title: 'Basic',
            time_months: 3,
            member_quantity: 20,
            price: Money.from_cents(1000))
Plan.create(title: 'Small Business',
            time_months: 6,
            member_quantity: 40,
            price: Money.from_cents(2000))
Plan.create(title: 'Premium',
            time_months: 12,
            member_quantity: 100,
            price: Money.from_cents(10000))

admin_user = User.create(first_name: 'root', last_name: 'root', email: 'root@root.com', password: 'rootro')

if Rails.env == 'development'
  Board.create(title: 'My greate project I', author_id: admin_user.id)
  Board.create(title: 'My greate project II', author_id: admin_user.id)
  Board.create(title: 'My greate project III', author_id: admin_user.id)

  Board.all.each do |board|
   board.task_lists << TaskList.new(name: 'Pending', color: '#FAEA07', priority: 1)
   board.task_lists << TaskList.new(name: 'In Progress', color: '#FF9933', priority: 2)
   board.task_lists << TaskList.new(name: 'Testing', color: '#000000', priority: 3)
   board.task_lists << TaskList.new(name: 'Finished', color: '#58D22B', priority: 4)
  end
end

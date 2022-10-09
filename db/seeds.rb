# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# plans creation
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
            price: Money.from_cents(10_000))

# admin user
admin_user = User.new(first_name: 'Admin',
                      last_name: 'Admin',
                      email: 'admin@admin.com',
                      password: 'adminn',
                      authorization_tier: 'admin')
admin_user.skip_confirmation!
admin_user.save!

if Rails.env.development?
  # create managers
  (1..4).to_a.each do |index|
    manager_user = User.new(first_name: "Manager#{index}",
                            last_name: "Manager#{index}",
                            email: "manager#{index}@manager.com",
                            password: 'manager',
                            authorization_tier: 'manager')
    manager_user.skip_confirmation!
    manager_user.save!
  end

  # create regular users
  User.all.where.not(authorization_tier: 'user').each do |manager|
    (1..4).to_a.each do |index|
      uniq_index = "#{manager.id}#{index}"
      user = User.new(first_name: "User#{uniq_index}",
                      last_name: "User#{uniq_index}",
                      email: "user#{uniq_index}@user.com",
                      password: 'userrr',
                      authorization_tier: 'user')
      user.skip_confirmation!
      manager.team_members << user
    end

    # create boards
    Board.create(title: 'My greate project I', author_id: manager.id)
    Board.create(title: 'My greate project II', author_id: manager.id)
    Board.create(title: 'My greate project III', author_id: manager.id)
  end

  # create task lists
  Board.all.each do |board|
    board.task_lists << TaskList.new(name: 'Pending', color: '#FAEA07', priority: 1)
    board.task_lists << TaskList.new(name: 'In Progress', color: '#FF9933', priority: 2)
    board.task_lists << TaskList.new(name: 'Testing', color: '#000000', priority: 3)
    board.task_lists << TaskList.new(name: 'Finished', color: '#58D22B', priority: 4)
  end

  # create tasks
  User.all.where.not(authorization_tier: 'user').each do |manager|
    manager.boards.each do |board|
      board.task_lists.where(priority: 1).each do |task_list|
        task_list.tasks << Task.new(title: 'Alpha feature', creator: manager)
        task_list.tasks << Task.new(title: 'Beta feature', creator: manager)
        task_list.tasks << Task.new(title: 'Omega feature', creator: manager)
        task_list.tasks << Task.new(title: 'Keter feature', creator: manager)
      end

      board.task_lists.where(priority: 4).each do |task_list|
        task_list.tasks << Task.new(title: 'Completed I',
                                    creator: manager,
                                    completed: true,
                                    justification: 'Lorem ipsum lom remson',
                                    doing_time: 24.hours.to_i,
                                    started_at: Time.zone.now - 1.day,
                                    finished_at: Time.zone.now)
        task_list.tasks << Task.new(title: 'Completed II',
                                    creator: manager,
                                    completed: true,
                                    justification: 'Lorem ipsum lom remson',
                                    doing_time: 24.hours.to_i,
                                    started_at: Time.zone.now - 1.day,
                                    finished_at: Time.zone.now)
      end

      # add users to tasks
      task_list = board.task_lists.first
      task_list.tasks.first(2).each do |task|
        manager.team_members.each do |team_member|
          task.users << team_member
        end
      end
    end
  end
end

# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.create({
                     'first_name' => 'saqib',
                     'last_name' => 'ejaz',
                     'email' => 'saqibejaz285@gmail.com',
                     'password' => '123abc',
                     'confirm_password' => '123abc'
                   })

user.skip_confirmation!

Post.create({
              'title' => 'My Seed Post',
              'content' => 'a very comprehensive post',
              'user_id' => '1',
              'approved' => 'true'
            })

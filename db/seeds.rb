# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Category.create!([
  {
    name: "デスク"
  },
  {
    name: "椅子"
  },
  {
    name: "PC"
  },
  {
    name: "モニター"
  },
  {
    name: "マウス"
  },
  {
    name: "キーボード"
  },
  {
    name: "AV機器"
  },
  {
    name: "マイク"
  },
  {
    name: "カメラ"
  },
  {
    name: "照明"
  },
  {
    name: "収納"
  },
  {
    name: "PCアクセサリー"
  },
  {
    name: "その他"
  }
])

User.create!([
  {
    name: "Alice",
    username: "alice",
    email: "alice@example.com",
    password: "123456"
  },
  {
    name: "Bob",
    username: "boblim",
    email: "bob@example.com",
    password: "123456"
  },
  {
    name: "Chris",
    username: "chris",
    email: "chris@example.com",
    password: "123456"
  },
  {
    name: "Daniel",
    username: "daniel",
    email: "daniel@example.com",
    password: "123456"
  },
  {
    name: "太郎",
    username: "tarotaros",
    email: "taro@example.com",
    password: "123456"
  }
])

Post.create!([
  {
    text ''
  }
])
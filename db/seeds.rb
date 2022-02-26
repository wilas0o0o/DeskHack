# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Category.find_or_create_by([
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
  },
])
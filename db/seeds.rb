# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
lady = Category.create(name: "レディース")
lady_tops = lady.children.create(name: "トップス")
lady_bottoms = lady.children.create(name: "ボトムス")
lady_inners = lady.children.create(name: "インナー")
lady_tops.children.create([{name: "Tシャツ"},{name: "セーター"}])
lady_bottoms.children.create([{name: "ジーパン"},{name: "スカート"}])
lady_inners.children.create([{name: "パンツ"},{name: "ブラジャー"}])


men = Category.create(name: "メンズ")
men_tops = men.children.create(name: "トップス")
men_bottoms = men.children.create(name: "ボトムス")
men_inners = men.children.create(name: "インナー")
men_tops.children.create([{name: "Tシャツ"},{name: "セーター"}])
men_bottoms.children.create([{name: "ジーパン"},{name: "スカート"}])
men_inners.children.create([{name: "パンツ"},{name: "ブラジャー"}])


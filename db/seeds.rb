# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Property.destroy_all
User.destroy_all

User.create(
	email: 'user@email.com',
	password: 'user1234'
)

User.create(
	email: 'admin@email.com',
	password: 'admin1234',
	admin: true
)

30.times do
  Property.create(
  	rent: rand(1000..100000),
  	currency: 'NT$',
  	full_address: 'Sec. 3, Nangang Rd. Nangang Dist., Taipei City',
  	unit_type: 'residential',
  	bedroom: rand(2..10),
  	bathroom: rand(2..10),
  	closest_mrt: ['Yongning', 'Tucheng', 'Wanfang', 'Qizhang', 'Xiulang Bridge'].sample,
  	floor_size_in_ping: rand(1000..10000),
  	floor_size_in_sqft: rand(1000..10000),
  	city: 'Taipei',
  	district: ['Datong', 'Daan', 'Nangang', 'Shilin'].sample,
  	title: 'MRT昆陽，潤泰玉成企業總部',
  	image_url: 'https://urhouse.s3.amazonaws.com/images/rentals/567c4bae0aa0cc886831ee6e8aff6646-watermarked.jpg'
  )
end

30.times do
  Property.create(
  	rent: rand(1000..100000),
  	currency: 'NT$',
  	full_address: 'Sec. 3, Nangang Rd. Nangang Dist., New Taipei City',
  	unit_type: 'residential',
  	bedroom: rand(2..10),
  	bathroom: rand(2..10),
  	closest_mrt: ['Yongning', 'Tucheng', 'Wanfang', 'Qizhang', 'Xiulang Bridge'].sample,
  	floor_size_in_ping: rand(1000..10000),
  	floor_size_in_sqft: rand(1000..10000),
  	city: 'New Taipei',
  	district: ['Jinshan', 'Bali', 'Linkou', 'Shulin', 'Taishan'].sample,
  	title: 'MRT昆陽，潤泰玉成企業總部',
  	image_url: 'https://urhouse.s3.amazonaws.com/images/rentals/567c4bae0aa0cc886831ee6e8aff6646-watermarked.jpg'
  )
end
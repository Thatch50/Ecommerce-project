require 'csv'

# Category.destroy_all
# puts "Categories table destroyed..."
Ammunition.destroy_all
puts "Ammunitions table destroyed..."
Weapon.destroy_all
puts "Weapons table destroyed..."

categories = ['Pistol', 'Rifle', 'SMG', 'Shotgun', 'Heavy', 'Energy Pistol', 'Energy Rifle', 'Energy Heavy', 'Explosive Projectile', 'Explosive Thrown', 'Explosive Placed', 'Melee Bladed', 'Melee Blunt', 'Melee Thrown', 'Melee Unarmed']

# categories.each do |category, index|
#   cat = Category.new
#   cat.name = category
#   cat.save
#   if (cat.save)
#     puts "#{cat.name} saved!"
#   else
#     puts "#{cat.errors.details}"
#   end
# end

ammo_csv_text = File.read(Rails.root.join("public/Web-scraper", "ammo.csv"))
ammo_csv = CSV.parse(ammo_csv_text, :headers => true)
ammo_csv.each do |row|
  ammo = Ammunition.create(id: row["id"],
                           name: row["name"],
                           price: row["price"],
                           description: row["description"])
  ammo.save

  # ammoWeapon = Weapon.new
  # ammoWeapon.ammunitions = ammo
  # ammoWeapon.save
  # if (ammoWeapon.save)
  #   puts "#{ammoWeapon.save} saved!"
  # else
  #   puts "#{ammoWeapon.errors.details}"
  # end

  if (ammo.save)
    puts "#{ammo.name} saved!"
  else
    puts "#{ammo.errors.details}"
  end
end

weapon_csv_text = File.read(Rails.root.join("public/Web-scraper", "guns.csv"))
weapon_csv = CSV.parse(weapon_csv_text, :headers => true)
weapon_csv.each do |row|

  weapon = Weapon.new
  weapon.name = row["name"]
  weapon.price = row["price"]
  weapon.category_id = Category.where(id: row["category"]).first.id
  # puts Category.where(id: row["category"]).first.id
  weapon.in_stock = true
  weapon.weight = row["weight"]
  weapon.description = row["description"]

  # ammoWeapon = AmmunitionsWeapons.where(ammunition_id: row["ammo"])
  # ammoWeapon.weapon_id = row["id"]
  # ammoWeapon.save

  weapon.save
  if (weapon.save)
    puts "#{weapon.name} saved!"
  else
    puts "#{weapon.errors.details}"
  end
end

puts "Database was seeded successfully..."
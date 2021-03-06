class Weapon < ApplicationRecord
  mount_uploader :image, DefaultUploader
  paginates_per 21

  has_many :weapon_ammunitions, :dependent => :destroy
  has_many :ammunitions, through: :weapon_ammunitions
  accepts_nested_attributes_for :weapon_ammunitions, allow_destroy: true

  belongs_to :category
  belongs_to :status

  validates :name, uniqueness:true
  validates :name, :description, presence: true
  validates :weight, :price, numericality: { greater_than_or_equal_to: 0 }

end

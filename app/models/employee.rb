class Employee < ApplicationRecord
    validates :name, presence: true
    validates :position, presence: true
    validates :department, presence: true
    validates :salary, numericality: { greater_than: 0 }
  end
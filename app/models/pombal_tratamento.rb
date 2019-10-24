class PombalTratamento < ApplicationRecord
  
  belongs_to :pombal
  belongs_to :tratamento
  belongs_to :usuario
  
  validates :dtinicio, presence: true
  
end

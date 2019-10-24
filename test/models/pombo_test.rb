require 'test_helper'

class PomboTest < ActiveSupport::TestCase
  def setup
    @pombo = pombos(:one)
    @pai = pombos(:three)
    @mae = pombos(:two)
  end
  
  test "pai should not be femea" do
    @pombo.pai_id = @mae.id
    assert_not @pombo.valid?
  end
  
  test "pai should be macho" do
    @pai.pai_id  = @pombo.id
    assert @pai.valid?
  end
  
  test "pombo sexo inexistente" do
    pombo  = Pombo.new(id: 2, anilha: "222BR", nome: "Travis",
                       dtnasc: "2014-06-18 03:00:00", sexo: "T", cor_id: 1, usuario_id: 2)
    assert_not pombo.valid?
  end
end

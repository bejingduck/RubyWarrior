class Player
  
  def initialize
    @currentDirection = :forward
    @backDirection = :backward
    @rested = false
    @in_battle? = false
    @previousHealth = 0
    @enemies = ["Thick Sludge", "Archer"]
  end

  def rest(warrior)
    if taking_damage?(warrior.health)
      then
      if @rested
        warrior.walk!(@currentDirection)
      else
        warrior.walk!(@backDirection)
        @rested = true
      end
    else warrior.rest!
    end
  end

  def taking_damage?(currentHealth)
    if currentHealth <  @previousHealth
      then return true
      else return false
    end
  end

  def 

#def saveOrKill(warrior)
#
#   if (warrior.feel(@direction).captive?)
#    warrior.rescue!(@direction)
#    elsif (warrior.feel(@direction).wall?)
#      @direction = :forward
#      @backDirection = :backward
#    warrior.walk!(@direction)
#   else
#    warrior.attack!(@direction)
#    end
#  end

  
  def turnAround(warrior)

    @currentDirection, @backDirection = @backDirection, @currentDirection
    print "we are turning\n"
    warrior.pivot!
  end

  def displayDebugInfo(warrior)
    print "1. direction = ",@currentDirection,"...\n"
    print "2. Health    = ",warrior.health,"...\n"
    print "3. In front of    =", warrior.feel,"...\n"
 end

  def play_turn(warrior)

    displayDebugInfo(warrior)

    case String(warrior.feel)
      when "wall"        
        turnAround(warrior)
      when -> (n) {@enemies.include? n} 
        @in_battle? = true
        warrior.attack!
      when "nothing"
        @in_battle? = false
        rest(warrior)
        warrior.walk!
      else
        print "what is ", warrior.feel,"...\n"
    end  
        
  end
end
class Player
  
  def initialize
    @currentDirection = :forward
    @backDirection = :backward
    @rested = false
    #@in_battle? = false
    @previousHealth = 0
    @enemies = ["Thick Sludge", "Archer"]
  end

  def intelegent_walk(warrior)
    if taking_damage?(warrior.health) 
    then
      print "backdirection is ", @backDirection, "\n"
      warrior.walk!(:backward) #if we are taking damage then walk to opposite direction
    else 
        if warrior.health == 20  #if we are NOT taking damage then either walk or rest
        then 
          @rested = true
          warrior.walk!
        else
          warrior.rest!
        end
    end
  end

  def taking_damage?(currentHealth)
    print "currentHealth is ",currentHealth, "\n"
    print "previousHealth is ", @previousHealth, "\n"
    if currentHealth <  @previousHealth
      then 
        print "we are under attack! \n"
        return true
      else return false
    end
  end
 

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
        #@in_battle? = true
        warrior.attack!
      when "nothing"
        #@in_battle? = false
        intelegent_walk(warrior)
      else
        print "what is ", warrior.feel,"...\n"
    end  
     
    # closing variables to be handed over to next cycle

    @previousHealth = warrior.health

  end
end
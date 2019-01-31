class Player
  
  def initialize
    @currentDirection = :forward
    @backDirection = :backward
    @rested = true
    @in_battle = false
    @previousHealth = 0
    @enemies = ["Thick Sludge", "Archer", "Wizard"]
  end

  def intelegent_walk(warrior)
    
    if taking_damage?(warrior.health) 
    then
      if @in_battle then 
        warrior.walk!(:backward) #if we are taking damage then walk to opposite direction
      else
        warrior.walk!(:forward)        
      end
    else 
        if warrior.health == 20  #if we are NOT taking damage then either walk or rest
        then 
          @rested = true
          @in_battle = false
          print "NOT in battle anymore. @in_battle: ", @in_battle, "\n"
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

  def looking_into_enemy? (warrior)

    looking_at = String(warrior.look[1])
    
    print looking_at, " \e[31m----> ", @enemies.include?(looking_at), "\e[0m\n"
    
    @enemies.include?(looking_at)
  end
 
  def turnAround(warrior)

    @currentDirection, @backDirection = @backDirection, @currentDirection
    print "we are turning\n"
    warrior.pivot!
  end

  def displayDebugInfo(warrior)
    @infront 
    
    print "1. direction = ",@currentDirection,"...\n"
    print "2. Health    = ",warrior.health,"...\n"
    print "3. In front of    =", warrior.feel,"...\n"
    
    for i in 1..3
        print "4.",i," Looking into  =", warrior.look[i] , "....\n"
    end
 end

  def play_turn(warrior)

    displayDebugInfo(warrior)

      
    case String(warrior.feel) #what do we have infront 
      when "wall"        
        turnAround(warrior)
      when -> (n) {@enemies.include? n}         
        warrior.attack!
        @in_battle = true
        print "TO THE ARMS!!!. @in_battle: ", @in_battle, "\n"
      when "Captive"
        warrior.rescue!
      when "nothing"
        if looking_into_enemy?(warrior) 
          then warrior.shoot! 
          else intelegent_walk(warrior) 
        end
      else
        print "what is ", warrior.feel,"...\n"
    end  
     
    # closing variables to be handed over to next cycle

    @previousHealth = warrior.health

  end
end
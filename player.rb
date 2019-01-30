class Player
  
  def initialize
    @direction = :forward
    @backDirection = :backward
    @rested = false
    @previousHealth = 0
  end

  def warriorQualityRest(warrior)
    if ifWarriorTakingDamage(warrior.health)
      then
      if @rested
      warrior.walk!(@direction)
      else
        warrior.walk!(@backDirection)
        @rested = true
      end
    else warrior.rest!
    end
  end

  def ifWarriorTakingDamage(currentHealth)
    if currentHealth <  @previousHealth
    then return true
    else return false
    end
  end

  def saveOrKill(warrior)

    if (warrior.feel(@direction).captive?)
    warrior.rescue!(@direction)
    elsif (warrior.feel(@direction).wall?)
      @direction = :forward
      @backDirection = :backward
    warrior.walk!(@direction)
    else
    warrior.attack!(@direction)
    end
  end

  def turnAround(warrior)

    print "WE ARE TURNING! - change!!"
    warrior.pivot!
    @direction = :backward
    @backDirection = :forward

  end

  def displayDebugInfo(warrior)
    print "+++++++++++ direction = ",@direction,"++++++++++++++++++\n"
    print "+++++++++++ Health    = ",warrior.health,"++++++++++++++\n"
    print "+++++++++++ In front of    = !!!!!!!", warrior.feel(@direction),"!!!!!!!!!++++++++++++++\n"
    print "+++ apparently this is a change\n"
    print "this is just to test github"
    print "this is just to test github2"
  end

  def play_turn(warrior)

    displayDebugInfo(warrior)

    if warrior.feel(@direction).wall?
      
      then
        turnAround(warrior)
      else

        if warrior.feel(@direction).empty? then
          if warrior.health < 20 then
            warriorQualityRest(warrior)
          else
            warrior.walk!(@direction)
          end
        else
          saveOrKill(warrior)
      end
      @previousHealth = warrior.health
    end
  end
end
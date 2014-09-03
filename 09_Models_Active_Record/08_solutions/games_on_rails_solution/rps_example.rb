class RockPaperScissors
  def initialize
    @throws = get_throws

    puts "to play the game choose a throw"
    puts "0: rock"
    puts "1: paper"
    puts "2: scissors"
    gets 
  end

  def call_show_action(input_from_url)
    @params = {:id => input_from_url}
    show()
  end

  def show
    @user_throw = @throws[@params[:id].to_i]
    #@throws = get_throws

    @game_throw = @throws[rand(3)]

    beats = {
      rock: :scissors,
      scissors: :paper,
      paper: :rock
    }

      if beats[@user_throw] == @game_throw
        @status = :win
      elsif user_throw == game_throw
        @status = :tie
      else
        @status = :loss
      end

    show_view
  end

  def show_view
    if @status == :win
      puts "YOU WON DUDE"
    elsif @status == :tie
      puts 'No it"s a tie'
    else
      puts 'YOU LOST!!'
    end
  end

  private

    def get_throws
      #    0       1      2
      [:rock, :paper, :scissors]
    end
end
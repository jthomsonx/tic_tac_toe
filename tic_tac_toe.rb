# Tic Tac Toe
#
# A sample project, created using the guidelines available at
# http://www.theodinproject.com/ruby-programming/oop?ref=lnav
#
# This version by James Thomson.

class Game
	attr_reader :grid
	Player = Struct.new(:name, :type, :sym)
	@@wins = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]

	def initialize
		@grid = Board.new
		@counter = 1
	end

	def play
		welcome_message
		player_select
		instructions
		start_playing
		show_result
		new_game
	end

	def welcome_message
		puts "........................."
		puts "Welcome to Tic Tac Toe!"
		puts "........................."
	end

	def player_select
		print "Please enter your name: "
		name = gets.chomp
		@p_one = Player.new(name, :human, "X")
		@p_two = Player.new("Computer", :computer, "O")
	end

	def coin_toss
		coin = rand()
		if coin < 0.5
			@toss_winner = @p_one
			@toss_loser = @p_two
		else
			@toss_winner = @p_two
			@toss_loser = @p_one
		end
	end

	def instructions
		coin_toss
		puts "........................."
		puts "#{@toss_winner.name}, you are '#{@toss_winner.sym}' and will go first"
		puts "#{@toss_loser.name}, you are '#{@toss_loser.sym}' and will go second"
		puts "........................."
		@grid.print_grid
		puts ""
	end

	def start_playing
		take_turns until game_over
	end

	def take_turns
		if @counter.odd?
			turn(@toss_winner)
		else
			turn(@toss_loser)
		end
	end

	def turn(player)
		if player.type == :human
			puts "Turn: #{player.name}"
			print "Please input a cell value, from 1 to 9: "
			input = gets.chomp.to_i - 1
			if @grid.update(input, player.sym) == true
				@counter += 1
			else
				puts "Invalid Cell - Try Again"
			end
			puts ""
			@grid.print_grid
			puts ""
		elsif player.type == :computer
			input = rand(9) - 1
			if @grid.update(input, player.sym) == true
				@counter += 1
				puts "Turn: #{player.name}"
				puts ""
				sleep 1
				@grid.print_grid
				puts ""
			end
		end
		check_for_win(player)
	end

	def game_over
		@counter > 9 || @winner
	end

	def check_for_win(player)
		@@wins.each do |w|
			@winner = player if w.all? { |a| @grid.board[a] == player.sym }
		end
	end

	def show_result
		if @winner != nil
			puts "Congratulations #{@winner.name}! You are the winner!"
		else
			puts "Game was a draw!"
		end
	end

	def new_game
		print "New game?  (Y/N): "
		answer = gets.chomp
		if answer.downcase == "y"
			game = Game.new
			game.play
		else
			puts "Thanks for playing!"
		end
	end

	class Board
	attr_reader :board, :empty_cell

		def initialize
			@empty_cell = "-"
			@board = Array.new(9, @empty_cell)
		end

		def print_grid
			@board.each_slice(3) { |row| puts row.join(" | ") }
		end	

		def update(pos, sym)
			if @board[pos] == @empty_cell
				@board[pos] = sym
				return true
			else
				return false
			end
		end
	end

end

game = Game.new
game.play

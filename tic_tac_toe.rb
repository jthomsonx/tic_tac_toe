# Tic Tac Toe
#
# A sample project, created using the guidelines available at
# http://www.theodinproject.com/ruby-programming/oop?ref=lnav
#
# This version by James Thomson.

class Game
	attr_reader :grid
	Player = Struct.new(:name, :sym)
	@@wins = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]

	def initialize
		@grid = Board.new
		@p_one = Player.new("Player One", "X")
		@p_two = Player.new("Player Two", "O")
		@counter = 1
	end

	def play
		welcome_message
		start_playing
		show_result
	end

	def welcome_message
		puts "........................."
		puts "Welcome to the Tic Tac Toe game"
		puts "........................."
		puts "........................."
		puts "#{@p_one.name}, you are '#{@p_one.sym}' and will go first"
		puts "#{@p_two.name}, you are '#{@p_two.sym}' and will go second"
		puts "........................."
		@grid.print_grid
		puts ""
	end

	def start_playing
		take_turns until game_over
	end

	def take_turns
		if @counter.odd?
			turn(@p_one)
		else
			turn(@p_two)
		end
	end

	def turn(player)
			puts "Turn: #{@counter}, #{player.name}"
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

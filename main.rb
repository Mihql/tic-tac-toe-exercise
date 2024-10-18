# frozen_string_literal: true

# Root of project require files from library

require_relative 'lib/board'
require_relative 'lib/player'
require_relative 'lib/game'

Game.new.play

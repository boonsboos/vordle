// Copyright 2022 MrsHerobrine

module main

import game

import os

fn main() {
	if os.args.len < 2 {
		game.game()
	} else {
		match os.args[1] {
			'about' {
				println('vordle, © 2022 mrsherobrine. Licensed under MIT.')
			}
			'help' {
				println('need help playing the game?')
				println('you fill in 5 letter words')
				println('if the letter is in the word, it\'ll become yellow')
				println('if the letter is in the right spot, it\'ll become green')
				println('if it\'s not the right letter, it\'ll be gray')
				println('the goal is to guess the word within 6 turns')
			}
			else { game.game() }
		}
	}
}
module game

import util

import rand
import readline
import time

struct Letter {
pub:
	char	byte
pub mut:
	color	util.LetterReturn
}

[inline]
fn (l Letter) str() string {
	return util.letter_with_color(l.color, l.char)
}

pub fn random_word() string {
	return words[rand.int_in_range(0, words.len)]
}

pub fn game() {

	mut stopwatch := time.new_stopwatch()

	mut rl := readline.Readline{}

	mut win := false
	mut game := []string{len:6}
	//word := random_word()
	word := 'umami'

	stopwatch.start()

	for i in 0..game.len {
		
		mut guess := ''

		for {
			guess = rl.read_line('guess: ') or { '' }.trim_space()
			if guess.len != 5 && !words.contains(guess) {
				if guess.contains(' ') { println('tryna cheat? nah fam.') }
				println('\nbad! try again')
			} else {
				break
			}
		}

		mut end_str := []Letter{len:5}

		// if indexes don't line up BUT it is in the word -> yellow
		// if indexes don't line up BUT there's multiple AND there's more than in word, last one -> yellow

		// mark greens
		for j, char in guess {
			if word[j] == char { end_str[j] = Letter{char, .green} }
			else { end_str[j] = Letter{char, .unknown} }
		}

		mut occ_word = 0
		mut occ_guess = 0
		// mark yellows
		for k, char in guess {

			if end_str[k].color == .green { continue }

			occ_word = word.count([char].bytestr())
			occ_guess = guess.count([char].bytestr())
			
			contains = word.contains([char].bytestr())

			if contains { end_str[k].color = .yellow }

			// check if the character occurs more than once, otherwise keep it yellow
			if contains && occ_guess > occ_word {
				end_str[k].color = .gray 
			} else if contains && occ_guess == occ_word {
				end_str[k].color = .yellow 
			}
		}

		// mark grays
		for l, _ in guess {
			if end_str[l].color == .unknown { end_str[l].color = .gray }
		}

		if guess == word {
			stopwatch.stop()
			win = true
			break
		}

		game[i] = end_str.to_string()

		print_board(i, game)

	}

	if win {
		println('${count_nulls(game)}/6 | you took ${int(stopwatch.elapsed().minutes())} minutes')
		println('you win! word was ${word}')
	} else {
		println('X/6')
		println('you lost! word was ${word}')
	}

}

[inline]
fn print_board(index int, array []string) {
	for i in 0..index+1 {
		println(array[i])
	}
}

fn count_nulls(array []string) int {
	mut idx := 0
	for i in array {
		if i != '' { idx++ }
	}
	return idx
}

fn (arr []Letter) to_string() string {
	mut str := ''
	for i in arr {
		str += i.str()
	}
	return str
}

fn delta_chars(str1 string, str2 string, compare byte) int {
	return str1.count([compare].bytestr()) - str2.count([compare].bytestr())
}
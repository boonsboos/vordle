// Copright 2022 MrsHerobrine

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

fn (arr []Letter) to_string() string {
	mut str := ''
	for i in arr {
		str += i.str()
	}
	return str
}

pub struct Game {
pub mut:
	dictionary	bool
}

pub fn (g Game) game() {

	println("welcome to vordle.")
	println("run `vordle help` if you don't know how to play")

	mut stopwatch := time.new_stopwatch()

	mut rl := readline.Readline{}

	mut win := false
	mut game := []string{len:6}
	word := random_word()
	//word := 'salad' // this for testing
	stopwatch.start()

	for i in 0..game.len {
		
		mut guess := ''

		for {
			guess = rl.read_line('guess: ') or { '' }.trim_space()
			if guess.len != 5 {
				if guess.contains(' ') { 
					println('word cannot contain spaces')
					continue
				}
				println('\nword needs to have 5 letters')
			} else {
				if !words.contains(guess) { 
					println('not in word list')
					continue
				}
				break
			}
		}

		mut end_str := []Letter{len:5}
		mut char_indices := map[byte][]int{} // takes a character and an index
		
		for p, char in guess {
			char_indices[char] << p
		}

		// mark greens
		for j, char in guess {
			if word[j] == char { end_str[j] = Letter{char, .green} }
			else { end_str[j] = Letter{char, .unknown} }
		}

		mut occ_word := 0
		mut occ_guess := 0
		// mark yellows
		for k, char in guess {

			occ_word = word.count([char].bytestr())
			occ_guess = guess.count([char].bytestr())
			
			contains := word.contains([char].bytestr())

			if end_str[k].color == .green || end_str[k].color == .yellow { continue }

			if contains && occ_guess > occ_word && count_greens(end_str) <= 1 {
				end_str[k].color = .gray

				idx := char_indices[char][1]
				ix := char_indices[char][0]

				if end_str[ix].color != .green && end_str[idx].color != .green {
					end_str[idx].color = .yellow
				}
			} else if contains && occ_guess > occ_word {
				end_str[k].color = .gray

				idx := char_indices[char][1]
				ix := char_indices[char][0]

				if end_str[ix].color != .green && end_str[idx].color != .green {
					end_str[idx].color = .yellow
				}
			} else if contains && occ_guess == occ_word {
				end_str[k].color = .yellow
			} else if contains && occ_guess < occ_word {
				end_str[k].color = .yellow
			}

		}

		// mark grays
		for l, _ in guess {
			if end_str[l].color == .unknown { end_str[l].color = .gray }
		}

		game[i] = end_str.to_string()

		print_board(i, game)

		if guess == word {
			stopwatch.stop()
			win = true
			break
		}

	}

	if win {
		println('${count_nulls(game)}/6 | you took ${format_times(stopwatch)}!')
		println('you win! word was ${word}')
		if g.dictionary{ get_definition(word) }
	} else {
		println('X/6')
		println('you lost! word was ${word}')
		if g.dictionary { get_definition(word) }
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

fn format_times(stopwatch time.StopWatch) string {
	elapsed := stopwatch.elapsed()
	mins := int(elapsed.minutes())
	secs := int(elapsed.seconds()) % 60
	return "$mins:$secs"
}

pub fn random_word() string {
	return words[rand.intn(words.len)]
}

fn count_greens(arr []Letter) int {
	mut a := 0
	for i in arr {
		if i.color == .green { a++ }
	}
	return a
}

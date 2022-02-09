// Copyright 2022 MrsHerobrine

module util

import term

pub enum LetterReturn {
	gray = 0
	yellow
	green
	unknown
}

pub fn letter_with_color(ret LetterReturn, letter byte) string {
	match ret {
		.gray { return term.bg_black(term.bright_white([letter].bytestr())) }
		.yellow { return term.bg_yellow(term.black([letter].bytestr())) }
		.green { return term.bg_green(term.bright_white([letter].bytestr())) }
		else { return term.bg_blue(term.bright_black('!')) }
	}
}
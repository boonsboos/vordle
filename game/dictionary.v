module game

import net.http
import x.json2

pub fn get_definition(word string) {
	resp := http.get('https://api.dictionaryapi.dev/api/v2/entries/en/$word') or { http.Response{} }
	if resp.text != '' {
		json_resp := json2.raw_decode(resp.text) or { '' }
		resp_map := json_resp.as_map()
		// gotta love when they use arrays
		i := resp_map['0']    or { map[string]json2.Any{} }.as_map() // array index
		j := i['meanings']    or { map[string]json2.Any{} }.as_map()
		k := j['0'] 		  or { map[string]json2.Any{} }.as_map() // array index 
		l := k['definitions'] or { map[string]json2.Any{} }.as_map()
		m := l['0']			  or { map[string]json2.Any{} }.as_map() // array index

		d := m['definition']  or {'!'}.str()
		e := m['example']     or {'!'}.str()
		if d != '!' {
			println('$d\nExample: $e')
		}
	} else {
		println('unable to get the definition of the word.')
		println('are you connected to the internet?')
	}
}
# vordle

CLI Wordle clone, whipped up in an afternoon (+ bug fixes the day after).

Also check out [heatwave's wordle solver](https://github.com/heatwave0/wordler)! It's pretty cool.

### Usage
```
vordle [about|help]
    about 
      - shows the name and developer
    help
      - explains how to play the game
    dict(ionary)
      - shows the definition of a word after game
      - requires internet connection and is not able to show every word
```
Not passing any argument or passing one that is unknown starts the game.

### Building from source
The program is written in V. To compile it, you need the V compiler and Git installed.

```shell
$ git clone https://github.com/mrsherobrine/vordle
$ cd vordle
$ v (-prod -skip-unused) . # options between parentheses are optional, but result in a smaller executable
```
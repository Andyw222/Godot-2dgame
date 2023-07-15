# My Game

Code is based upon [godot's 2d tutorial](https://docs.godotengine.org/en/stable/getting_started/first_2d_game/index.html#), we are going to add additional features

## additional features for future development

* add mute button (with last setting memory)

## Additional Features Added

### Save game

* Added save game code

### Score

* Added mob exited score
* Code to record highscore
* Created highscore s time x by mob exited
* Added high score by difficulty level
* Add namebox for highscore record

### Increase screen size

* Made Landscape
* 1600 x 1200
* Increased mob scale to 0.75
* changed mob spawn path
* repositioned start postion of player

### lives updated
* Use the current play asset as a life indicator
* 3 lives per game
* When hit, character flashes
* When hit, character imortal while flashing
* Add live icons instead of numbers

### Difficulty levels

* Make easy/normal/hard/ded levels
* Vary mob spawn rates
* Vary speed

### Change score from seconds to mobs dodged

* Add counter for number of mobs
* Keep seconds counter in memory,show on final stats page, e.g:
```
Seconds lasted: 20
Mobs dodged: 43
```
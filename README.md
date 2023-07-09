# My Game

Code is based upon [godot's 2d tutorial](https://docs.godotengine.org/en/stable/getting_started/first_2d_game/index.html#), we are going to add additional features

## Ideas

### Lives

We will implement lives:

* Use the current play asset as a life indicator
* 3 lives per game
* When hit, character flashes
* When hit, character immobilised while flashing

### Increase screen size

* Make Landscape
* 1024 x 768 / 1280 x 1024 / decide how to make dynamic
* Increase player / mob scale

### Difficulty levels

* Make easy/normal/hard levels
* Vary mob spawn rates
* Vary speed

### Change score from seconds to mobs dodged

* Add counter for number of mobs
* Keep seconds counter in memory,show on final stats page, e.g:
```
Seconds lasted: 20
Mobs dodged: 43
```
* Remove 2 second end-of-game timer
* Create "Finish" button on stats page
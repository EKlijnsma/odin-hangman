# The Odin Project Hangman

This is the [Hangman Project](https://www.theodinproject.com/lessons/ruby-hangman) of the Ruby on Rails path of The Odin Project.

The assignment is to build a command line Hangman game where one player plays against the computer.
After the game functionality is implemented, the task is to use serialization to save and load the game state.

I chose to implement JSON, as it seems like the most common format, although YAML seems to work well with rails later on in this course.
I also chose to work with a module file this time, since I have not previously done so and wanted to get some experience with that.

When the game starts the user can
- enter **'N'**  to start a new game
- enter **'L'**  to load the previously saved game
- enter **'Q'**  to quit the program

During the game, after every guess, the user can
- enter **'N'**  to start a new round
- enter **'S'**  to save the game and quit
- enter **'Q'**  to quit the game without saving

A limitation with the save and load functionality is that the user cannot specify a filename or path.
The game is saved and loaded from a hardcoded file location, but I think it is in the spirit of the project to ignore that at this point in the course. 

I am happy with the current version and think it was a fun project to work on.

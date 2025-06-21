# tool-calling

Showcasing OpenAI's tool-calling using a tic-tac-toe game powered by an LLM.


## Instructions

Follow these instructions to run the LLM-powered `tic-tac-toe` game.

1. Pre-requisite: [Nushell](https://github.com/nushell/nushell)
2. Make an OpenAI API key available via environment variable
    * ```nushell
      $env.TIC_TAC_TOE_API_KEY = (input -s)
      ```
3. Overlay the game commands
    * ```nushell
      overlay use --prefix tic-tac-toe.nu as tic
      ```
4. Play the game!
    * Use natural language to describe where to place your 'X'. Ask the LLM to take their turn, and rejoice in the LLM
      either figuring things out OR in it making silly mistakes. For example.
    * ```nushell
      tic play "go in the middle middle"
      ```
    * ```nushell
      tic board
      ```
    * ```nushell
      tic play "your turn"
      ```
    * ```nushell
      tic play "remove X in top right"
      ```
    * ```nushell
      tic new-game
      ```


## Wish List

General clean-ups, TODOs and things I wish to implement for this project:

* [ ] Consider using a local LLM but using OpenAI-compatible APIs, like Ollama or LM Studio. I don't want to deal with an API key for this simple example.

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
* [ ] HOLD (I need more debuggability/auditing) More examples in the tic-tac-toe prompt. It's surprising how bad the LLM is at tic-tac-toe, mostly o4-mini,
  although even 4o is not great. I know that the table-styled Nushell output is probably confusing it, and I could
  strip it out, but I like this as a reminder about how fragile real world an integration is. Good example to try more
  examples (few shot). Let's see what happens. I want to explore some variations, but I'm really trying to make an
  eval (though interesting, I would want more scaffolding and design around that, though maybe simple is better). Update:
  wow, o1 is failing at this much more than I anticipated. I asked it to create some examples and in the second example
  it described "X wins in a quick diagonal" but then proceeded to place Xs in the left column and Os extending in a dowright
  diagonal and even asserting "X completes diagonal from (0, a) to (2, c)" but that path is literally X, O and O. I'm
  going to just drop the Nushell table-style and do raw characters (`X`, `O` and `-`). UPDATE 2: Wow, this isn't any better.
  gpt4o botched the game pretty badly. I think I need the many examples. Also I'm tempted to log the full history for
  debugging.

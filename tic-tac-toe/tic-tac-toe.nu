const DIR = (path self | path dirname)
const GAME_BOARD_FILE = [$DIR ".game-board.yml"] | path join | path expand
const REQUEST_RESPONSE_FILE = [$DIR ".request-response.jsonl"] | path join | path expand

# Let's write a tic-tac-toe game by using the 'tool/function calling' features of LLM APIs.
#
# We can have a thin kernel of code, and as much as possible, we can express the rules of the game and the officiating
# responsibilities to the LLM. This is of course a toy example, but I think it will help demonstrate what is possible
# with an LLM in the loop. In particular, how little code can we get away with? Similarly, it should show the faults
# and disadvantages of this approach like wrong answers, slowness, etc.
#
# The game will be played by the user ('X') and by the AI ('O'). One thing I don't totally get is how to do the looping...
# When the model wants to call a tool, what do I do with that? Call the tool with the args and then ship that back to
# the completions API as just another 'user' message? Or is it a 'tool' message or something? What happens if the LLM
# wants to call two functions in a row (e.g. it makes a move, and because it knows it's the winning move, it needs to
# invoke a "game end" function).
#
# This is the entry point of the game.
#
export def play [message?: string] {
    mut board = board-table

    let response = ask-llm $board $message

    let function = $response.choices.0.message.tool_calls.0.function
    let function_name = $function.name

    match $function_name {
        "ask_user" => {
           print "You're up! Describe your next move."
           return
        }
        "place_mark" => {
           let args = $function.arguments | from json
           let row_index = match $args.row {
               "top" => 0
               "middle" => 1
               "bottom" => 2
               _ => {
                 error make { msg: $"Unrecognized row argument: ($args.row)" }
               }
           }
           $board = ($board | update $row_index { |row| $row | update $args.column $args.mark })
           print ($board | render-board)
           $board | to yaml | save --force $GAME_BOARD_FILE
           return
        }
        "game_end" => {
           let args = $function.arguments | from json
           let winner = $args.winner

           let message = match $winner {
               "X" => "You win! 🎉"
               "O" => "I win! 🎉"
               "draw" => "It's a draw!"
               _ => {
                 error make { msg: $"Unrecognized winner argument: ($winner)" }
               }
           }

           print $message
           return
        }
        _ => {
           print $"Unrecognized function: ($function_name)"
           return
        }
    }
}

# Ask the LLM what tool to invoke next. We are delegating a maximum amount of responsibility to the LLM. To me, this is
# a form of inversion of control of a traditional program structure.
def ask-llm [board: table, message?: string]: nothing -> table {
   let user_content = if message == null {
       $"The board state is:(char newline)($board | render-board)(char newline)What's the next operation?"
   } else {
       $"The board state is:(char newline)($board | render-board)(char newline)The user player said '($message)'. What's the next operation?"
   }

   let system_prompt = [$DIR "system_prompt.txt"] | path join | path expand | open
   let tools = [$DIR "tools.yaml"] | path join | path expand | open

   let body = {
       model: "gpt-4o"
       messages: [{
           role: "system"
           content: $system_prompt
       }
       {
           role: "user"
           content: $user_content
       }]
       tools: $tools
    }

    # Log the request, execute the request, and log the response.
    $body | to json --raw | $in + (char newline) | save --append $REQUEST_RESPONSE_FILE
    let response = http post --content-type application/json --headers [Authorization $"Bearer ($env.TIC_TAC_TOE_API_KEY)"] https://api.openai.com/v1/chat/completions $body
    $response | to json --raw | $in + (char newline) | save --append $REQUEST_RESPONSE_FILE

    $response
}

export def new-game [] {
    let empty_board = [[left middle right]; [- - -] [- - -] [- - -]]
    $empty_board | to yaml | save --force $GAME_BOARD_FILE
}

def render-board []: table -> string {
    $in | to csv --separator (char space) --noheaders
}

export def board [] {
    board-table | render-board
}

def board-table [] : nothing -> table {
    if not ($GAME_BOARD_FILE | path exists) {
        new-game
    }

    $GAME_BOARD_FILE | open
}

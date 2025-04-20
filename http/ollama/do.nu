const DIR = path self | path dirname
const ORIGIN = "http://127.0.0.1:11434"

export def ask [] {
    let prompt = r#'
You have access to functions. If you decide to invoke any of the function(s),
you MUST put it in the format of
{"name": function name, "parameters": dictionary of argument name and its value}

You SHOULD NOT include any other text in the response if you call a function
[
  {
    "name": "get_product_name_by_PID",
    "description": "Finds the name of a product by its Product ID",
    "parameters": {
      "type": "object",
      "properties": {
        "PID": {
          "type": "string"
        }
      },
      "required": [
        "PID"
      ]
    }
  }
]
While browsing the product catalog, I came across a product that piqued my
interest. The product ID is 807ZPKBL9V. Can you help me find the name of this
product?
'#
    http post --content-type application/json ($ORIGIN + "/api/chat") {
        model: "gemma3:27b-it-qat"
        messages: [
          {
            role: user,
            content: $prompt
          }
        ],
        stream: false
    }
}

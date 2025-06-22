# openai-ts-sdk

OpenAI TypeScript SDK example: response streaming and proxy config.


## Overview

The OpenAI APIs, like the [chat completions API][chat-api], are well documented and have been implemented over and over again by proprietary LLM inference providers and open source client and server implementations.

It's easy to hand-roll your own client integration to these APIs, so long as you are only using a narrow set of features. When you want to get a little fancier, you might prefer to use a dedicated client library, like [OpenAI's official TypeScript SDK][openai-sdk]. In particular, I want to stream tokens back in the response and I don't want to write my own finicky server-sent-events (SSE) handling code. So, I'll use the SDK.

This subproject shows the familiar use case of streaming a response back, and separating the "thinking" tokens from the final response in the end-user experience. It also shows how to configure the SDK to use a proxy server, which is useful for debugging. I was particularly stumped about how to delimit the "thinking" tokens from the regular response. This reduced example and the proxy logs were helpful. 


## Instructions

Follow these instructions to run the example.

1. Pre-requisite: an OpenAI API-compatible HTTP server
   * I'm using LM Studio to serve a model.
2. Pre-requisite: run a proxy server
   * I'm running a proxy server on port 9052.
3. Install dependencies
   * ```shell
     npm install
     ```
4. Run the program
   * ```shell
     node index.ts
     ```
   * The response should look something like the following.
   * ```text
     $ node index.ts
     Thinking...
     
     Okay, the user asked for a simple anagram. Let me think about what they might want. An anagram is when you rearrange the letters of a word or phrase to form another, right? So maybe they want something straightforward.
     
     (... omitted ...)
     
     I should also make sure there are no repeated letters causing confusion. "Listen" has L, I, S, T, E, N. "Silent" is the same letters. Yes, that works. Alright, I'll present that as the example.
     Thinking complete.
     
     
     Sure! Here's a simple anagram:
     **"listen" → "silent"**
     
     Let me know if you'd like another! 😊
     ```


## Wish List

General clean-ups, TODOs and things I wish to implement for this project:

* [ ] Consider hand-rolling the SSE handling code. I keep waffling on this. But my current thinking is that this is an "llm-api-playground" so I should feature the API more directly, rather than using an SDK to abstract it away. Then, this subproject could be renamed something like "streaming". But maybe not because there is enough boilerplate in the OpenAI SDK that I want my own example.


[chat-api]: https://platform.openai.com/docs/api-reference/chat
[openai-sdk]: https://github.com/openai/openai-node/tree/master

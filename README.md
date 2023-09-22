# openai-playground

NOT YET IMPLEMENTED

📚 Learning and exploring OpenAI.

> OpenAI is an AI research and deployment company. Our mission is to ensure that artificial general intelligence
> benefits all of humanity.
>
> -- <cite> https://openai.com/about/ </cite>


## Overview

I want (need) to learn about today's disruptive AI concepts like *large language models* (LLMs). OpenAI provides the
practical documentation and APIs for me to do this. This repository captures my notes and runnable example code.

In the future, I'm excited to try open source models and other models from different vendors but right now, OpenAI is
the way to go.


## Glossary

This is a glossary of terms I'm learning about. When I'm in a new field and I can't keep up with the terms (they don't
stick in my memory), I need to organize them onto paper, rehearse them, and compare and contrast them.

*completion*: The text output of the GPT model after processing a prompt. This is an OpenAI term or is it broad?

*prompt*: The text input to the GPT model. This is a term used broadly in the space. 

*prefix prompt*: This is a normal prompt. The prompt comes before (hence "prefix") the completion. Contrast this with
a suffix prompt.

*suffix prompt*: This is a prompt that comes after the completion. This is useful if you want to get a completion that
bridges the gap between a leading thought and a trailing thought. Interesting. Would like to try it.

*token*: Words or chunks of characters. This is a unit of measure. It is used for measuring complexity and pricing.

*context length*: The model (is this even the right word?) can keep track of only so much context when it's doing its thing.
The maximum context length for most OpenAI models is 2048 tokens. (How does Copilot treat context? Doesn't it send the
whole file contents to the model? Is it an "embedding"?).

*model*: This is an instance of the thing (neural network?) trained on a data set. OpenAI has various GPT-3 models like Ada
and Davinci.

*GPT*: Generative Pre-trained Transformer.

*temperature*: (Interesting, but I'll skip for now.)


## Notes

I've gotten started using the API from Insomnia. Here is an example request to the *completions* endpoint:

```json
{
	"model": "text-davinci-003",
	"prompt": "Please describe the essence of travel in five distinct descriptions. Each description should be increasingly abstract from the previous to the point that the final description is abstract nonsense.",
	"temperature": 0,
	"max_tokens": 500
}
```

The response was:

```json
{
	"id": "cmpl-abc123",
	"object": "text_completion",
	"created": 1674322445,
	"model": "text-davinci-003",
	"choices": [
		{
			"text": "\n\n1. Moving from one place to another.\n2. Exploring new cultures and environments.\n3. Experiencing the unknown.\n4. Gaining insight into the world and oneself.\n5. Uncovering the mysteries of the universe.",
			"index": 0,
			"logprobs": null,
			"finish_reason": "stop"
		}
	],
	"usage": {
		"prompt_tokens": 31,
		"completion_tokens": 54,
		"total_tokens": 85
	}
}
```


## Wish List

General clean-ups, TODOs and things I wish to implement for this project:

* [ ] Can I fine-tune a model with my own content? I want to fine-tune the model with my own README content across all
  my repositories. Not really sure if that will be effective or if it takes a lot more metadata to make it work. It's
  probably not as easy as just feeding it the text? UPDATE: what I want is a "semantic search" product over my own data.
  I should be able to make that with embeddings? Also take care to note that you can use AI for semantic search but you
  don't need *generative* AI for the actual response (I think? We want to "classify" the query as one of a few Q&As...)
* [ ] Consider using the OpenAI CLI (a Python package). Using the API directly from Insomnia is always a good start but
  if I want to "if-this-then-that" then I need to reach for a program. UPDATE: LangChain is the way to go for if-this-then-that
  code beyond "hello world" examples, and LangChain has all sorts of well-thought out "chains" of AI-based automation.
* [ ] SKIP (I'm using the CodeGPT plugin) Intellij plugin. While the ChatGPT UI is overall excellent and I get lots of usage out of it, really want a chat
  experience lets me use much larger contexts than the ChatGPT UI. I've looked at open source options and some are quite
  good, but those are also implemented in a thick stack including Next.js, TypeScript, TailwindCSS, etc. These technologies
  are perfectly good, but I need something that I can hack on, and unfortunately I don't have enough time to maintain an
  understanding of these technologies and the exact codebase of one of these open source projects (at least, I can't do
  that without LLM superpowers). For me, I was thinking of doing htmx + Thymeleaf, but then I realized that I want an
  enhanced LLM chat experience exclusively for doing development work. And I know how to do an Intellij plugin. And
  Intellij has a file explorer which can act as "chat history" and Intellij is a code editor. And Intellij has syntax
  highlighting. What other features would I even need? It's perfect.


## Reference

* [OpenAI official API docs](https://beta.openai.com/docs/introduction)
  * Their website is polished and the content is well-edited. Read the docs.

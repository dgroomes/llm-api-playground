# openai-playground

NOT YET IMPLEMENTED

📚 Learning and exploring OpenAI.

> OpenAI is an AI research and deployment company. Our mission is to ensure that artificial general intelligence
> benefits all of humanity.
>
> -- <cite> https://openai.com/about/ </cite>


## Overview

I want (need) to learn about today's disruptive API concepts like *large language models* (LLMs). OpenAI provides the
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

*context length*: The model (is this even the right word?) can keep track of only so much context when its doing its thing.
The maximum context length for most OpenAI models is 2048 tokens. (How does Copilot treat context? Doesn't it send the
whole file contents to the model? Is it an "embedding"?).

*model*: This is an instance of thing (neural network?) trained on a data set. OpenAI has various GPT-3 models like Ada
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

General clean ups, TODOs and things I wish to implement for this project:

* [ ] Can I fine-tune a model with my own content? I want to fine-tune the model with my own README content across all
  my repositories. Not really sure if that will be effective or if it takes a lot more metadata to make it work. It's
  probably not as easy as just feeding it the text?
* [ ] Consider using the OpenAI CLI (a Python package). Using the API directly from Insomnia is always a good start but
  if I want to "if-this-then-that" then I need to reach for a program.


## Reference

* [OpenAI official API docs](https://beta.openai.com/docs/introduction)
  * Their website is polished and the content is well-edited. Read the docs.

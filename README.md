# llm-api-playground

📚 Learning and exploring LLM APIs like that of OpenAI and Anthropic.


## Overview

I need to continually learn how to leverage large language models (LLMs) for my applications, and the main interface to these models are via HTTP/JSON APIs.

This repository captures my notes and runnable example code for interacting with LLM APIs.


## Standalone subprojects

This repository illustrates different concepts, patterns and examples via standalone subprojects. Each subproject is
completely independent of the others and do not depend on the root project. This _standalone subproject constraint_
forces the subprojects to be complete and maximizes the reader's chances of successfully running, understanding, and
re-using the code.

The subprojects include:


### `tool-calling/`

Showcasing OpenAI's tool-calling using a tic-tac-toe game powered by an LLM.

See the README in [tool-calling/](tool-calling/).


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


## Wish List

General clean-ups, TODOs and things I wish to implement for this project:

* [ ] Anthropic example requests
* [ ] Prompt caching
* [ ] (TODO move this out of this sub-project because it isn't an llm-api focus) Fine-tune a small model over my own content. I'd like to at least do fine-turning once, for the sake of it. This has to happen in the cloud probably, but if I fine-tune a small model I can run inference locally. I want to fine-tune the model with my own README content across all my repositories. Now that I think about it, fine-tuning for small models is probably a good idea because the capability of local models is relatively low, so we want to juice them for a specific task. 
* [ ] (TODO move this out of this sub-project because it isn't an llm-api focus) "semantic search" product over my own data. I should be able to make that with embeddings? Also take care to note that you can use AI for semantic search, but you don't need *generative* AI for the actual response (I think? We want to "classify" the query as one of a few Q&As...)
* [ ] "programmatic" example. I'm particularly interested in the UX of streaming the tokens back as they are generated. I need a programmatic example for this.


## Reference

* [OpenAI official API docs](https://beta.openai.com/docs/introduction)
  * Their website is polished and the content is well-edited. Read the docs.

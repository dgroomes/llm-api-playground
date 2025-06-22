import OpenAI from 'openai';
import * as undici from 'undici';
import {styleText} from 'node:util';

const OPENAI_COMPATIBLE_ORIGIN = 'http://127.0.0.1:1234';
const PROXY_ORIGIN = 'http://localhost:9052';
const MODEL = 'qwen/qwen3-30b-a3b';

/**
 * Make a request to the OpenAI API and stream the response to the console.
 */
async function main() {
    const proxy = new undici.ProxyAgent({
        uri: PROXY_ORIGIN,
        proxyTunnel: false
    });

    const client = new OpenAI({
        apiKey: 'none',
        baseURL: OPENAI_COMPATIBLE_ORIGIN + '/v1',

        // @ts-ignore
        fetchOptions: {
            dispatcher: proxy,
        },
    });

    try {
        const stream = await client.chat.completions.create({
            model: MODEL,
            messages: [
                {
                    role: 'user',
                    content: "A simple anagram please."
                }
            ],
            stream: true,
            stream_options: {
                include_usage: true
            }
        });

        let isThinking = false;

        for await (const chunk of stream) {
            let content = chunk.choices[0]?.delta?.content;
            if (!content) {
                continue;
            }

            if (content === '<think>') {
                isThinking = true;
                console.log(styleText(['blue', 'bold'], 'Thinking...'));
                continue;
            } else if (content.includes('</think>')) {
                console.log(styleText(['blue', 'bold'], 'Thinking complete.'));
                isThinking = false;
                continue;
            }

            if (isThinking) {
                content = styleText('blue', content);
            }

            process.stdout.write(content);
        }
    } catch (error) {
        console.error('Error:', error);
    }
}

await main();

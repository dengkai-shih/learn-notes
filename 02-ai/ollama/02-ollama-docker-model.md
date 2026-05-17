## 1. pull model
## example : [gemma](https://ollama.com/library/gemma4)
```sh
# pull 'gemma'
docker exec -it ollama ollama pull gemma:7b
```
## 2. remove model
## example : [gemma](https://ollama.com/library/gemma4)
```sh
# pull 'gemma'
docker exec -it ollama ollama rm gemma:7b
```
## + reference +
[Linux用docker-compose部署Open WebUI + Ollama語言模型網頁界面](https://ivonblog.com/posts/ollama-llm-docker/)

[Ollama 官網](https://ollama.com/)

[Ollama GitHub](https://github.com/ollama/ollama)

[Ollama Model](https://ollama.com/search)

[Ollama Model huihui](https://ollama.com/huihui_ai)

[Ollama Model cwchang](https://ollama.com/cwchang)

## + ollama model +
## (tools)
### [![](img/gemma4.png "gemma model")](https://ollama.com/library/gemma4)
```sh
# "gemma model" Effective 2B (E2B) (7.2GB)
docker exec -it ollama ollama pull gemma4:e2b

# "gemma model" Effective 4B (E4B) (9.6GB)
docker exec -it ollama ollama pull gemma4:e4b
```

### ["huihui_ai/granite4.1-abliterated"](https://ollama.com/huihui_ai/granite4.1-abliterated)
```sh
# "huihui_ai/granite4.1-abliterated" 3 billion Parameter Count (2.1GB)
docker exec -it ollama ollama pull huihui_ai/granite4.1-abliterated:3b

# "huihui_ai/granite4.1-abliterated" 4 billion Parameter Count (5.3GB)
docker exec -it ollama ollama pull huihui_ai/granite4.1-abliterated:8b
```

### ["huihui_ai/gemma-4-abliterated"](https://ollama.com/huihui_ai/gemma-4-abliterated)
```sh
# "huihui_ai/gemma-4-abliterated" Effective 2B (E2B) (7.2GB)
docker exec -it ollama ollama pull huihui_ai/granite4.1-abliterated:3b

# "huihui_ai/gemma-4-abliterated" Effective 4B (E4B) (9.6GB)
docker exec -it ollama ollama pull huihui_ai/granite4.1-abliterated:8b
```

## (code)
### [![](img/meta.png "codellama model")](https://ollama.com/library/codellama)
```sh
# "codellama model" 7 billion Parameter Count (3.8GB)
docker exec -it ollama ollama pull codellama:7b
```

### [![](img/gemma.png "codegemma model")](https://ollama.com/library/codegemma)
```sh
# "codegemma model" 2 billion Parameter Count (1.6GB)
docker exec -it ollama ollama pull codegemma:2b

# "codegemma model" 7 billion Parameter Count (5.0GB)
docker exec -it ollama ollama pull codegemma:7b
```

## (translate)
### [![](img/translategemma.jpg "translategemma model")](https://ollama.com/library/translategemma)
```sh
# "translategemma model" 4 billion Parameter Count (3.3GB)
docker exec -it ollama ollama pull translategemma:4b

# "translategemma model" 12 billion Parameter Count (8.1GB)
docker exec -it ollama ollama pull translategemma:12b
```
#### Prompt Format
```prompt
You are a professional {SOURCE_LANG} ({SOURCE_CODE}) to {TARGET_LANG} ({TARGET_CODE}) translator. Your goal is to accurately convey the meaning and nuances of the original {SOURCE_LANG} text while adhering to {TARGET_LANG} grammar, vocabulary, and cultural sensitivities.
Produce only the {TARGET_LANG} translation, without any additional explanations or commentary. Please translate the following {SOURCE_LANG} text into {TARGET_LANG}:

{TEXT}
```
#### Ex. 1 English to Spanish
```prompt
You are a professional English (en) to Spanish (es) translator. Your goal is to accurately convey the meaning and nuances of the original English text while adhering to Spanish grammar, vocabulary, and cultural sensitivities.
Produce only the Spanish translation, without any additional explanations or commentary. Please translate the following English text into Spanish:

Hello, how are you?
```
#### Ex. 2 German to English
```prompt
You are a professional German (de) to English (en) translator. Your goal is to accurately convey the meaning and nuances of the original German text while adhering to English grammar, vocabulary, and cultural sensitivities.
Produce only the English translation, without any additional explanations or commentary. Please translate the following German text into English:

Guten Morgen, wie geht es Ihnen?
```
#### Ex. 3
```prompt
You are a professional Japanese (ja) to French (fr) translator. Your goal is to accurately convey the meaning and nuances of the original Japanese text while adhering to French grammar, vocabulary, and cultural sensitivities.
Produce only the French translation, without any additional explanations or commentary. Please translate the following Japanese text into French:

こんにちは、世界！
```
#### Ex. 4 Chinese to English
```prompt
You are a professional Chinese (zh-TW) to English (en) translator. Your goal is to accurately convey the meaning and nuances of the original Chinese text while adhering to English grammar, vocabulary, and cultural sensitivities.
Produce only the English translation, without any additional explanations or commentary. Please translate the following Chinese text into English:

你好世界
```

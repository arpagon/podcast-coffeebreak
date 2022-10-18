<a href="https://colab.research.google.com/github/arpagon/podcast-coffeebreak/blob/main/main.ipynb" target="_parent"><img src="https://colab.research.google.com/assets/colab-badge.svg" alt="Open In Colab"/></a>

# podcast-coffeebreak
Integrated analytics and stats search for Podcast: Coffee Break: Señal y Ruido

### Create conda env
```bash=
mamba env create python=3.10 -f environment.yml
```
### Activate conda env
```bash=
conda activate OpenAIWhisper
```

# TODO

- [ ] Transcript (https://github.com/openai/whisper)
- [ ] https://huggingface.co/pyannote/speaker-diarization
- [ ] use https://github.com/ytdl-org/youtube-dl/blob/5208ae92fc3e2916cdccae45c6b9a516be3d5796/youtube_dl/extractor/googlepodcasts.py
- [ ] use google drive in colab for fast bootstrapping
    - [ ] models
    - [ ] audios
    - [ ] transcipts


# Descrivtive statistics whiout transcribing

- podcast size
    - Bytes
    - Seconds
    - Episodes
- Histogram
    - Duración
# Descriptive statistics whit metadata

https://unix.stackexchange.com/questions/528302/how-can-i-download-just-the-info-json-files-using-youtube-dl-without-downloadin

# Descrivtive statistics cbinfo
```
curl ftp://ftp.iac.es/pub/pcoffeebreak/cbinfo.txt
```

- tumult
- temas

# Descrivtive statistics with transcrive

# Descrivtive statistics with speaker-diarization


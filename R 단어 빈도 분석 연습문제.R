# sjh

# speech_park.txt에는 박근혜 전 대통령의 대선 출마 선언문이 들어있습니다.
# Q1. speech_park.txt를 불러와 분석에 적합하게 전처리한 다음 띄어쓰기 기준으로 토큰화하세요.
raw_park <- readLines("speech_park.txt", encoding = "UTF-8")# 전처리
library(dplyr)
library(stringr)
park <- raw_park %>%
  str_replace_all("[^가-힣]", " ") %>% # 한글만 남기기
  str_squish() %>% # 연속된 공백 제거
  as_tibble() # tibble로 변환
park


# Q2. 가장 자주 사용된 단어 20개를 추출하세요.
# 토큰화
library(tidytext)
word_space <- park %>%
  unnest_tokens(input = value,
                output = word,
                token = "words")
word_space

top20 <- word_space %>%
  count(word, sort = T) %>%
  filter(str_count(word) > 1) %>%
  head(20)
top20

# Q3. 가장 자주 사용된 단어 20개의 빈도를 나타낸 막대 그래프를 만드세요. 
# •그래프의 폰트는 나눔고딕으로 설정하세요.
library(showtext)
font_add_google(name = "Nanum Gothic", family = "nanumgothic")
showtext_auto()
# 막대 그래프 만들기
library(ggplot2)
ggplot(top20, aes(x = reorder(word, n), y = n)) +
  geom_col() +
  coord_flip () +
  geom_text(aes(label = n), hjust = -0.3) +
  labs(x = NULL) +
  theme(text = element_text(family = "nanumgothic"))

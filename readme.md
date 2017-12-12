## 네이버웹툰 크롤링하기

#### Nokogiri 설정하기

```shell
$ gem install nokogiri
```

```ruby
require 'nokogiri'
```

다음 웹툰과 달리 html 문서로 응답이 오기 때문에 우리는 html을 파싱할 예정임



#### Naver Webtoon

이미지가 없거나 같은 클래스지만 링크가 없는 부분이 있기 때문에 예외처리를 해줘야한다.

```ruby
next if toon.css('div.lst > a').first.nil? or toon.css('.im_inbr > img').first.nil?
```

일부 웹툰이 출력되지 않을 수 있지만 해당 방법을 거치지 않으면 에러를 뿜뿜한다.  이미지 역시 마찬가지이다. 



###### Excercise

1. `def get_doc` 메소드를 만들어 중복되는 코드를 처리해보자.
2. `/`와 `/result` 모두 차이가 많이 없어보인다. 그렇다면 어떤 방식으로 구성했을 때 하나의 `url`로 두 요청을 모두 처리할 수 있을까?
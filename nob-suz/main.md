# Crystal言語の開発過程と コミュニテイの盛り上がりを振り返ってみて

[Crystal言語](http://crystal-lang.org/)開発の歴史は、2016年4月に開発元の[Manastech社](http://manas.com.ar/tools/)初めてのBlog、[The story behind #CrystalLang](http://manas.com.ar/blog/2016/04/01/the-story-behind-crystal.html)掲載により、詳細に明らかにされました。2011年6月Ary Borenszweigさんの考案で始まり、その後主としてJuan Wajnermanさん、Brian J. Cardiffさんが加わり、GitHubでのご存知のようなプロジェクトに発展しました。
以下に、このCrystal言語の開発と発展に貢献された開発関係者と、そして一緒に歩んだコミュニテイの素晴らしい成長発展の歴史を、すこし記録に残してみたいと思います。

まず2014年までの主要なターニングポイントを少し羅列し、近年2015年、2016年の足取りをまとめます。

## Crystalの沿革

### 2011年

6月
  ~ [Manastech社](http://manas.com.ar/tools/)のAryさんにより現在のアイデアのProof of ConceptとしてコンパイラはRubyで記述、**Ruby記述そっくりなのに実行速度が早い**、を目標とし検討が始まった。


### 2012年

9月
  ~ [GitHub初コミット](https://github.com/manastech/crystal/graphs/contributors)、 Manastech社の社内メンバーで立ち上げ、当初からオープンソース化。社内ツールで利用

### 2013年

11月
  ~ Rubyでのコンパイラ記述からCrystal言語で記述の[セルフホストが立ち上がった](http://crystal-lang.org/2013/11/14/good-bye-ruby-thursday.html)。

### 2014年

コンパイル時間がコード規模に対し指数的に増大する傾向のため、特に型推定を容易にするため一部明示的記述を導入。コンパイル速度は3万行のコンパイラ自身10秒で、かつリニアなコンパイル時間を実現した。

2月
  ~ Lynda_ppさん、[Vim-Crystal開発開始](https://github.com/rhysd/vim-crystal)

3月
  ~ [STL-Ruby（セントルイスRubyユーザG）](https://github.com/booch/presentations/tree/master/crystal)でTV遠隔プレゼンで[Aryさん自身が紹介](https://www.youtube.com/watch?v=8BdLttM26V0)

6月
  ~ Ver 0.1リリース

9月
  ~ [WISIT 2014で作者Ary/Wajさんが紹介](https://www.youtube.com/watch?v=XGJh6rNAYfs)
  ~ Kamil Lelonekさん[ベルリンRug:Byで紹介](http://www.slideshare.net/squixy/crystal-45694037)

10月
  ~ [Twitter #Crystallang](https://twitter.com/search?q=%23crystallang&src=typd)発足

12月
  ~ Rubyを尊敬しつつAnother Languageの道を行くクリスマス宣言

### 2015年

Ver 0.61リリース

1月
  ~ RubyHero2014のSfericさんが[Crystal言語を紹介](http://www.meetup.com/Strange-Group-Berlin/events/219492917/)

3月
  ~ 作者AryさんがMatzさんにCrystalドキュメント化でRubyと同じ文法のところのドキュメントをRubyから転載したいと申し出たところ、「OKです、私も昔 Perlから転載しました」
  ~ Jhassさん、[play.crystal-Lang.org](https://play.crystal-lang.org/#/cr) を公開。ここからWeb での簡単トライやデイスカッション(例、[IRC CHAT #crystal-lang](http://irclog.whitequark.org/crystal-lang)）で対象コードを共有しやすくなった。
  ~ ysbaddadenさん、[Crystalshards](https://crystalshards.herokuapp.com/)でGitライブラリ初公開（自動検索）登録はこの時点約50
  ~ Twitterで[\@shardscrystal](https://twitter.com/shardscrystal)も公開

4月
  ~ 作者のAryさんがAuto-Typeの可能性をエープリルフールとして発表
  ~ MatzさんのAryさんのエイプリルフリルジョークをTweet
  ~ ロシアのkostyaさん、[Crystal implementations for The Computer Language Benchmarks Game](https://github.com/kostya/crystal-benchmarks-game)を公開
  ~ Kostyaさん[Some benchmarks of different languages](https://github.com/kostya/benchmarks)も公開

5月
  ~ 言語仕様の[ドキュメント化](http://crystal-lang.org/docs/)が完成（従来よりソースコード内にMarkdownでコメントされるためリアルタイムで更新されていた）
  ~ Lynda_ppさん、[crystalでLisp(MAL)開発開始](http://rhysd.hatenablog.com/entry/2015/06/11/212141)
  ~ Stefan Willeさん、[高速 Redisクライアント公開とベンチマーク](http://www.stefanwille.com/2015/05/redis-clients-crystal-vs-ruby-vs-c-vs-go/)を公開

6月
  ~ veelengaさん、[AwesomeCrystal](http://awesome-crystal.com/)　開設
  ~ Matzさん、[Crystalを英語Tweet](https://twitter.com/matz_translated/status/610842797587976192)
  ~ [Hackernewsでブレイク！話題爆発](https://news.ycombinator.com/item?id=9669166)
  ~ Rosylillyさん、[日本での勉強会など立ち上げを提案](https://twitter.com/rosylilly/status/607543840052895744?ref_src=twsrc^tfw)、Pine613さんと立ち上げへ
  ~ Matzさん、Lynda_ppさんのCrystal製[ezoeコマンド](https://github.com/rhysd/ezoe)を日本語Tweet。[「Crystal　すげーっ。」](https://twitter.com/yukihiro_matz/status/610842781091672064)
  ~ トルコのsdogruyolさんSinatraライクな[kemal](http://serdardogruyol.com/kemal/)を開発開始

7月
  ~ Matzさん、MattnさんのCrystalベンチマークを日本語・[英語Tweet](https://twitter.com/matz_translated/status/611364736198967297)
  ~ PolyConfでRubyHero2014のSfericさんが[Crystal言語を紹介](https://www.youtube.com/watch?v=Ysm4IU4aWoQ)
  ~ CurryOn（旧RuPy Conference/）で作者のAry/Wajさんが[紹介](http://2015.ecoop.org/event/curryon-crystal-a-programming-language-for-humans-and-computers)
  ~ [Crystal-jp](http://crystal.connpass.com/)発足
  ~ [東京Crystal勉強会 第1回](http://crystal.connpass.com/event/17496/)
  ~ Rosylillyさん、[DocCrystal](http://docrystal.org/)と[power-assert](https://github.com/rosylilly/power_assert.cr/commits/master)を公開
  ~ [bountysource](https://salt.bountysource.com/teams/crystal-lang)での募金を開始

9月
  ~ Manas社外からベルリンのJhassさん（学生）、フランスのysbaddadenさんがコミッターとして参加
  ~ [Crystalshards](https://crystalshards.herokuapp.com/)に掲載されたライブラリの数が300を突破。半年で６倍に！

10月
  ~ 5t111111さんとpine613さんがCrystalの[日本語ドキュメント](http://ja.crystal-lang.org/docs/installation/index.html)・[日本語サイト](http://ja.crystal-lang.org/)を公開
  ~ Ver 0.9。Crystal-Formatを公開。shards内蔵
  ~ [東京Crystal勉強会](http://crystal.connpass.com/)の[第2回](https://codeiq.jp/magazine/2015/10/31516/)

11月
  ~ Aryさんご結婚
  ~ 新婚の忙しさにも新コンパイラ平行開発開始

12月
  ~ [Crystal Advent Calendar](http://www.adventar.org/calendars/800)開始！
  ~ [「20年目のRuby の真実」インタビュー](http://www.ipsj.or.jp/magazine/ruby.html)で笹田さん、Matz さんがCrystalに言及
  ~ [RubyKaigi2015 Tokyo](http://rubykaigi.org/2015)でHerokuのWillさんが[Crystal紹介](http://rubykaigi.org/2015/presentations/leinweber)^[<https://www.youtube.com/watch?v=7dwDzlVI7OU>にYoutubeのビデオがあります（英語）。]
  ~ 公式ブログに[Future of Crystal](http://crystal-lang.org/2015/12/24/the-future-of-crystal.html)を[Crystal Advent Calendar](http://www.adventar.org/calendars/800)に合わせて発表。
  ~ 5t111111さんがそれを[日本語翻訳](http://fiveteesixone.lackland.io/2015/12/28/the-future-of-crystal/)
  ~ [Hacker News](https://news.ycombinator.com/item?id=10803635) で プログラム言語の将来として議論のトリガーになった
  ~ ロシア Kostya さんから[プロダクションに採用して1か月ノートラブルで稼働している](https://groups.google.com/forum/?fromgroups#!topic/crystal-lang/fXTAMilSo_Q)、というクリスマスメッセージ！
  ~ Ver 0.10 がクリスマスリリース、新コンパイラ方向へ修正が入る
  ~ フランスのysbaddadenさんがRuby On RailsライクなフルスタックのWebフレームワーク[frost](https://github.com/ysbaddaden/frost)を開発者向けにクリスマスリリース

<!-- [GitHub](https://github.com/manastech/crystal) 4000star を突破した -->
<!-- [Crystalshards](https://crystalshards.herokuapp.com/) ライブラリ 450 を突破した -->
<!-- [Qiita でTag:Crystal 投稿が 80 を突破した](http://qiita.com/search?utf8=%E2%9C%93&q=tag%3Acrystal&sort=created) -->
<!-- [コントリビュータが110名を突破（日本から5名が連名) に拡大した](https://github.com/manastech/crystal/graphs/contributors) -->

### 2016年

## コミュニテイ拡大の背景

Rubyistから見た場合は、習熟のしやすさがGoやRustより容易です。Gitのアプリの立ち上がりを見ていると数コミットで動き出す例も多いです。Crystalに次ぐStar数を急上昇で獲得した、kemalの作者sdogruyolさんの[Why Crystal?](http://serdardogruyol.com/why-crystal)^[日本語訳は<http://fiveteesixone.lackland.io/2015/12/16/why-crystal/>]がそれを述べています。

Crystalは他の新言語と比べて、Rubyを明瞭にレスぺクトしているため、言語仕様の議論が出ても早く決定され、進化が早いです、コンパイラがCrystal自身で書かれセルフホストされていることも要因です。Rubyのテストドリブン文化を重視してRSpecサブセットがコンパイラに内蔵されている点も、安定な進化を強化しています。またライブラリやアプリの導入速度はRubyエコシステムからの流入速度が強く、その上にC/C++ライブラリーのバインデイングが容易であるため、C/C++エコシステムの導入速度も速いという、ダブル良循環が最も回ってる言語のひとつとなってきています。

# Crystal言語の開発過程とコミュニテイの盛り上がりを振り返ってみて

[Crystal言語](http://crystal-lang.org/)の開発の歴史は、2016年4月に開発元の[Manastech社](http://manas.com.ar/)のBlogで「[The story behind #CrystalLang](http://manas.com.ar/blog/2016/04/01/the-story-behind-crystal.html)」という記事が掲載されたことにより、詳細に明らかにされた。以下に、このCrystal言語の開発に貢献された関係者と、一緒に歩んだコミュニテイの素晴らしい成長の歴史を記録に残すものとする。

まず2014年までの主要なターニングポイントを少し羅列し、近年2015年、2016年の足取りをまとめる。

## Crystalの沿革

### 2011年

6月
  ~ Manastech社のaryさんによりProof of ConceptとしてコンパイラはRubyで書かれる。「Ruby記述そっくりなのに実行速度が早い」を目標とし検討が始まった。

### 2012年

9月
  ~ GitHubに初コミットされる。Manastech社の社内メンバーで立ち上げ、当初からオープンソースとして公開する。社内ツールとしての利用が始まった。

### 2013年

11月
  ~ セルフホスティング^[CrystalのコンパイラをCrystal自身で記述すること]が始まった。

### 2014年

コンパイル時間がコード規模に対し指数的に増大する傾向のため、特に型推定を容易にするため一部明示的記述を導入。コンパイル速度は3万行のコンパイラ自身10秒で、かつリニアなコンパイル時間を実現した。

2月
  ~ rhysdさんが[vim-crystal](https://github.com/rhysd/vim-crystal)の開発を始める。

3月
  ~ STLRubyでTV遠隔プレゼンで[Aryさん自身が初紹介](https://www.youtube.com/watch?v=8BdLttM26V0)した。

6月
  ~ バージョン0.1.0が公開された。これはCrystalの最初のリリースとなる。

9月
  ~ WISIT 2014で[AryさんとWajさんが紹介](https://www.youtube.com/watch?v=XGJh6rNAYfs)した。
  ~ Rug:Bで[Kamil Lelonekさんが紹介](http://www.slideshare.net/squixy/crystal-45694037)した。

10月
  ~ Twitterで`#crystallang`というタグが使われ始める。

12月
  ~ 「Rubyを尊敬しつつAnother Languageの道を行く」という宣言がクリスマスにされた。

### 2015年

1月
  ~ RubyHero2014で[Sfericさんが紹介](http://www.meetup.com/Strange-Group-Berlin/events/219492917/)した。
  ~ zamithさんがGitHubでホスティングされているCrystalプロジェクトをまとめる[Crystalshards](https://crystalshards.herokuapp.com/)を公開した。

3月
  ~ aryさんがMatzさんにCrystalとRubyで同じ文法のところのドキュメントを転載したいと申し出たところ「OKです、私も昔Perlから転載しました」と返事があった。
  ~ jhassさんがWeb上でCrystalのコードを実行可能する<play.crystal-Lang.org>を公開した。

4月
  ~ aryさんがAuto-Typeの可能性をエープリルフールジョークとして発信した。
  ~ Matzさんaryさんのジョークをリツイートした。
  ~ ロシアのkostyaさんがCrystal implementations for The Computer Language Benchmarks Gameを公開した。
  ~ kostyaさんがSome benchmarks of different languagesも公開した。

5月
  ~ 言語仕様の[ドキュメント化](http://crystal-lang.org/docs/)がされた。
  ~ rhysdさんが[CrystalでMake a Lispの開発を開始](http://rhysd.hatenablog.com/entry/2015/06/11/212141)した。
  ~ Stefan Willeさんが[高速 Redisクライアントとベンチマークを公開](http://www.stefanwille.com/2015/05/redis-clients-crystal-vs-ruby-vs-c-vs-go/)した。

6月
  ~ veelengaさんが[AwesomeCrystal](http://awesome-crystal.com/)を開設した。
  ~ Matzさんが[Crystalを英語のツイートで言及](https://twitter.com/matz_translated/status/610842797587976192)し、これによって[Hackernewsでブレイク](https://news.ycombinator.com/item?id=9669166)した。
  ~ rosylillyさんが[日本での勉強会などを提案](https://twitter.com/rosylilly/status/607543840052895744)し、Pine613さんと立ち上げた。
  ~ MatzさんがrhysdさんのCrystal製の[ezoeコマンド](https://github.com/rhysd/ezoe)を[日本語でツイート](https://twitter.com/yukihiro_matz/status/610842781091672064)する。
  ~ トルコのsdogruyolさんがSinatra ライクなWebフレームワークの[kemal](http://serdardogruyol.com/kemal/)の開発を開始する。

7月
  ~ MatzさんがmattnさんのCrystalベンチマークを日本語と[英語でツイート](https://twitter.com/matz_translated/status/611364736198967297)する。
  ~ PolyConfでRubyHero2014のSfericさんが[Crystal言語を紹介](https://www.youtube.com/watch?v=Ysm4IU4aWoQ)した。
  ~ CurryOnで[AryさんとWaj さんが紹介](http://2015.ecoop.org/event/curryon-crystal-a-programming-language-for-humans-and-computers)した。
  ~ [crystal-jp](http://crystal.connpass.com/)が発足する。
  ~ [東京Crystal勉強会](http://crystal.connpass.com/)の第1回が開催された。
  ~ rosylillyさんがCrystalのドキュメントホスティングサービスである<docrystal.org>を公開した。
  ~ [bountysource](https://salt.bountysource.com/teams/crystal-lang)での募金が開始された。

9月
  ~ Manas社外からベルリンのjhassさんとフランスのysbaddadenさんがコミッターになる。
  ~ GitHubでホスティングされているCrystalのプロジェクト数が300を突破する。

10月
  ~ 5t111111さんやpine613さんがCrystalのドキュメントや公式サイトを[日本語に翻訳](http://ja.crystal-lang.org)して公開した。
  ~ バージョン0.9.0がリリースされた。コードを整形する機能が追加され、パッケージマネージャの[shards](https://github.com/crystal-lang/shards)が内蔵された。
  ~ 東京Crystal勉強会の第2回が開催された。

11月
  ~ aryさんがご結婚されました。
  ~ 新婚の忙しさにもかかわらず新コンパイラの開発を開始する。

12月
  ~ [Crystal Advent Calendar 2015](http://www.adventar.org/calendars/800)が始まった。
  ~ [「20年目のRuby の真実」インタビュー](http://www.ipsj.or.jp/magazine/ruby.html)で笹田さん、MatzさんがCrystalに言及。
  ~ [RubyKaigi2015 Tokyo](http://rubykaigi.org/2015)でHerokuのWillさんが[Crystalの紹介](http://rubykaigi.org/2015/presentations/leinweber)をした 。
  ~ [Future of Crystal](http://crystal-lang.org/2015/12/24/the-future-of-crystal.html)^[5t111111さんによる日本語翻訳はこちら。<http://fiveteesixone.lackland.io/2015/12/28/the-future-of-crystal/>]がCrystal Advent Calendar 2015に合わせて公開される。
  ~ kostyaさんから「[プロダクションに採用して1か月ノートラブルで稼働している](https://groups.google.com/forum/?fromgroups#!topic/crystal-lang/fXTAMilSo_Q)」というクリスマスメッセージがあった。
  ~ バージョン0.10.0がクリスマスにリリース。新コンパイラへと修正が入り始めた。
  ~ ysbaddadenさんがRuby On RailsライクなフルスタックのWebフレームワークの[frost](https://github.com/ysbaddaden/frost)をクリスマスにリリースした。

2015年を数字でまとめると以下が参考になる。

  - GitHubのプロジェクトのスター数が4000
  - コントリビュータが110名（日本からは5名が連名）
  - GitHubにホスティングされているCrystalのプロジェクト数が450
  - QiitaでのCrystalタグの付けらた投稿が80

### 2016年

1月
  ~ バージョン0.11.0がリリースされた。Fiberの切り替えをインラインアセンブラで書き直し、パフォーマンス改善がされた。
  ~ Jruby9KやTruffle、Graalの開発者のChris Seatonさんが[Comparing Performance of Crystal 0.11.1 with other Languages](http://stefan-marr.de/downloads/crystal.html)という記事でCrystalとJruby9K等とのベンチマークをし、結果を公開した。　
　
2月
  ~ バージョン0.12.0がリリースされた。
  ~ 東京Crystal勉強会の第3回が開催された。
  ~ 5t111111さんがCodeIQで自身の発表と様子をレポートした。
  ~ The Changelogにaryさんとwajさんが招待されトークを行った。
  ~ sdogruyolさんがProgGunlenでkemalの紹介をした。
  ~ アルゼンチンで初のCrystal Meetupが開催された。

3月
  ~ バージョン0.13.0、0.14.0がリリースされた。playgroundが梱包され、変数のタイプがどう推定されているか追跡できるようになった。
  ~ YouTubeでCrystallanguage Hangout質疑をユーザとAry さんが会話。
  ~ sdogruyolさんがViennaRBでKemalを紹介した。
  ~ pine613さんが歌舞伎座Tech「異種プログラミング言語格闘勉強会」でCrystalを紹介した。
  ~ vagmiさんがRubyConf India 2016で紹介した。

4月
  ~ aryさんが恒例のエイプリルフールジョークを発表した。英語よりエスペラント語の方が厳格なので、今後Crystalの予約語などはエスペラント語になるとのことだった。
  ~ Ruby Argentina User GroupでCrystal Meetupが始めて開催された。
  ~ バージョン0.15.0がリリースされた。

5月
  ~ アルゼンチンで2回目のCrystal Meetupが開催され、オンライン中継された。
  ~ バージョン0.16.0、0.17.0がリリースされた。コンパイル速度改善のための布石としてグローバル変数やインスタンス変数に対する新たな型推論の方式が導入された。
  ~ sidekiqの作者であるMike PerhamさんがRubyからCrystalへsidekiqの基本機能を移植した。その後、3週間でほぼ全機能を移植する。
  ~ 他にも、ブラジルのRuby伝道師AkitaOnRailsさんがMangaReader DownloaderをRubyから移植して公開した。

6月
  ~ バージョン0.18.0がリリースされた。

2016年6月時点を数字でまとめると以下が参考となる。

  - GitHubのプロジェクトのスター数が5120
  - GitHubでホスティングされているCrystalのプロジェクト数が450
  - QiitaでのCrystalタグの付けらた投稿が107
  - [A list of programming languages that are actively developed on GitHub](https://github.com/showcases/programming-languages)でCrystalは13番目に位置している。

## GitHub からみた Crystal言語のStar 数 Top3 集計ランキングは 35位。
プログラミング言語が今何が好まれているか? やトレンドを見るのに [TIOBE Index](http://www.tiobe.com/tiobe_index) は参考になり、また [The RedMonk Programming Language Rankings:](http://sogrady-media.redmonk.com/sogrady/files/2016/02/lang-rank-944px-wm.png)も、参考になる。

 [Crystal言語](http://crystal-lang.org/)が、実際どんなポジションに位置するのか、示す。

最近のプログラミング言語は、オープンソースが好まれたり、GitHub でプログラム言語の開発自体を進めたり、ライブラリやアプリケーションをコミュニテイで共有して時代や技術の進歩に対応していく動きが活発である。

GitHub の動向を見るのに namaristats.com の [Top3 Repos](http://namaristats.com/top3s) は貴重な情報となっている。
しかし、このページは、ランキングの変化でソートされておらず、近況が見ずらい状況のままである。

そこで、今回　GitHub での人気度を示す。[Top3 Repos](http://namaristats.com/top3s)　をStar の総数集計でソートした。

[Top3 Repos](http://namaristats.com/top3s)　のStar 総数は、GitHub 利用の人気近況を表していると考えて、ランキングした。Top3 の総数で、アプリやライブラリーの利用人気も反映している。
## 以下　ランキングまとめと傾向を示す。
Tiobe や Redmonk とずいぶん違う点がある。
Star 数では、言語が提案され長く使われているほうが多くなる傾向は出てしまい、一方で近況を表す、コミュニテイの共鳴度合いも早く反映される。
Tiobe や Redmonk よりむしろ実情を表しているように感じられる。

・Go 言語がすでに Python より上位に表れている。

・Ruby系統言語（Ruby Coffeescript Elixir Groovy）が結構上位に来ている。

・TypeScript は意外と上位の印象。

・Scala, Swift, Rust が同列で競っている*。

・Elixir は Lua と同列まで追いついている。

・Julia, Crystal が R, Mirah, D, Haxe, OPAL を超え、Erlang, Dart, Groovy と同列に上がっている。

・D, C#, F#, Perl6, Dart は意外と低い。

などが特徴です

＊Swift オープンソースコンパイラは C++ で記述されているため、これに Star すると Swift ではなく、c++ に加点される。これを加味して Swift 加点を修正すると、Swift Top3 は+20000となり Java, Go に肉薄する。こちらのほうが実情を表していると感じられる。

# GitHub Top3 Star 総数ランキング（Updated : 2016-05-29）

1	JavaScript　228000

2	CSS	　　　　153000

3	C++	　　　　89000

4	Ruby　　　　86000

5	HTML　　　　85000

6	Shell　　　 65000

7	Go　　　　　64700

8	Pytho　　　 64600

9	C　　　　　 64000

10	Java	　　63000

11	CoffeeScript 59600

＊   Swift を 59000　カウントとするとこの位置となる。

12	Objective-C　53700

13	PHP	　　　48100

14	VimL　　　44600

15	TypeScript 38800

16	Swift	　　39000 (59000: Swift Compiler StarをSwiftへ加味する場合）

17	Scala　　 28000

18	Rust	　　25600

19	Objective-C++	23600

20	Clojure　 22300

21	C#　　　　21800

22	Lua　　 　19600

23	Elixir	　17200

24	Haskell 　17100

25	OCaml 　　15600

26	TeX	　　　15300

27	PowerShell 14700

28	Perl	　　14100

29	Emacs Lisp 13000

30	Erlang　　10300

31	Julia	　　8800

32	Assembly	8000

33	Groovy　　7000

34	Dart	　　6800

35	Crystal　 6080

36	R　　　　 5900

37	Objective-J	5600

38	Vala	　　5550

39	XSLT　　　5100

40	ActionScript 4600

41	Matlab　　4300

42	Scheme　	4280

43	Kotlin　　4250

44	Haxe　　　3800

45	Elm	　　　3700

46	Nimrod　　3550

47	LiveScript 3350

48	Cuda　　　3150

49	Common Lisp	2870

50	D　　　　 2700

# コミュニテイ拡大の背景
Rubyist から見た場合は、習熟のしやすさが Go や Rust より容易です。Gitのアプリの立ち上がりを見ていると数コミットで動き出す例も多い。Crystal に次ぐStar数を急上昇で獲得した、Sinatraライクな[kemal](http://serdardogruyol.com/kemal/)の作者 sdogruyolさんの ”Why Crystal?"（[日本語訳](http://fiveteesixone.lackland.io/2015/12/16/why-crystal/)）がそれを述べている。

[Crystal](http://crystal-lang.org/)は他の新言語と比べて、Rubyを明瞭にレスぺクトしているため、言語仕様の議論が出ても早く決定され、進化が早い。コンパイラがCrystal自身で書かれセルフホストされていることも要因となっている。Rubyのテストドリブン文化を重視してRSpecサブセットがコンパイラに内蔵されている点も、安定な進化を強化している。またライブラリやアプリの導入速度はRuby エコシステムからの流入速度が強く、その上にC/C++ライブラリーのバインデイングが容易であるため、C/C++エコシステムの導入速度も速いという、ダブル良循環が最も回ってる言語のひとつとなってきていることが見える。

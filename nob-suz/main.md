# Crystal言語の開発過程と コミュニテイの盛り上がりを振り返ってみて

[Crystal言語](http://crystal-lang.org/) 開発の歴史は、2016 年４月に開発元の [Manastech社](http://manas.com.ar/tools/)初めての Blog [The story behind #CrystalLang](http://manas.com.ar/blog/2016/04/01/the-story-behind-crystal.html) 掲載により、詳細に明らかにされた。 2011 年6 月 Ary Borenszweig さんの考案で始まり、その後主として Juan Wajnerman さん、 Brian J. Cardiff さんが加わり、GitHub でのご存知のようなプロジェクトに発展した。
以下に 、この Crystal言語の開発と発展に貢献された開発関係者と、そして一緒に歩んだコミュニテイの素晴らしい成長発展の歴史を、記録に残すものとする。

まず 2014年 までの主要なターニングポイントを少し羅列し、近年2015年、2016年の足取りをまとめる。
## Crystalの沿革

### 2０１１年

6月　[Manastech社](http://manas.com.ar/tools/) Ary さんにより現在のアイデアの Proof of Concept として コンパイラはRubyで記述、”Ruby記述そっくりなのに実行速度が早い”、を目標とし検討が始まった。

### ２０１２年

９月　[GitHub 初コミット](https://github.com/manastech/crystal/graphs/contributors)、 Manastech社の社内メンバーで立ち上げ、当初からオープンソース化、社内ツールで利用が始まった。

### ２０１３年
11月　Rubyでのコンパイラ記述からCrystal言語で記述の[セルフホストが立ち上がった](http://crystal-lang.org/2013/11/14/good-bye-ruby-thursday.html)。

### ２０１４年
コンパイル時間が、コード規模に対し、指数的に増大する傾向のため、特に型推定を容易にするため一部明示的記述を導入、コンパイル速度は3万行のコンパイラ自身10秒で、かつリニアなコンパイル時間を実現した。
２月　Lynda_ppさん　[Vim-Crystal 開発を開始](https://github.com/rhysd/vim-crystal)。

３月　[STL-Ruby（セントルイス RubyユーザG）](https://github.com/booch/presentations/tree/master/crystal)でTV遠隔プレゼンで[Aryさん自身が紹介](https://www.youtube.com/watch?v=8BdLttM26V0)。

６月　Ver 0.1 リリース

９月　[WISIT 2014 で作者Ary/Wajさんが紹介] (https://www.youtube.com/watch?v=XGJh6rNAYfs)

　　　Kamil Lelonek さん　[ベルリン Rug:Byで紹介](http://www.slideshare.net/squixy/crystal-45694037)

10月　[Twitter #Crystallang](https://twitter.com/search?q=%23crystallang&src=typd)　発足した。

12月　Rubyを尊敬しつつAnother Languageの道を行くクリスマス宣言がされた。

### ２０１５年
１月　Ver 0.61　リリース。

　　RubyHero2014の Sfericさんが [Crystal言語を紹介](http://www.meetup.com/Strange-Group-Berlin/events/219492917/)。

３月　作者 Aryさんが MatzさんにCrystalドキュメント化でRubyと同じ文法のところのドキュメントを Rubyから転載したいと申し出たところ、"OKです、私も昔 Perlから転載しました"と返事があった。

　　　Jhassさん　[Play.crystal-Lang.org](https://play.crystal-lang.org/#/cr) を公開、ここからWeb での簡単トライやデイスカッション(例 [IRC CHAT #crystal-lang]
(http://irclog.whitequark.org/crystal-lang)）で対象コードを共有しやすくなった。

　　　ysbaddadenさん　[Crystalshards](https://crystalshards.herokuapp.com/)　でGitライブラリ初公開（自動検索）登録はこの時点約 50であった。
　　　
　　　[Twitter:@Crystalshards](https://twitter.com/shardscrystal) も公開。

４月　作者 Aryさんが Auto-Typeの可能性をエープリルフールで Jokeを発信。

　　　Matzさん AryさんのジョークをTweet。
　　　
　　　ロシアのkostyaさん　[Crystal implementations for The Computer Language Benchmarks Game](https://github.com/kostya/crystal-benchmarks-game)を公開。
　　　
　　　Kostya さん　[Some benchmarks of different languages](https://github.com/kostya/benchmarks) も公開。

５月　言語仕様の[ドキュメント化](http://crystal-lang.org/docs/)が完成（従来よりソースコード内にMarkdownでコメントされるためリアルタイムで更新されていた）。

　　　Lynda_ppさん　[crystalでLisp(MAL)開発開始](http://rhysd.hatenablog.com/entry/2015/06/11/212141)。
　　　
　　　Stefan Willeさん　[高速 Redisクライアントとベンチマーク公開](http://www.stefanwille.com/2015/05/redis-clients-crystal-vs-ruby-vs-c-vs-go/)。

６月　veelengaさん　[AwesomeCrystal](http://awesome-crystal.com/)　開設。

　　　Matzさん　[Crystal を英語Tweet](https://twitter.com/matz_translated/status/610842797587976192) 、これで [Hackernews でブレイクが起き、話題爆発](https://news.ycombinator.com/item?id=9669166)が始まった。
　　　
　　　Rosylillyさん　[日本での勉強会など立ち上げを提案](https://twitter.com/rosylilly/status/607543840052895744?ref_src=twsrc^tfw)、Pine613さんと立ち上げへ進めた。
　　　
　　　Matzさん　Lynda_ppさんのCrystal製[ezoeコマンド](https://github.com/rhysd/ezoe)を日本語Tweet、内容は　[”Crystal　すげーっ。”](https://twitter.com/yukihiro_matz/status/610842781091672064)。
　　　
　　　トルコのsdogruyolさん Sinatra ライクな[kemal](http://serdardogruyol.com/kemal/) 開発開始。

７月　Matzさん　Mattnさんの Crystalベンチマークを日本語と,[英語で Tweet](https://twitter.com/matz_translated/status/611364736198967297)。

　　　PolyConfで RubyHero2014の Sfericさんが [Crystal言語を紹介](https://www.youtube.com/watch?v=Ysm4IU4aWoQ)。
　　　
　　　CurryOn (旧RuPy Conference) で作者Ary/Waj さんが[紹介](http://2015.ecoop.org/event/curryon-crystal-a-programming-language-for-humans-and-computers)。
　　　
　　　[Crystal-jp](http://crystal.connpass.com/)発足。
　　　
　　　[東京Crystal勉強会 第1回](http://crystal.connpass.com/event/174)。
　　　
　　　Rosylillyさん　[DocCrystal](http://docrystal.org/)、 [Power-assert](https://github.com/rosylilly/power_assert.cr/commits/master) 公開。
　　　
　　　[bountysource](https://salt.bountysource.com/teams/crystal-lang) の募金が開始された。

９月　Manas社外からベルリンのJhassさん（学生）、フランスのysbaddadenさん
　　　　コミッターへ参加。
　　　　
　　　[Crystalshards](https://crystalshards.herokuapp.com/)　ライブラリ　300　突破、半年で６倍

10月　5t111111さん pine613さん Crystal　[日本語ドキュメント公開](http://ja.crystal-lang.org/docs/installation/index.html)　[日本語サイト公開](http://ja.crystal-lang.org/)

　　　Ver 0.9　Crystal-Format　公開、shardsが内蔵された。
　　　
　　　[東京Crystal勉強会](http://crystal.connpass.com/)の[第2回]が開催された。

11月　Ary さんがご結婚。

　　　新婚の忙しさにもかかわらず、新コンパイラを平行開発開始。

12月　[Crystal Advent Calendar (JP)](http://www.adventar.org/calendars/800)チャレンジ開催された。

　　　[「20年目のRuby の真実」インタビュー](http://www.ipsj.or.jp/magazine/ruby.html)で笹田さん、Matz さんが　Crystal に言及。
　　　
　　　[RubyKaigi2015 Tokyo](http://rubykaigi.org/2015)で Heroku の Will さんが  [Crystal紹介](http://rubykaigi.org/2015/presentations/leinweber) 。
　　　
　　　[作者　Future of Crystal Blog](http://crystal-lang.org/2015/12/24/the-future-of-crystal.html) を[Crystal Advent Calendar (JP)](http://www.adventar.org/calendars/800)に合わせて発表。
　　　
　　　[5t111111さん日本語翻訳](http://fiveteesixone.lackland.io/2015/12/28/the-future-of-crystal/)
　　　[Hacker News](https://news.ycombinator.com/item?id=10803635) で プログラム言語の将来として議論のトリガーになった。
　　　
　　　ロシア Kostya さんから[プロダクションに採用して1か月ノートラブルで稼働している](https://groups.google.com/forum/?fromgroups#!topic/crystal-lang/fXTAMilSo_Q)、
　　　　　というクリスマスメッセージがあった。
　　　　　
　　　Ver 0.10 がクリスマスリリース　新コンパイラ方向へ修正が入り始めた。
　　　
　　　フランスの ysbaddaden さんがフルスペックの Ruby On Rails ライク [frost](https://github.com/ysbaddaden/frost) を
　　　　　開発者向けクリスマスリリース公開。

# ２０１５年を数字でまとめると以下が参考になる。
## [GitHub](https://github.com/manastech/crystal) 4000star を突破した。
## [Crystalshards](https://crystalshards.herokuapp.com/) ライブラリ 450 を突破した。
## [Qiita でTag:Crystal 投稿が 80 を突破した](http://qiita.com/search?utf8=%E2%9C%93&q=tag%3Acrystal&sort=created)。
## [コントリビュータが110名を突破（日本から5名が連名) に拡大した](https://github.com/manastech/crystal/graphs/contributors)。

### ２０１６年
１月　Ver 0.11 リリース　fiber context switch が inline assembly で実装されパフォーマンス改善がされた。

　　　Blog: Comparing Performance of Crystal 0.11.1 with other Languages で Jruby9K/Truffle/Graal 開発者の Chris Seaton さんが Crystal 言語をJruby9K とベンチマークし公表。　
　
２月　Ver 0.12 リリース

　　　「東京Crystal勉強会」第3回を実施。
　　　
　　　若杉（@5t111111）さんが CodeIQ で自身の発表と様子をレポート。
　　　
　　　Matz さんが「東京Crystal勉強会」の様子をリツイート。
　　　
　　　Matz さんが　Ruby extention in Crystal のCrystal_Ruby を Tweet。
　　　
　　　Rainforestqa 社がCrystal 言語プログラムをプロダクションユース発表。
　　　
　　　The Changelog にAry さん、Waj さん招待され Talk を行った
　　　
　　　Serdar Dogruyol @sdogruyol さんが イスタンブール ProgGunlen でKemal 紹介。
　　　
　　　アルゼンチンで初のCrystal Meetup が開催された。

３月　Ver 0.13 Ver 0.14 リリース　built-in playground が梱包された。Playground で変数のタイプがどう推定されているかトレースできるようになった。

　　　YouTube で Crystallanguage Hangout 質疑をユーザとAry さんが会話。
　　　
　　　Serdar Dogruyol @sdogruyol さんが ViennaRB でKemal を紹介。
　　　
　　　@Pine613 さんが歌舞伎座 Tech 「異種プログラミング言語格闘勉強会」で紹介。
　　　
　　　@Vagmi さんが RubyConf India 2016 で紹介。

４月　Ary さんが恒例の AprilFool Joke を発表、英語よりEsperanto語が厳格で、今後 Crystal 言語はEsperanto 対応するとのことであった。

　　　Ruby Argentina User Group でCrystal Meetup を初開催。
　　　
　　　Ver 0.15 リリース

５月　アルゼンチンで2回目の Crystal Meetup が開催され、オンライン中継された。

　　　Ver 0.16 Ver 0.17 リリース　The new global type inference algorithm が実装された。現時点ではコンパイル速度は大きく変化していないが、将来の高速コンパイラ実現とREPL実装への布石がされた。型宣言が一部記述が必要になることに対する議論はあったが、結果を見ると型推定が準形式的になることで、プログラム言語全体がロバストになり、2015 年にbug 指摘やenhance 要望がペンデイングされていた案件がスムーズに解決され、織り込まれた。また新規バグ指摘に対する発見と修正の速度が速くなった。さらに言語仕様がより準形式的に見えることで、新たな言語仕様拡張強化検討が飛躍的に早まった。

　　　Sidekicq の作者 Mike Perham さんがSidekicq.cr の基本を取り組み開始から5日で実装公開したことで Crystal 言語の注目が高まった。その後 3週間でほぼ全機能を移植公開。Rubyist の適応容易性を示す事例となっている。

　　　この影響の一つとしてブラジルの Ruby 伝道師 AkitaOnRails さんが Crystal - MangaReader Downloader を Ruby版から移植公開、さらに Blog：Flirting with Crystal, a Rubyist Perspective で "Crystal has Node.js/Javascript-like Event Loop in the form of a Fiber Scheduler and a Go-like Channel/CSP mechanism" と示して実装トライを提示、Crystal 言語の有用性を示した。

６月　Matz さんが、その Blog をリツイート。

　　　Ver.0.18 リリース、 言語仕様拡張は Python, Swift など他言語の良い点は積極的に取り込む方向と、その早い対応が示された。

　　　Matz さんの 昨年の Crystal 言語関係リツイートはブームを引き起こしたが、きしくも、その1 年後の今回リツイートと Mike Perham さんの Sidekicq.cr 発表の相乗効果で Ver. 0.18 の発表の反応は、かつてない広がりを見せており、Crystal 言語の開発とコミュニテイの広がりが新たな段階へと移行したことを示した。

# ２０１６年６月時点を数字でまとめると以下となる。
## [GitHub](https://github.com/manastech/crystal) 5210star。
## [Crystalshards](https://crystalshards.herokuapp.com/) ライブラリ 819。
## [Qiita でTag:Crystal 投稿が 107 ](http://qiita.com/search?utf8=%E2%9C%93&q=tag%3Acrystal&sort=created)。
## [A list of programming languages that are actively developed on GitHub](https://github.com/showcases/programming-languages) で Crystal は Swift, Go を含めても 13番目にランクされている。
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




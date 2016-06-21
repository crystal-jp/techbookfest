# Rubyとは似て非なるCrystal

ドーモ、ミナサン。"熊髭"AKJデス。

普段は職場内のシステムやネットワークのお守りを生業にしています。コードを書くことが本業ではありませんが、ここ数年、各種ログの解析やそれを元にしたアラート発報など、自分が使うためだけのツール類をRubyを使って書き散らかしています。そんな感じですので、何か大規模な開発プロジェクトに携わった経験があるわけではないのですが、それでもある程度のコードサイズになってくるとRubyのこれでもかという柔軟性を私自身が持て余してしまう場面に遭遇するようになりました。

すでにみなさんご存知のことと思いますが、Crystalの構文はRubyから強く影響を受けています。実際CrystalとRubyの構文上の類似性は、単純なものであればCrystalのコンパイラでもRubyのインタプリタでもエラーなく実行可能なコードを書けるほどで、例えば下記の「ズンドコキヨシコード」[^zndk]などはCrystal 0.18系でもRuby 2.3系でも問題なく動作します。

[^zndk]:「ズン」「ドコ」のいずれかをランダムで出力し続け、「ズン」「ズン」「ズン」「ズン」「ドコ」のパターンが出たら「キ・ヨ・シ！」と出力した後で終了する。【参照】<https://twitter.com/kumiromilk/status/707437861881180160>

```crystal
zd = 0
until (zd == 30)
  puts (zd = ((zd << 1) + rand(2)) & 31).odd? ? "ズン" : "ドコ"
end
puts "キ・ヨ・シ!!"
```

こうした面では、Rubyによるプログラミング経験があるとCrystalは比較的とっつきやすい言語だと言えますが、Ruby用に書かれたコードがいつもそのままCrystalで動作するとは限りません。というよりむしろ、Ruby用に書かれたコードのままではうまく動かない場合がほとんどです。Crystalの主要な開発メンバーの一人である[Ary Borenszweig](https://github.com/asterite)さんも「CrystalはRubyの文法や構文を取り入れてはいるが、Rubyそのものではない」といった趣旨の発言をされていますが[^notrb]、CrystalはRubyとは異なるポリシーのもと開発されている一個の完全に独立したプログラミング言語です。

[^notrb]: "Crystal borrows Ruby's syntax and some of its semantics, but it's not Ruby. Just like C++ borrows C syntax and some of its semantics, but it's not C."【参照】<https://groups.google.com/d/msg/crystal-lang/raH5z8GqdJ8/NzDkreGtCAAJ>

そのため、Ruby経験者がCrystalに手を出した当初は、なまじRubyの知識があるがゆえにRubyの常識が通用しなくて戸惑う場面に遭遇しがちです。

そこでこの章では、数値や文字列といった基本的なオブジェクトを中心に、Ruby経験者が躓きがちなポイントや「こんなことできるんだ」と驚いたポイントをピックアップして、ザックリ紹介してみることにします。

## 型（type）

CrystalがRubyと異なるもっとも大きな2つの特徴のうちの1つが、静的な型システムを持っていることです（もう1つはインタプリタ型ではなくコンパイル型言語であること）。ですので、Crystalの変数やメソッドの引数、返り値などは型の情報持っていて、メソッドに引数の型が指定されているのに、その型以外のオブジェクトを渡すとエラーになります。

```crystal
# 姓名を受け取ってイニシャルを返す
def initial(namef : String, namel : String) : String
  "#{namef[0].upcase}.#{namel[0].upcase}."
end

p initial("john", "doe")
# => "J.D."

p initial(1, 2)
# => Error: no overload matches 'initial' with types Int32, Int32
```

とはいえ、いちいちすべての変数やメソッドの引数、返り値に型を指定してやる必要はありません。Crystalのコンパイラには型推論の機能があり、変数に与えられた初期値や、プログラム中でメソッドに引数として与えられたオブジェクトの型、メソッドが返すオブジェクトの型などから、コンパイラ自身がそれらの型を推定してくれます。

```crystal
# 変数初期化時の型推論

a = "abc"
p typeof(a)
# => String
# 文字列リテラルで初期化されたからこれはString型

b = a.upcase
typeof(b)
# => String
# String#upcaseの返り値はString型だからこれもString型
```

```crystal
# メソッド返り値の型推論
def foo(obj)
  obj.to_s
end

p typeof(foo(123))
# => String
# fooメソッドは必ずString型の値を返すからこれもString型
```

### ユニオン型（union type）

さて、では状況によって`String`型のオブジェクトか`Symbol`型のオブジェクトを返す可能性があるメソッドの返り値の型はどうなるのでしょう。次の例のように、`String`型か`Symbol`型のどちらかであるという状態の変数を、Crystalコンパイラは`String`型と`Symbol`型のユニオン型（`(String | Symbol)`）だと解釈します。

```crystal
# シンボルが:stringだったら文字列に変換して、
# そうでなければそのまま返す
def bar(s : Symbol)
  s == :string ? s.to_s : s
end

c = bar(:string)
p typeof(c)
# => (String | Symbol)
```

上記のコードだけを考えれば、実行時の変数`c`の値は必ず`String`型になります。しかし、メソッド`bar`は`String`型と`Symbol`型のどちらの値も返す可能性がありますので、コンパイラは変数`c`を`(String | Symbol)`型だと認識します。このように、実行時に変数の値となっているオブジェクトの型と、コンパイラが認識している変数のコンパイル時の型が異なる点には注意が必要です。なぜなら、コンパイラにユニオン型だと認識されている変数は、その時の変数の値がどの型のオブジェクトであるかにかかわらず、ユニオン型に含まれるすべての型が共通して持つメソッドしか使用できないのです。

```crystal
# 先ほどの続き

# #not_nil!はString型にもSymbol型にもあるので使用可
p c.not_nil!
# => "string"

# #upcaseはString型にしかないのでエラー
p c.upcase
# => Error: undefined method 'upcase' for Symbol (compile-time type is (String | Symbol))
```

ユニオン型だとコンパイラに認識されている変数を、その時の値の型として使用したい場合には何らかの手段でコンパイラに対して型を特定してやる必要があります。方法はいろいろありますが、例えば`if`文の条件として`#is_a?`メソッドで値の型を判定すると、その`if`文の中では変数の型を特定することができます。

```crystal
# if文の内側はString型の場合しか到達しない
if c.is_a?(String)
  p c.upcase
  # => "STRING"
end
```

Rubyなどで良く見かける「ある条件を満たしていれば値を返し、そうでなければ`nil`を返す」メソッドなどはCrystalでは返り値の型が、条件達成時に返される値の型と`Nil`型のユニオン型になります。（ある型と`Nil`型のユニオン型は、特別にその型の名前に`?`を加えた型名で表現することができます。例：`String?`、`Symbol?`）

### メソッドのオーバーロード

Rubyではメソッドの引数に型を指定できません。同じメソッド名で異なる引数のパターンを処理できるようにするには、変数にデフォルト値を設定して省略可能にしたり、メソッド内で型チェックを行って処理を分岐させる必要があります。Crystalでも同じような処理は可能ですが、そのほかにCrystalでは引数の型を指定できるようになった恩恵として、メソッドのオーバーロードが可能になっています。つまり、同じメソッド名であっても受け取る引数のパターンごとに異なる処理を記述することができるのです。

```ruby
# 整数値か16進数の文字列を2倍にして値を返す(Ruby)

def dbl(value)
  value = value.to_i(16) if value.is_a?(String)
  value * 2
end

dbl(2)
# => 4
dbl("a")
# => 20
```

```crystal
# 整数値か16進数の文字列を2倍にして返す(Crystal)

# 引数が整数型の場合の処理
def dbl(value : Int)
  value * 2
end

# 引数が文字列型の場合の処理
def dbl(value : String)
  dbl(value.to_i(16))
end

dbl(2)
# => 4
dbl("a")
# => 20
```

この程度の処理であればRuby方式でもそれほど面倒ではありませんが、型チェック後の処理のボリュームが増えてくると、結局Rubyでも引数の型ごとの処理をprivateメソッドに切り出してオーバーロードっぽい動きをさせることになったりします。言語仕様としてオーバーロードが可能なことで、便利な場面はたくさんあるのではないでしょうか。

### ジェネリクス（generics）

配列やハッシュのようなコレクションや、`Box`や`Pointer`といったラッパなど、様々な型のオブジェクトに対して共通の処理を行う汎用の型を定義する際には、ジェネリクスという仕組みを利用できます。ジェネリクスを使用する型は型名に`()`で仮の型引数を指定する形で定義し、使用する際に型引数に具体的な内部で使用する型を指定します。

```crystal
class Container(T)
  def initialize(value : T)
    @value = value
    end
end

c = Container(String).new("string")
```

また、型引数は型定義の中で型制約や型注釈に通常の型と同じように使用することができます。先ほどの`Container`型は`#initialize`の引数を`T`型に制限していますので、型引数に`String`を使用した場合の`Container(String)#initialize`は引数として`String`型のオブジェクトしか許容しません。

```crystal
c = Container(String).new(1)
# => Error: no overload matches 'Container(String).new' with type Int32
```

ジェネリクス定義の型引数名としては英字1文字だけの定数を指定しますが、オプションとして数字を1文字追加することが可能です。また、型引数の名前は慣例的に`T`がよく使用され、複数必要であれば`U`、`V`と続きますが、既存の型名と重複していなければどの文字でも使用できます。（例：`Hash(K,V)`）

```crystal
# OK
class Container2(T1)
end

# NG（アルファベットは1文字だけ）
class Container3(TT)
end

# NG（数字は1桁だけ）
class Container4(T10)
end
```

なお、ジェネリクスを利用した型は、実行時には型引数に指定された型の種類ごとに厳密には異なる型として扱われます。ですので、型引数付きで型制約を行った場合、ほかの型引数を使用しているオブジェクトは許容されません。型引数をつけない形で型制約を行った場合は、型引数に関わりなく引数に与えることができます。

```crystal
sc = Container(Symbol).new(:symbol)

# Container(String) と Container(Symbol) は別物
def string_container(c : Container(String))
  c
end

p string_container(sc)
# => Error: no overload matches 'string_container' with type Container(Symbol)

# 型引数なしで型制約すれば型引数に関係なく呼べる
def any_container(c : Container)
  c
end

p any_container(sc)
# => #<Container(Symbol):0x10aa76fd0 @value=:symbol>
```

### クラスと構造体

Rubyの構造体は、`Struct.new`で`Struct`クラスのサブクラスを生成し、基本的にプロパティ値へのアクセス機能のみが提供されました。一方、Crystalの構造体は、`class`の代わりに`struct`を使ってクラスと同じように定義し、その型独自のメソッドなどを追加することができます。

```crystal
# こっちはクラス
class SomeClass
  def initialize(@i : Int32)
  end

  def i=(new_i : Int32)
    @i = new_i
  end
end

# こっちは構造体
struct SomeStruct
  def initialize(@i : Int32)
  end

  def i=(new_i : Int32)
    @i = new_i
  end
end
```

では、クラスと構造体とでは何が違ってくるかというと、まず、定義した型の継承ツリーが違います。クラスが`Reference`型を先祖にもつのに対し、構造体は`Struct`を継承しており、最終的にその親である`Value`型を先祖にもちます（型定義で継承元の型を明示しなかった場合には、`Reference`や`Struct`が暗黙的な親になります）。

* `Object`
    * `Reference`
        * `class`で定義した諸々
    * `Value`
        * `Struct`
            * `struct`で定義した諸々

継承ツリーが分かれているら、というわけでもないのでしょうが、構造体を継承したクラスなどは定義できませんので注意が必要です。また、構造体は`abstract struct`（次項参照）以外の型を継承することができず、「構造体を継承した構造体」すら定義できません。結果として、Crystalでは既存の構造体を継承で拡張する手段がないようです。

```crystal
# 構造体を継承したクラスは作れない
class OtherClass < SomeStruct
end
# => Error: can't make class 'OtherClass' inherit struct 'SomeStruct'

# 構造体で継承させようとしてもダメ
struct OtherStruct < SomeStruct
end
# => Error: can't extend non-abstract struct SomeStruct
```

次に、インスタンス変数などの値を格納するメモリ領域が異なります。クラスはヒープ領域上にメモリを確保しますが、構造体はスタック領域を使用します。

そして最後が、メソッドの引数として渡す際、クラスが参照渡しなのに対して、構造体は値渡しになることです。つまり、構造体をメソッドの引数に指定した場合、メソッドに渡されるのはそのコピーであり、元の構造体そのものではありません。

`Value`を継承していてスタック領域にメモリが割り当てられる点と、メソッドへ値渡しになるという特徴から、構造体はイミュータブルな（不変の、内部状態を変更できない）オブジェクトか、他の型のオブジェクトに対するステートレスなラッパオブジェクトに用いるのが良いとされています[^struct]。

[^struct]: "Structs inherit from Value so they are allocated on the stack and passed by value. For this reason you should prefer using structs for immutable data types and/or stateless wrappers of other types."【参照】<http://crystal-lang.org/api/Struct.html>

一応、ミュータブルな（内部状態を変更可能な）構造体を定義すること自体は可能です。ただし、そうしたオブジェクトを引数としてメソッドに渡し、メソッド内で引数オブジェクトの状態を更新しても、元のオブジェクトに変更が反映されない場合がありますので注意が必要です。メソッド内で引数として渡された構造体の状態を更新し、メソッドの外にその更新内容を反映させたい場合は、メソッドから更新後のオブジェクトを返すようにして、元の変数に再代入するようにしてください。

```crystal
# 引数の状態を更新するだけ
def i1(s)
  s.i = 1
end

# 更新後の値を返す
def i2(s)
  s.i = 2
  s
end

# クラスの場合
some_class = SomeClass.new(0)

# メソッド内の更新が反映される
i1(some_class)
p some_class
# => #<SomeClass:0x10f52dfd0 @i=1>

# 構造体の場合
some_struct = SomeStruct.new(0)

# メソッド内の更新は反映されない（@iは0のまま）
i1(some_struct)
p some_struct
# => SomeStruct(@i=0)

# 更新後の値を再代入
some_struct = i2(some_struct)
p some_struct
# => SomeStruct(@i=2)
```

### 抽象型（abstract type）、抽象メソッド（abstract method）

複数の型に共通のインタフェースを持った継承元の型を継承ツリー上に定義はしたいけれど、その継承元の型自身は直接インスタンスを持たせたくないといった場合、Crystalでは抽象型（`abstract class`、`abstract struct`）を定義することができます。

```crystal
# 抽象型（クラス）の定義
abstract class A
end

# 抽象型はインスタンス化できない
a = A.new
# => Error: can't instantiate abstract class A

# 抽象型でない型に継承すればOK
class B < A
end

p B.new.is_a?(A)
# => true
```

また、抽象型やモジュールには、抽象メソッドを定義することができます。抽象メソッドは実装を持っておらず`abstract def`構文でメソッド名と引数だけを宣言したもので、継承先の（モジュールの場合はmix-inした）型で実際の機能が実装されることを要求するものです。Javaをご存知の方であればInterfaceにおける抽象メソッドと同じような働きをすると考えてもらば良いでしょう。

抽象型でない型が、抽象メソッドを持つ型やモジュールを継承/mix−inした際、未実装の抽象メソッドが残っているとエラーが発生します。この時、抽象メソッドの定義と、実装したメソッドで引数のパターン（数や型制約）が異なっていると、実装したメソッドはオーバーライドされた別ものと見なされ、抽象メソッド自体は未定義のままになってしまうので注意が必要です。一方、引数のパターンさえ合致していれば、返り値の型が抽象メソッドの定義と異なっていてもエラーは発生しません。抽象メソッド定義時の返り値の型注釈が実装に強制力を持たない点も、これはこれで意識しておく必要がある挙動です。

```crystal
abstract class A
  # 抽象メソッドaを定義
  abstract def a

  # 抽象メソッドbに、引数を型まで指定して定義
  abstract def b(bb : Int32)

  # 抽象メソッドcに、引数を型制約なしで定義
  abstract def c(cc)

  # 抽象メソッドdに、返り値の型を指定して定義
  abstract def d : String
end

class B < A
  # 引数の型が違うと、結果的に#b(bb : Int32)が
  # 未定義の状態になってしまう
  def b(bb : String)
    bb.size
  end
  # => Error: abstract `def A#b(bb : Int32)` must be implemented by B

  # 抽象メソッドの引数が型制約なしであれば、
  # 実装時に型制約がかかっていてもエラーにはならない
  def c(cc : Int32)
    cc + 1
  end

  # 返り値の型が違ってもエラーにはならない
  def d
    1
  end
end
# => Error: abstract `def A#a()` must be implemented by B
#    メソッドaが未定義のままである
```

### インスタンス変数、クラス変数の型

バージョン0.16.0から、インスタンス変数とクラス変数は型定義内でコンパイラが型を特定できないとエラーが発生するようになりました。この挙動に対する一番明確な対応は、型定義の中でインスタンス変数の型を明示することです。また、Rubyの`attr_*`に相当する`getter`、`setter`、`property`マクロに型注釈つけたり、`#initialize`で引数を直接インスタンス変数で受ける際に型制約をつけることでもインスタンス変数の型を明示することができます。

```crystal
class A
  # @a は String型
  @a : String

  def initialize(@a)
    # 余談：Crystalではメソッド引数を
    #      直接インスタンス変数に代入できます。便利!!
  end
end

class B
  # getterがアクセスするインスタンス変数@bはString型
  getter b : String

  def initialize(@b)
  end
end

class C
  # C.newの第一引数はString型限定だから@cはString型
  def initialize(@c : Sring)
  end
end
```

こうした形で型が明示されなかったとしても、Crystalコンパイラは`#initialize`内でインスタンス変数が初期化される際に様々な方法でインスタンス変数の型を特定しようとします。そうした型推論を行っても最終的に型を特定できなかったインスタンス変数があると、コンパイルエラーが発生します。

```crystal
class A
  def initialize(@a)
  end
end

a = A.new("a")
# => Can't infer the type of instance variable '@a' of A
```

実は0.16.0より前のバージョンでは、こうした指定がなくてもその都度実行時に与えられる値の型からインスタンス変数などの型を推定してくれていました。コードを書くという点では便利な仕様だったのですが、この仕様だとライブラリで提供される`A`型を使用する場合に、あるプログラムで呼び出した場合と別のプログラムで呼び出した場合とで`A`型に含まれるインスタンス変数の型が変化する、という状況が発生してしまいます。このことは、`A`型の構造が実際に呼び出されるまで確定できない、ということを意味しますので、コンパイルの度に読み込まれるすべてのライブラリをコンパイルし直す必要があります。プログラムの規模が大きくなってくるとこれはかなり効率の悪い方式です。

Crystalの開発チームは将来インクリメンタルコンパイル（コードに変更があった部分だけをコンパイル対象とすることで、トータルのコンパイル時間を短縮する手法）の仕組みをCrystalに実装する計画を持っており、0.16.0におけるこの仕様変更もその実装を見据えたものであると公表されています[^inccmp]。

[^inccmp]: "The reason of this change is to allow, in the future, implementing incremental compilation and improving overall compile times and memory usage."【参照】<http://crystal-lang.org/2016/05/05/crystal-0.16.0-released.html>

#### インスタンス変数に対する型推論

* リテラルで初期化した場合

    ```crystal
    @a = "a"
    ```

    文字列リテラルで初期化したんだから`@a`は`String`型。

* `.new`メソッドで初期化した場合

    ```crystal
    @a = Time.new(2016, 6, 25)
    ```

    `Time`オブジェクトを生成したのだから`@a`は`Time`型。

* コンパイラが返り値の型を知ってるメソッドで初期化した場合

    ```crystal
    @a = Time.now
    ```

    `Time.now`は`Time`オブジェクト返すから`@a`は`Time`型。

* 型制約つきの`#initialize`の引数で初期化した場合

    ```crystal
    def initialize(a : String)
      @a = a
    end
    ```

    引数`a`は`String`型だから`@a`も`String`型。

* デフォルト値が指定されている`#initialize`の引数で初期化した場合

    ```crystal
    def initialize(a = "a")
      @a = a
    end
    ```

    引数`a`は`String`型のデフォルト値を持っているから`@a`も`String`型。

* 型を明示した上で未初期化である事を明示した場合

    ```crystal
    @a = uninitialized String
    ```

    `String`型だけど未初期化状態であることを明示。

    プリミティブでない型の場合`@a`を初期化前に利用するとエラーになります。公式ドキュメントの「[安全でないコード](http://crystal-lang.org/docs/syntax_and_semantics/unsafe.html)」の例にも挙がっていますので使用の際は注意が必要です。

* コンパイラが返り値の型を知っているCライブラリ関数で初期化した場合

    ```crystal
    # 注: まったくもって実用的なコードではありません
    @a = LibC.gai_strerror(1)
    ```

    `LibC.gai_strerror`の返り値は`LibC::Char`型のポインタなので`@a`は`Pointer(UInt8)`型。

* 特定の型のポインタで指定するCライブラリ関数の引数に`out`パラメータ付きで指定して初期化した場合

    ```crystal
    # 注: まったくもって実用的なコードではありません
    #     要 require "big_int"
    LibGMP.init(out @a)
    ```

    `LibGMP.init`の第一引数は`LibGMP::MPZ`型のポインタなので`@a`は`LibGMP::MPZ`型。

## 数値

### 数値を表す型が多い（特に整数）

Rubyでは`Fixnum`と`Bignum`の2種類の整数型がありますが、Crystalでは`Fixnum`に相当する固定長整数型だけで`Int8`、`Int16`、`Int32`、`Int64`、`UInt8`、`UInt16`、`UInt32`、`UInt64`の8種類が存在します。これらのうち型名が`Int`で始まっているものは符号つき（負の値も扱える）整数型、`UInt`で始まっているものは符号なし（0以上の値のみを扱う）整数型であることを表し、その後ろの数字で内部データのサイズ（ビット数）を表しています。さらに、`Bignum`に相当する多倍長整数型として`BigInt`が用意されています。

浮動小数点型にもRubyの`Float`に対して、固定精度の`Float32`、`Float64`があり、任意精度演算が可能な`BigDecimal`に対して`BigFloat`が用意されています。

また、有理数については、Rubyの`Rational`に相当する`BigRational`があります。

なお、複素数を扱う型として、Rubyと同じ名前の`Complex`がCrystalにも存在しますが、Rubyと違い他の数値型とは継承ツリーを別にしています。

#### Ruby の数値型継承ツリー

* `Numeric`
    * `BigDecimal`（要require）
    * `Complex`
    * `Float`
    * `Integer`
        * `Fixnum`
        * `Bignum`
    * `Rational`

#### Crystal の数値型継承ツリー

* `Number`
    * `BigRational`（要require）
    * `Float`
        * `BigFloat`（要require）
        * `Float32`
        * `Float64`
    * `Int`
        * `BigInt`（要require）
        * `Int8`
        * `Int16`
        * `Int32`
        * `Int64`
        * `UInt8`
        * `UInt16`
        * `UInt32`
        * `UInt64`
* `Complex`（要require）

### 整数が桁あふれする

```crystal
p 2000000000 + 2000000000
# Ruby    => 4000000000
# Crystal => -294967296
```

Rubyでは仮に整数値が`Fixnum`の範囲を超えたとしても`Bignum`へ自動変換されるため、整数値の桁あふれを気にする場面はほぼありません。一方、Crystalの固定長整数型はそれぞれに扱える値の範囲が決まっており（Nビット長の整数型の場合、符号つきでは`-(2^(N-1))`から`2^(N-1)-1`まで、符号なしでは`0`から`2^N-1`まで）、Rubyのように扱える値の範囲を超えた際に自動的に大きな型に変換してくれたりはしません。

そのため、数値の加算などで、計算結果がレシーバ（`+`などを演算子的に使用する場合は左辺の値）の型の範囲をはみ出してしまうと、桁あふれ（オーバーフロー）が発生します。先ほどの計算結果が負の値になってしまったのも計算結果が`Int32`型の最大値を超えてオバーフローしたのが原因です。C言語などをカジったことがある方にとっては馴染みのある話ではありますが、なぜ結果かマイナスになってしまったのかよくわからない方は、Wikipediaの「[整数型](https://ja.wikipedia.org/wiki/整数型)」や「[符号付数値表現](https://ja.wikipedia.org/wiki/符号付数値表現)」などを読んでみられると良いのではないでしょうか。

なお、各固定長の整数型には`MAX`/`MIN`という名前のクラス定数が用意されていて、それぞれの型で扱える値の最大値/最小値を取得できます。扱う値の範囲を把握し、必要なサイズの整数型を使用するようにしましょう。

```crystal
p Int32::MAX
# =>  2147483647

p Int32::MIN
# => -2147483648
```

### `String#to_i`がエラーになる

```crystal
p "3000000000".to_i
# Ruby    => 3000000000
# Crystal => invalid Int32: 3000000000 (ArgumentError)
```

`String`型など整数値以外の型を整数に変換する`#to_i`メソッドは、標準で`Int32`型の値を返します。そのため`Int32`型の範囲を超えるような値を表現する文字列を`#to_i`で変換しようとすると不正な値としてエラーが発生します。

ただ、この動作に関してはエラーを返してくれる`String`はまだ親切な方で、`Float64#to_i`などは値が`Int32::MAX`より大きかった場合などでもエラーを出さず、シレッとオーバーフローした数値を返してきます。結果として「エラーは出ないけれど何故か結果がおかしい」というバグ潰しにおいて非常にやっかいな状況に陥る可能性がありますのでご注意ください。

```crystal
f = 2147483648.0 # Int32::MAX + 1
p f.to_i
# => -2147483648
```

Crystalでは、`#to_i`を持つ型であればたいていの場合、各整数型へ変換するための個別のメソッド、`#to_i8`、`#to_i16`、`#to_i32`、`#to_i64`、`#to_u8`、`#to_u16`、`#to_u32`、`#to_u64`が用意されていますので、適切な変換メソッドを使用するようにしましょう。

ちなみに、浮動小数点型は標準で`Float64`型になり、`#to_f`も`Float64`型を返します。また、整数型の場合と同様に型を明示して変換する`#to_f32`、`#to_f64`が用意されています。

### 整数リテラルで指定した値の型が変わる

```crystal
p typeof(0)
# => Int32

p typeof(2147483648)
# => Int64

p typeof(9223372036854775808)
# => UInt64
```

先ほど「固定長整数オブジェクトはお互いに自動変換はされない」と説明しましたが、整数リテラルは値が大きくなると、その値を扱える型が自動的に選択されます。（ただし、`UInt64::MAX`を超えても`BigInt`にはならない）

そのため、メソッド引数に特定の整数型を指定していると、リテラルの値によってエラーになる場合があります。

```crystal
def dbl(i : Int32)
  i * 2
end

p dbl(1000000000)
# => 2000000000

p dbl(3000000000)
# => Error in: no overload matches 'dbl' with type Int64
```

Crystalにはすべての固定長整数型を含むユニオン型`Int::Primitive`や、すべての符号つき固定長整数型（`Int8`、`Int16`、`Int32`、`Int64`）を含む`Int::Signed`、すべての符号なし固定長整数型（`UInt8`、`UInt16`、`UInt32`、`UInt64`）を含む`Int::Unsigned`が用意されています。また、`BigInt`を含む整数型はすべて`Int`を継承してるので、メソッドの型制約などではそちらを使うこともできます。

```crystal
def dbl(i : Int)
  i * 2
end

p dbl(1000000000)
# => 2000000000

p dbl(3000000000)
# => 6000000000
```

## 文字列

### シングルクォート（`'`）で囲んだリテラルは`Char`型

```crystal
p "string"
# => "string"

p 'string'
# => Syntax error: unterminated char literal, use double quotes for strings
```

Crystalには、文字列を扱う`String`型に加えて単一文字を扱う`Char`型が用意されており、ダブルクォート（`"`）で囲んだ文字は`String`リテラル、シングルクォート（`'`）で囲んだ文字は`Char`リテラルになります。そのため、`'`で複数文字を囲んだ記述をすると上記のようなエラーが発生します。

ちなみに、`Char`型はASCII文字ではなくユニコードの単一コードポイントを表します。そのため、C言語の`char`型とは違いCrystalの`Char`型はデータサイズが32ビット長になっています。

### 内部はUTF-8エンコーディング

初期にはマルチバイト文字としてUTF-8エンコーディングしか利用できなかったCrystalですが、0.12.0からマルチエンコーディングがサポートされるようになりました。ただし、Rubyのマルチエンコーディング実装がCSI（Code Set Independent）方式なのに対して、CrystalはどうやらUTF-8によるUCS（Universal Character Set）Normalization方式を採用しているようです。つまり、Rubyの`String`オブジェクトはそれ自信が文字列のエンコーディング情報を持ち、オブジェクト内部にはそのエンコーディングのままバイト列を保持しているのに対し、Crystalの場合は`String`オブジェクトはあくまでUTF-8エンコーディングのバイト列だけを保持する作りになっており、別エンコーディングの文字列を扱う際には入出力時に必要なエンコーディングへ変換するような動きをします。

例えば、`sjis.txt`と言うファイルにShift_JISでエンコードされた`日本語`というテキストが保存されているとしましょう。このとき、Rubyでその内容を文字列に取り込んで、`String#bytes`を実行するとShift_JISエンコーディングのバイト列が得られます。

```crystal
# Rubyの場合
sjis = File.open("sjis.txt", "r:Shift_JIS").read
p sjis.bytes
# => [147, 250, 150, 123, 140, 234]
```

一方、同じフィアルをCrystalで読み込んで同じようにバイト列を取得すると、得られるのはUTF-8エンコーディングでのバイト列になります。

```crystal
# Crystalの場合
sjis = File.read("sjis.txt", "Shift_JIS")
p sjis.bytes
# => [230, 151, 165, 230, 156, 172, 232, 170, 158]
```

もし、CrystalでShift_JISコードのバイト列が必要な場合は、`String#encode`メソッドを使用する必要があります。この時、返り値が`Array(UInt8)`型ではなく`Slice(UInt8)`型なので注意してください。

```crystal
sjis = File.read("sjis.txt", "Shift_JIS")
p sjis.encode("Shift_JIS")
# => Slice[147, 250, 150, 123, 140, 234]
```

Crystalでも入出力の際に`IO`側へエンコーディングを指定しておけばそちらでコード変換を行ってくるため、`String`オブジェクトの内部データがクリティカルに影響する場面は少ないでしょうが、意識の隅に置いておくと良いかもしれません。

### 任意のバイト列を保持できない

Rubyでは、任意のバイト列を`String`に保持して扱う場合があります（`IPAddr.new_ntoh`など）。Rubyには`String`でバイナリデータを扱うエンコーディング`ASCII-8BIT`が用意されており、`ASCII-8BIT`エンコーディングの文字列にはどのようなバイト列を与えてもエラーになりません。

しかし、内部データを必ずUTF-8で保持するCrystalの`String`オブジェクトには、ユニコード的に不正なバイト列を与えるとエラーになります。このようにバイナリデータをバイト列として扱う場合、Crystalでは一般的に`Slice(UInt8)`を利用します。例えば、`IO.read`や`IO.write`は`Slice(UInt8)`を使ってデータの入出力を行います。また、`String`と`Slice(UInt8)`は、`String.new(slice : Slice(UInt8))`や`String#to_slice`などで相互変換することが可能です（もちろん、UTF-8的に正しければ、ですが）。

なお、バージョン0.18.0でそのものズバリ`Bytes`という型が追加されましたが、これは`Slice(UInt8)`の別名として定義されています。

## シンボル

### 動的にシンボルを生成できない

CrystalでもRubyと同様にシンボル型（`Symbol`）が存在します。ハッシュキーなど利用シーンもほぼRubyのものと変わりませんが、1つだけ、文字列から動的に`Symbol`オブジェクトを生成できない、という違いがあります。

Crystalではコンパイル時に各シンボルにユニークな番号（`Int32`型）を割り振って、プログラム中での取り扱いを整数処理に置き換えてしまう[^symbol]ため、Rubyのように`String#intern`でコンパイル後に新しいシンボルを追加することはできません。

[^symbol]: "You can't dynamically create symbols. When you compile your program, each symbol gets assigned a unique number."【参照】<http://crystal-lang.org/api/Symbol.html>

```crystal
p symbol = "symbol".intern
# Ruby    => :symbol
# Crystal => Error: undefined method 'intern' for String
```

## 配列

### 初期化時に指定した型の値しか使えない

Crystalの配列は「要素の型」を型引数として指定するジェネリクスとして実装されており、`Array#[]=`や`Array#<<`メソッドによって、「要素の型」に適合しないオブジェクトを放り込もうとするとエラーになります。

```crystal
arr = [0, 1, 2]
arr << "a"
# => Error: no overload matches 'Array(Int32)#<<' with type String
```

しかし、Crystal の配列が特定の1つの型のオブジェクトしか利用できないわけではありません。配列の初期化時には異なる型のオブジェクトを含めることができ、こうした場合、Crystal のコンパイラはこの配列の「要素の型」が、初期化時に与えられたすべてのオブジェクトの型のユニオン型だと判断します。その結果、そのユニオン型の合成元となった型のオブジェクトはすべて扱えるようになります。

```crystal
# Int32型とString型を含む配列
arr = [0, "a"]

p typeof(arr)    # => Array(Int32 | String)
p arr << 1       # => [0, "a", 1]
p arr << "b"     # => [0, "a", 1, "b"]

# Char型は初期化時に与えられていないのでNG
p arr << 'c'
# => Error: no overload matches 'Array(Int32 | String)#<<' with type Char
```

ただし、こうした配列の各要素はユニオン型（上記の例だと`(Int32 | String)`型）のオブジェクトとして扱われます。そのため、配列から取り出した値は、その値自身の型に固有なメソッドを使用するために、何らかの方法で型を特定する必要があるため注意が必要です。

```crystal
# Int32型とString型を含む配列
arr = [0, "a"]

# 値は"a"でも変数の型は(Int32 | String)
a = arr[1]

# そのままString型固有のメソッドを使用するとエラー
p a.size
# => Error: undefined method 'size' for Int32 (compile-time type is (Int32 | String))

# #is_a?メソッドなどで型を特定してやると使える
if a.is_a?(String)
  p a.size
  # => 1
end
```

### 初期化時に「要素の型」を特定できないとNG

```crystal
# 型指定のない空配列は作れない
arr = []
# => Syntax error: for empty arrays use '[] of ElementType'
```

「要素の型」をコンパイラに伝える方法の1つは、上でも紹介した初期化時に値を与える方法です。Crystalのコンパイラが、初期値として与えられているオブジェクトの型から「要素の型」を推測してくれます。空の配列を初期化する場合も型の指定が必要で、そのためには`Array(要素の型).new`メソッドを使って初期化する方法と、型を指定するリテラル形式`[] of 要素の型`で初期化するという2種類の方法が用意されています。

```crystal
# どちらも空のArray(Int32)オブジェクトとして初期化される
arr = Array(Int32).new
arr = [] of Int32
```

### 存在しない要素の取得がエラーになる

```crystal
arr = [0, 1]
p arr[2]
# Ruby    => nil
# Crystal => Index out of bounds (IndexError)
```

`Array#[](index : Int)`で存在しないインデックスを指定した場合、Rubyだと`nil`が返されますが、Crystalだと`IndexError`になります。これは、空の配列に対して`Array#first`や`Array#last`、`Array#pop`、`Array#shift`などを呼び出した場合も同様です。

その代わり、これらのメソッドには名前にクエスチョンマーク（`?`）がついた別メソッド`Array#[]?(index : Int)`や`Array#first?`、`Array#last?`、`Array#pop?`、`Array#shift?`などが用意されており、これらはRubyの各メソッドと同様、取得しようとした要素が存在しない場合に`nil`を返します。

```crystal
arr = [0, 1]
p arr[2]?
# => nil
```

このような仕様になっている理由は、Crystalの型推論とユニオン型の挙動にあります。

これまでにも何度か触れましたが、メソッドが複数の型の値を返す可能性がある場合、Crystalコンパイラはメソッドの返り値を可能性のあるすべての型のユニオン型として認識します。ということは、`#[]`などのメソッドが、存在しない要素への参照に`nil`を返す仕様だったとすると、その返り値は「要素の型」と`Nil`型のユニオン型になります。そして、ユニオン型として認識されているオブジェクトは合成元の型が共通して持っているメソッドしか使用できません。結果として、要素の型に固有のメソッドを使おうとするたびに、毎回`#not_nil!`メソッドやその他の方法で値が存在することを確定させなけれなならなくなります。

```crystal
# 仮定：もし#[]がnilも返す仕様だった場合

a = ["foo", "baa"]

p a[0].upcase
# => Error: undefined method 'upcase' for Nil (compile-time type is String?)

p a[0].not_nil!.upcase
# => "FOO"
```

要素が存在しない可能性を考慮する場合にメソッド名に`?`をつけるコストと、取得した要素を使用するたびに値が存在することを確定させるコストを比較した結果、後者よりも前者の方が負担が少ない、と判断されたようです。

### 配列っぽいオブジェクトその1：スライス（`Slice`）

スライス（`Slice`型）は配列のように複数の要素を含むことができインデックス番号の指定で特定の要素を取得することができるコレクション型オブジェクトで、配列のように「要素の型」を持っており、「要素の型」ごとに`Slice(String)`や`Slice(Int32)`などと表現されます。

スライスにはリテラルが存在しませんが初期化用の専用構文`Slice[]`が用意されています。また、`Slice.new`には多くの引数のパターンが用意されており、こちらを使ってスライスオブジェクトを作成することもできます。

```crystal
# 専用構文を使用した初期化
p Slice["a", "b", "c"]
# => Slice["a", "b", "c"]

# 要素数と初期値を指定して初期化
p Slice.new(2, "a")
# => Slice["a", "a"]

# 要素の型がプリミティブであれば要素数のみでも初期化可能
# （各値はゼロ初期化）
p Slice(UInt32).new(3)
# => Slice[0, 0, 0]

# プリミティブな型でないとエラーになるので注意
p Slice(String).new(3)
# => Invalid memory access (signal 11) at address 0xc
```

スライスは`#[]`メソッドにインデックスを指定して値を取り出したり、`#[]=`メソッドで値を更新したりできるほか、`Enumerable`や`Iterable`をmix−inしているので、`#each`、`#join`、`#map`など、`Array`でおなじみのメソッドを使用することもできます。

スライスが配列と大きく異なるのは、初期化時に決定したサイズを変更できないことです。そのため`#<<`メソッドはありませんし、`#push`、`#pop`、`#shift`、`#unshift`など使用後に自身のサイズが変化するようなメソッドも使用できません。`#[]`に存在しないインデックスを指定するとエラーになるのは配列と同じですが、`#[]?`は用意されていません。（サイズが決まってるんだからサイズの外にアクセスなんかしないでしょ？）

また、配列とスライスで共通のインスタンスメソッドがある場合、大抵は同じような動作をしますが、`#+`だけは大きく異なるので注意が必要です。`Array#+`は他の`Array`オブジェクトを引数（右辺）にとり、自身とその配列を結合した新しい配列を返します。これに対して`Slice#+`は整数値を引数（右辺）にとり、自身の先頭を数値分ずらした新しいスライスを返します。

```crystal
# Array#+は連結
p [1, 2] + ["3", "4"]
# => [1, 2, "3", "4"]

# Slice#+はオフセット操作
p Slice[1, 2, 3, 4] + 2
# => Slice[3, 4]
```

### 配列っぽいオブジェクトその2：タプル（`Tuple`）

タプル（`Tuple`型）も配列のように複数の要素を含むことができ、インデックス番号の指定で特定の要素を取得することができるコレクション型オブジェクトです。スライスと違ってタプルにはリテラルが用意されています。

```crystal
# タプルリテラル
tuple = {1, "a", 1.0}
```

配列と比べたとき、タプルには2つの大きな特徴があります。

ひとつはサイズ変更だけでなく初期化後は要素の更新が一切できない、俗に言うイミュータブルなオブジェクトであることです。イミュータブルであるため`#[]=`をはじめとした状態を変更するメソッドは利用できません。

そしてもうひとつ、タプル最大の特徴は何番目の要素が何型のオブジェクトであるかをタプル自身が知っていることです。そのため、実際に利用されるタプルオブジェクトの型は、要素の型のリストをつけた`Tuple(Int32, String, Float64)`（上記コード中のタプルオブジェクトの場合）という表現になります。また、型を指定する場面では、タプルリテラルの要素を型に置き換えた`{Int32, String, Float64}`という短縮表現を利用することもできます（タプル型の文字列表現もこの短縮表現が使用されます）。ただし、この短縮表現は型を指定する以外の場所で使用した場合、値に`Int32`と`String`、`Float64`というクラスオブジェクトを含んだタプルのリテラルとして解釈されますので注意してください。

配列やスライスだと、複数の要素がそれぞれ異なる型のオブジェクトだった場合、配列やスライス全体の「要素の型」がユニオン型になります。しかし、タプルの場合は何番目の要素が何型のオブジェクトなのかがわかっているので、個々の要素を取り出した場合に、そのまま元の型のオブジェクトとして扱うことができます。

```crystal
tuple = {1, "a"}
p typeof(tuple[0])
# => Int32
p typeof(tuple[1])
# => String
```

この特徴はメソッドから複数の値を返したいときに大活躍します。

```crystal
# 異なる型の値をタプルで返す
def tuple(s : String)
  {s.size, s.upcase}
end

# 返り値を多重代入可能
s, u = tuple("tuple")

# それぞれが元の型のオブジェクトになる
p typeof(s)
# => Int32
p typeof(u)
# => String

# それぞれの型固有のメソッドを直接使える
p s.odd?
# => true
p u.chars
# => ['T', 'U', 'P', 'L', 'E']
```

同じことを配列で行うと返り値を多重代入した変数がすべてユニオン型のオブジェクトとして認識されてしまい非常に面倒なことになります。

```crystal
# 異なる型の値を配列で返す
def array(s : String)
  [s.size, s.upcase]
end

# 配列でも多重代入は可能
s, u = array("array")

# ただし、ユニオン型のオブジェクトになる
p typeof(s)
# => (Int32 | String)

# 元の型に固有のメソッドを直接使えない
p s.odd?
# => Error: undefined method 'odd?' for String (compile-time type is (Int32 | String))
```

また、タプルはスプラット（`*`）と組み合わせてメソッド引数の受け渡しに使用することができます。CrystalでもRubyと同じように、メソッド定義の引数名の前に`*`をつけることで任意の数の値を受け取ることができますが、この際`*`つきで定義された引数をメソッド内で使用する場合の型がCrystalではタプルになります（Rubyでは配列でした）。

```crystal
def foo(*arg)
  arg
end

p foo(1, 2.0, "3", '4')
# => {1, 2.0, "3", '4'}
```

逆に、複数の引数を受け取るメソッドに対して、対応する値を要素にもつタプルを`*`付きで渡して呼び出すこともできます。

```crystal
def bar(a : String, b : Int32)
  a * b
end

tpl = {"abc", 2}
p bar(*tpl)
# => "abcabc"
```

ほかにも、[`case`文のマッチ条件に使用できたり](http://crystal-lang.org/docs/syntax_and_semantics/case.html)と、タプルはかなり奥の深いオブジェクトです。

## ハッシュ

Rubyとの比較という見方でいうと、Crystalのハッシュは前述した配列と同じような特徴を持っています。

### 初期化時に指定した型のキーと値しか扱えない

ハッシュもCrystalでは、「キーの型」と「値の型」を型引数に持つジェネリクス（`Hash(Symbol, String)`など）として実装されており、キーと値としてそれぞれの型に合致するオブジェクトしか扱えません。

```crystal
hash = {"a" => 1, "b" => 2}
p typeof(hash)
# => Hash(String, Int32)

# キーの型が違う
hash[:c] = 1
# => Error: no overload matches 'Hash(String, Int32)#[]=' with types Symbol, Int32

# 値の方が違う
hash["c"] = 3.0
# => Error: no overload matches 'Hash(String, Int32)#[]=' with types String, Float64
```

初期化時のキーや値に複数の型のオブジェクトが含まれていると、「キーの型」や「値の型」がユニオン型になるのも配列とよく似ています。

```crystal
hash = {"a" => 1, 'b' => 2.0}

p typeof(hash)
# => Hash(Char | String, Float64 | Int32)
```

ユニオン型の値は取り扱いが面倒ですので、Rubyなどでたまに見かける「ハッシュに様々な値を放り込んで、状態だけを保持できる汎用の簡易オブジェクトとして使用する」といった手法は、Crystalには向いていないと言えます。こうした場合、もし初期化後に状態の更新を伴わないのであれば後述する名前付きタプルが利用できますし、状態を更新する必要があるのであればそのデータ用の型を定義するべきでしょう。

### 初期化時に「キーの型」や「値の型」が特定できないとNG

```crystal
# キーや値の型指定がない空ハッシュは作れない
hash = {}
# => Syntax error: for empty hashes use '{} of KeyType => ValueType'
```

「キーの型」や「値の型」をコンパイラに伝える方法の1つは、上でも紹介した初期化時に値を与える方法です。Crystalのコンパイラが、初期値として与えられているオブジェクトの型から「キーの型」と「値の型」を推測してくれます。空のハッシュを初期化する場合も型の指定が必要で、そのために`Hash(キーの型, 値の型).new`メソッドを使う方法と、型を指定するリテラル形式`{} of キーの型 => 値の型`を使うという2種類の方法が用意されています。

```crystal
# どちらも空のHash(String, Int32)オブジェクトで初期化される
hash = Hash(String, Int32).new
hash = {} of String => Int32
```

### 存在しないキーへのアクセスはエラーになる

これも配列と同様、`#[]`に存在しないキーを指定するとエラーが発生します。そして、キーが存在しない場合に`nil`を返す`#[]?`も用意されています。

```crystal
hash = {"a" => 1, "b" => 2}

p hash["c"]
# => Missing hash key: "c" (KeyError)

p hash["c"]?
# => nil
```

ただし、`||=`を利用してキーが存在しない場合にのみ値を代入する`hash[key] ||= value`という構文は、コンパイラによって以下のように展開されるため、エラーにならずこれまでどおり利用可能です。

```crystal
hash[key] ||= value
# ↑は↓に展開される
hash[key]? || hash[key] = value
```

### `{symbol: value}`形式のリテラルはハッシュではない

Rubyに1.9系から実装されたシンボルをキーとするハッシュの`{symbol: value}`形式の表現は、Crystal 0.17.0以降ではハッシュではなく後述する名前付きタプル（`NamedTuple`型）のリテラルになりました。

0.17.0以降のCrystalではシンボルをキーとするハッシュも標準的な`{:symbol => value}`形式のリテラルを使用する必要があります。

```crystal
# これは名前付きタプル
ntpl = {a: 1, b: 2}

# ハッシュはこう
hash = {:a => 1, :b => 2}
```

名前付きタプルは初期化後に更新ができませんので、ハッシュのつもりで名前付きタプルを作ってしまうと、状態を更新しようとした際にエラーに遭遇することになります。このときのエラーメッセージは、`{symbol: value}`形式をハッシュのリテラルだと思っていると、値がハッシュとは違う型になってしまっていることが微妙に分かりにくいため注意が必要です。

```crystal
# 上記コードの続き
ntpl[:c] = 3
# => Error: undefined method '[]=' for {a: Int32, b: Int32}
```

### ハッシュっぽいオブジェクト：名前付きタプル（`NamedTuple`）

前項でちらっと登場した名前付きタプル（`NamedTuple`）は、ハッシュと同様にキーとそのキーに対応した値を持つコレクション型オブジェクトですが、名前付きタプルのキーは必ずシンボルです。初期化後に状態を変更できない点や、各キーに対応する値の型情報を保持している点など、機能面から見たハッシュと名前付きタプルの関係は、配列とタプルの関係によく似ています。また、先ほども触れたとおり、名前付きタプルには初期化に使えるリテラルが用意されています。

```crystal
# 名前付きタプルリテラル
ntpl = {a: 1, b: "a"}

p typeof(ntpl[:a])
# => Int32

p typeof(ntpl[:b])
# => String
```

実際に利用される名前付きタプルオブジェクトの型は、正式にはキーとその値の型を含んだ`NamedTuple(a: Int32, b: String)`（上記コード中の名前付きタプルオブジェクトの場合）という表現になります。また、型を指定する場面では、名前付きタプルリテラルの値を型に置き換えた`{a: Int32, b: String}`という短縮表現を利用することもできます。ただし、この短縮表現は型を指定する以外の場所で使用した場合、キー`:a`に対して値に`Int32`を、キー`:b`に対して値に`String`を持つ名前付きタプルのリテラルとして解釈されますので注意が必要です。

値として複数の型のオブジェクトを含む場合、取り出した値がユニオン型だと見なされるハッシュと異なり、各キーの値がどの型なのかが分かっているので、名前付きタプルから取り出した値は元の型のオブジェクトとしてそのまま使用できます。

```crystal
# さらに続き
p ntpl[:b].upcase
# => "A"
```

また、名前付きタプルはスプラット2つ（`**`）と組み合わせることで、メソッド引数の受け渡しに使用することができます。

CrystalでもRubyでも、メソッド定義時に`**`を先頭につけた引数を設定すると、メソッド呼び出し時に任意のキーワード引数を渡すことができます。Crystalでは、このとき`**`付きで設定された引数はメソッド内では名前付きタプルオブジェクトになります（Rubyではハッシュでした）。

```crystal
def foo(**arg)
  arg
end

p foo(a: "abc", b: 2)
# => {a: "abc", b: 2}
```

逆に、メソッドに対して名前付きタプルを`**`付きで引数として与えることで、タプルの内容を引数リストに展開してメソッドを呼び出すことができます。

```crystal
def bar(a : String, b : Int32)
  a * b  
end

ntpl = {a: "abc", b: 2}
p bar(**ntpl)
# => "abcabc"
```

普通の（名前付きでない）タプルでもできるじゃないか、と思われるかもしれませんが、名前付きタプルを利用する場合、デフォルト値が設定されている任意の引数を省略できる点が異なります。タプルの場合は要素の順番が、引数の順番と対応しているため、タプルの要素数が引数定義より少ない場合は、先頭から要素の数分の引数が指定されたものと見なされ、途中の引数を省略することができません。

```crystal
# デフォルト値が指定された引数を持つメソッド
def buz(a : String = "abc", b : Int32 = 2 , c : Bool = false)
  d =  a * b
  c ? d.upcase : d
end

# 名前付きタプルなら途中の引数でも省略して実行可能
ntpl = {a: "xyz", c: true}
p buz(**ntpl)
# => "XYZXYZ"

# タプルだと途中の引数を省略できない
tpl = {"xyz", true}
p buz(*tpl)
# => Error: no overload matches 'buz' with types String, Bool
```

## 型定義関係

### `attr_*`がない

特定のインスタンス変数へのアクセサメソッドを提供してくれる`attr_reader`、`attr_writer`、`attr_accessor`構文はCrystalには存在しません。その代わり、それぞれに対応した`getter`、`setter`、`property`というアクセサマクロが用意されています。使い方はRubyの`attr_*`とほぼ同じですが、インスタンス変数の指定方法が複数用意されています。

```crystal
# Rubyの場合
attr_reader :foo

# Crystalの場合（いずれも同じ結果）
getter :foo
getter @foo
getter foo
```

### `#initialize`もオーバーロードできる

他のメソッドと同様、`#initialize`もオーバーロードできます。`#initialize`をオーバーロードすると、クラスメソッド`.new`をオーバーロードしたのと同じような挙動になります。数値や文字列など様々な型の値をソースとしてオブジェクトを生成したい場合など、処理を明確に分離できてコードの見通しがよくなります。

このとき、個々の`#initialize`内でインスタンス変数の初期化までを完結させることもできますが、`#initialize`内から別の`#initialize`を呼ぶことも可能ですので、個人的には複数の`#initialize`を実装する場合はインスタンス変数の初期化を行う一番ベーシックな`#initialize`を1つ用意し、他の引数パターンを持つ`#initialize`は引数を変換してベーシックな`#initialize`を呼ぶような作りにするのが良いのではないかと考えています。

```crystal
class Foo
  def initialize(@v : Int32)
  end

  def initialize(s : String)
    initialize(s.to_i)
  end
end

f1 = Foo.new(1)

f2 = Foo.new("2")
```

### `#initialize`中で初期化されないインスタンス変数はnilableになる

初期化されないと存在しないものと見なされるローカル変数と異なり、インスタンス変数は未定義であっても使用することができ、そのときの値は`nil`になります。そのため`#initialize`中で初期化されなかったインスタンス変数は`nil`の状態がありうる（nilableな）値だとコンパイラに認識されます。

前述したとおり、インスタンス変数は型定義の中で型が特定される必要があります。例えば、`Int32`型だと宣言したインスタンス変数が`#initialize`中で初期化されなかった場合、`Int32`型は`nil`という値を許容しないためコンパイルエラーになります。このとき、インスタンス変数の型が明示的に`nil`を値として許容する型（`Int32?`型など）として宣言されていればエラーは起こりません。未定義の状態を`nil`として扱うインスタンス変数は、`Nil`型とのユニオン型として宣言しておきましょう。

```crystal
class Foo
  @bar : Int32
end

foo = Foo.new
# => Error: instance variable '@bar' of Foo was not initialized in all of the 'initialize' methods, rendering it nilable
```

### `to_s`のオーバーライドが反映されないように見える

Crystalにも、Rubyと同じくオブジェクトの文字列表現を返す`#to_s`メソッドが用意されており、暗黙の文字列変換が必要な場合には`#to_s`メソッドが返すのと同じ文字列が使用されます。また、何かのクラスを継承しない独自クラスを定義した場合、デフォルトの`#to_s`は型名とオブジェクトIDから自動生成された文字列を返します。

```crystal
class Foo
end

foo = Foo.new
p foo.to_s
# => "#<Foo:0x10f3d5fd0>"
puts foo
# => #<Foo:0x10f3d5fd0>
```

さて、この`Foo`型のオブジェクトに独自の文字列表現を持たせようとして、Rubyでの作法通りに引数なしの`#to_s`をオーバーライドするとどうなるでしょう。

```crystal
class Foo
  def to_s
    "This is Foo!"
  end
end

foo = Foo.new
p foo.to_s
# => "This is Foo!"
puts foo
# => #<Foo:0x10965cfd0>
```

期待した通りの動作にはなりませんでした。`Foo#to_s`メソッドは確かにオーバーライドした結果の文字列を返してくれていますが、`puts`による暗黙の文字列変換ではオーバーライド前の文字列表現がそのまま使われています。こうした場合Crystalでは、引数なしの`#to_s`ではなく、引数に`IO`オブジェクトを取る`#to_s(io : IO)`をオーバーライドし、引数で与えられた`IO`オブジェクトに対して文字列を追加（出力）するような処理を記述します[^to_s]。

[^to_s]: "Descendants must usually not override this method. Instead, they must override #to_s(io), which must append to the given IO object."【参照】<http://crystal-lang.org/api/Object.html#to_s-instance-method>

```crystal
class Foo
  def to_s(io : IO)
    io << "This is Foo!"
  end
end

foo = Foo.new
p foo.to_s
# => "This is Foo!"
puts foo
# => This is Foo!
```

これで期待した通りの動作をするようになりました。

## その他

### 同機能のメソッドが集約されている

Rubyの`String`クラスには、`#size`と`#length`というメソッドがありますが、どちらも返すのは文字列の文字数です。Crystalの`String`型には`#length`がなく`#size`だけが残っています。このほか、`Enumerable`の`#map`と`#collect`が`#map`だけになっていたりと、Rubyで同じ機能のメソッドが複数用意されている場合、Crystalではその多くが１つのメソッドに集約されています。

### `Object#class`の返り値をクラスオブジェクトとして使えない場面がある

Crystalにも、Rubyと同じようにあるオブジェクトのクラスを返す`Object#class`メソッドが用意されています（構造体の場合でもメソッド名は`#class`です）。Crystalでも`Object#class`の返り値をレシーバにしてクラスメソッドを呼び出したりできますが、Rubyの場合と全く同じように使えるわけではないようです。例えば、Rubyだと問題のない以下のようなコードも、Crystalではエラーになります。

```crystal
class Foo
  BAA = 1
end

foo = Foo.new
class_of_foo = foo.class
bar = class_of_foo.new

# #is_a?の引数には指定できない
p bar.is_a?(class_of_foo)
# => Syntax error: expecting token 'CONST', not 'class_of_foo'
#    p bar.is_a?(class_of_foo)
#                ^

# クラス定数も参照できない
p class_of_foo::BAA
# => Syntax error: unexpected token: ::
#    p class_of_foo::BAA
#                  ^
```

エラーメッセージを見る限り、どちらのエラーも構文解析上の問題みたいですね。

前者については、さしあたりクラスメソッドのレシーバになれるので、クラス定数の値を返すクラスメソッドを用意すればなんとかなりそう。後者についても`bar.class == class_of_foo`という形で同じクラスかどうかの判定はできますが、この方法はユニオン型のオブジェクトに対して型を特定するための条件としては機能しないようで、完全な代替にはならなさそうな感じです。

```crystal
class Foo
  def buz
    "buz"
  end
end

arr = [Foo.new]

foo = Foo.new
bar = arr.first?

if bar.class == foo.class
  # コンパイラはbarがFoo型であるとは認識できない
  p bar.buz
  # => Error: undefined method 'buz' for Nil (compile-time type is Foo?)
end
```

## 最後に

というわけで、超利用者視点でRuby経験者がCrystalを触ってみて「おっ？」と思った内容を中心にまとめてみました。本当にザックリとした説明になっていますので、とりあえずのイメージを持ってもらえたらCrystalの[公式ドキュメント](http://crystal-lang.org/docs/)や[APIリファレンス](http://crystal-lang.org/api/index.html)を一度じっくり読んでみてください。そうすれば、もっと詳細なCrystalの挙動（オーバーロード時のメソッド選択の優先度とか、ジェネリクス継承時の型引数の取り扱いとか、抽象型の存在理由とか、`Slice`本来の位置づけとか）を確認できるはずです。

また、インターネットには、Crystalに挑戦しようとするRubyistに向けたドキュメントがいくつも公開されています。それらもCrystalの世界を感覚的に理解する助けになるでしょう。

- [Crystal for Rubyists（crystal-lang/crystal Wiki）](https://github.com/crystal-lang/crystal/wiki/Crystal-for-Rubyists)（英語）

    GitHub上のCrystal公式リポジトリ付属のWikiページ

- [Crystal for Rubyists](http://www.crystalforrubyists.com)（英語）

    Crystal製のShinatraライクなWebフレームワーク[Kemal](http://kemalcr.com)の作者としても知られる[Serdar Dogruyol](https://github.com/sdogruyol)さんによるコンテンツ

- [Ruby脳にはCrystalつらい Advent Calendar 2015](http://qiita.com/advent-calendar/2015/crystal-for-rubyist)

    [tmtm](https://github.com/tmtm)さんによる2015年のアドベントカレンダー企画

そうしてRubyとは違う「Crystal言語」を意識できれば、その先には「マクロ」や「Cバインディング」といったもう一歩踏み込んだディープな世界が待っています。さらに、Crystalはそれ自体がCrystal言語で書かれていますので、公式GitHubリポジトリの[ソースツリー](https://github.com/crystal-lang/crystal/tree/master/src)を覗けば、最高のサンプルコードが大量に手に入りますよ。

それでは、みなさん楽しいCrystalライフを！

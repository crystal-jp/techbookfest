# Metaprogramming Crystal Introduction

@ucmskyと申します。普段はSalesforceとHerokuでSIやってます。本稿ではCrystalでのメタプログラミングについて軽く紹介したいと思います。

RubyでDRY原則を突き詰めていく過程でメタプログラミングは必要不可欠な要素ですし、恩恵に預かっていないケースは非常に少ないと思われます。
メタプログラミングとはなんぞや？　という方は、以下のサイトや後述するメタプログラミングRubyなどをご一読いただけるとおおまかに概要はつかめると思います。

- [まつもと直伝　プログラミングのオキテ 第6回](http://itpro.nikkeibp.co.jp/article/COLUMN/20070604/273453/?rt=nocnt)

- [難しいが強力！ Rubyのメタプログラミング、self、特異クラス／メソッド、オープンクラスとモンキーパッチ (1/4)](http://www.atmarkit.co.jp/ait/articles/1501/06/news028.html)

- [メタプログラミングって何だろう](http://www.slideshare.net/kmizushima/ss-6031153)

- [メタプログラミング技法　第1回: メタプログラミングとは](https://www.ibm.com/developerworks/jp/linux/library/l-metaprog1/)

- [Rubyのメタプログラミング技術](http://alpha-netzilla.blogspot.jp/2013/08/ruby.html)

CrystalがRubyと似たシンタックスということで、興味を持たれているRubyistの方は多々おられると思います。
私自身そこから入った者ですが興味を持ち始めてから何れかの早い時点で思うのが、「Crystalでもメタプログラミングは可能か？」だと思います。

結論から言うと、静的型付言語であるCrystalではRubyと同じ方法でのメタプログラミングの実装を使用することはできません[^1]が、別の方法でCrystalでもメタプログラミングを行うことは出来ます。

[^1]: Crystalのシンタックスは確かにRubyに似ているといえばいえますが、メタプログラミングの実装方法について言えば、全くの別物です。

## 取っ掛かり
先ずは、Rubyのメタプログラミングのバイブル的存在の「[メタプログラミングRuby 第2版](http://www.amazon.co.jp/dp/4873117437/)」の「第２章　月曜日：オブジェクトモデル」から記載されているサンプルコードをCrystalで書く場合どういったコードになるのか[^2]というところから取り上げていこうと思います。


[^2]: 私のレベルで説明しやすそうなところを拾いながら取り上げていくという感じなので、あまり体系的なものにはならないです。
尚、当然ですが、メタプログラミングを真面目に解説しだすと本何冊分にもなってしまいます（何より筆者の実力が追いついていない）ので、取り掛かりの部分を扱います。

## オープンクラス

同じ名前のクラスを再度定義すると、同じメソッドが定義されている場合はオーバーライドされ、そうでない場合は新しいメソッドを追加することが出来ます。

```
class D
  def x; "x"; end
end

class D
  def y; "y"; end
end

obj = D.new
p obj.x #=> x
```

以下はオブジェクト指向的に修正する場合の例です。
今回追加しているのは、文字列に記号が含まれている場合は取り去るメソッドを追加しています。

```
def to_alphanumeric(s)
  s.gsub(/[^\w\s]/, "")
end

p to_alphanumeric("#3, the *Magic, Number*?") #=> "3 the Magic Number"

class String
  def to_alphanumeric
    gsub(/[^\w\s]/, "")
  end
end

p "#3, the *Magic, Number*?".to_alphanumeric #=> "3 the Magic Number"
```

既に定義されているStringクラスを再オープンし、メソッドを追加しています。
当然問題点もあり、同じ名前、かつ同じ引数、同じ戻り値のメソッドの再定義した場合は上書きしてしまいます。
言い換えると引数を変えるか戻り値を変えると複数定義できる（オーバーロード）のはRubyとの違いです。

### オーバーロードのサンプル

```
class Sample
  def meth()
    puts "meth"
  end

  def meth(value)
    puts value
  end

  def meth(value : Int) : Int
    return value
  end
end

smp = Sample.new
smp.meth #=> "meth"
smp.meth("sample meth") #=> "sample meth"
puts smp.meth(10) #=> 10
```

## 継承階層

クラスの継承階層の確認方法について、RubyではModule#ancestorsを呼び出すことで継承の流れを確認することが出来ました。
Crystalでクラスの継承階層はどのようになっているかを確認するには、Crystalの標準ツールのhierarchyを使います。

### 継承サンプル

```
module MyModule
  def my_module_meth
    "module meth"
  end
end

class MyClass1
  include MyModule

  def my_method
    "my_method"
  end
end

class MyClass2 < MyClass1
  def my_method
    "my_method2"
  end
end

mc2 = MyClass2.new
p mc2.my_method #=> "my_method2"
p mc2.my_module_meth #=> "module meth"
```

上記コードをancestors.crという名前で保存した場合、継承のツリーを確認したい場合は以下のコマンドを実行します。

```
$ crystal tool hierarchy ancestors.cr
```

膨大な情報が表示されるので、簡潔に抜粋すると以下の様なものが表示されます。

```
- class Object (4 bytes)
  |
  +- struct Value (0 bytes)
  |  |
  |  +- function Proc(T)
  |  |  |
  |  |  +- function (Int32 -> Nil)
  |  |  |
(中略)
  |
  +- class Reference (4 bytes)
     |
     +- class MyClass1 (4 bytes)
     |  |
     |  +- class MyClass2 (4 bytes)
     |

```

上のツリーでは、「途中で差し込まれてるはずのMyModule」については表示されません。（要調査項目ではあります）

## メソッド動的生成

メソッドを動的生成する仕組みについてですが、ここからRubyと全く異なります。  
マクロという仕組みを使います。

> マクロとは、コンパイル時に AST ノードを受け取り、  
> コードを生成してそれをプログラムに書き込むメソッドです。

公式ドキュメント　[マクロの項](http://ja.crystal-lang.org/docs/syntax_and_semantics/macros.html)より抜粋。

だいたいまずこんなサンプルです。

```
macro define_method(name, content)
  def {{name.id}}
    {{content}}
  end
end

define_method :foo, 1
p foo #=> 1
```

## method_missing

Rubyでお馴染みのmethod_missingはCrystalでも使用可能です。

```
class Foo
  macro method_missing(name, args, block)
    p {{name}}
    p {{args[0]}}
  end
end

Foo.new.bar "abcd"
#=>"bar"
#=>"abcd"
```

## with .. yield構文

[ドキュメント](http://ja.crystal-lang.org/docs/syntax_and_semantics/macros.html)を読んでいても、いまいち分かり辛かったのが、with .. yield構文です。

コミュニティで尋ねてみると以下の回答を頂きました。

> @pacuum さん  
> with XXX yield はブロックを評価するときに  
> self を XXX に差し替えるというものだと思います。

> @makenowjust さん  
> ほとんどの場合その認識で問題はないのですが、  
> より正確には、ブロック内のレシーバーの無いメソッドを探索する際に  
> selfも参照するようにする、という動作になります

..の部分を書き換えるとどういう違いになるのか、については、簡単なサンプルを書いてみました。

```
class ClassA
  def handlerA
    with self yield
  end

  def handlerB
    with ::ClassB.new yield
  end

  macro hoge
    foo
  end

  def foo
    p :foo1
  end
end

class ClassB
  def handlerB
    with ::ClassA.new yield
  end

  macro hoge
    foo
  end

  def foo
    p :foo2
  end
end

ClassA.new.handlerA {hoge} #=> :foo1
ClassA.new.handlerB {hoge} #=> :foo2
ClassB.new.handlerB {hoge} #=> :foo1
```

上記例だと、メソッド「foo」を探索するコンテキストを切り替えていることがわかります。

### 調べてる最中に気づいたこと

クラスメソッドの書き方は一本化されているみたいです。

```
class Hoge
  def self.foo
   p "foo"
  end
end
Hoge.foo #=> "foo"
```

ところが以下の書き方の場合だと

```
class Hoge
  class << self
    def foo
      p "foo"
    end
  end
end
#=> NG
# Syntax error in eval:2: expecting token 'CONST', not '<<'
```

となります。
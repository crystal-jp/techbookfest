# Crystal開発環境の構築

はじめまして。私は[\@pine](https://github.com/pine)という名前でOSS活動をしているWeb系のエンジニアです。
技術は広く浅く触る系で、ある時たまたまCrystalを見かけ、それから触り始めました。

CrystalはRuby風のシンタックスを持ったコンパイル型言語です。
CrystalはCrystal自身によって書かれたコンパイラを持つ、セルフホスティング言語です。
そのため、Crystalの開発を始めるには、はじめにバイナリで配られているのコンパイラをインストールする必要があります。

この記事では、Crystalを始めるにあたって必要となる環境構築の方法と、プロジェクトの始め方について解説しています。

## インストール方法

### crenvとは ?

Crystal をインストールするには、[crenv](https://github.com/pine/crenv)を使うのが便利です。

crenvはRubyにおけるrbenvからフォークしたツールであり、
プロジェクトごとに任意のバージョンのCrystalを用いることを容易にします。
基本的な使い方は、[rbenv](https://github.com/sstephenson/rbenv)と変わりません。

crenvを用いると、グローバルに1つのバージョンをインストールした場合と異なり、
Crystalのバージョンアップにより急に動作しなくなることが無くなります。
そのため、安心して開発に取り組むことができます。

### 対応環境

Crystalが動作する環境はMac OS X、Linux(i686/x64)及びFreeBSD(x64)です。
crenvは、そのいずれの環境でも動作します。

その他に、以下のツールがインストールされている必要があります。
(一般的な開発者の環境では、インストールされていると思われます。)

- Bash
- Git
- wget or cURL
- Perl 5
- Homebrew (OS X の場合)

### anyenvを用いてcrenvをインストール(推奨)

[anyenv](https://github.com/riywo/anyenv)という、複数のenv系を切り替えるツールがあります。
もし、anyenvを既に利用している場合は、以下のコマンドひとつで導入することができます。

```
$ anyenv install crenv
```

anyenvのバージョンが古い場合、以下のコマンドでanyenv自体を更新してからcrenvのインストールを試して下さい。

```
$ cd ~/.anyenv
$ git pull origin master
$ exec $SHELL -l
```

### 通常のインストール方法

Git コマンドを用いて、以下のようにインストールを行います。

```
$ git clone https://github.com/pine/crenv ~/.crenv
$ git clone https://github.com/pine/crystal-build.git ~/.crenv/plugins/crystal-build
```

インストール後、お使いのシェル(bash, zsh等)に対して設定を追加してください。

```
export PATH="$HOME/.crenv/bin:$PATH"
eval "$(crenv init -)"
```

以上でインストールは終了です。
シェルを再起動すれば、`crenv`が使えるようになっています。

```
$ exec $SHELL -l
$ crenv --version
crenv 1.0.1-7-g585d167
```

### crenvを用いてCrystalをインストール

crenvがインストールされたら、Crystalのインストールに移ります。
`crenv install -l` を実行して、利用可能なCrystalのバージョンを列挙してみましょう。

```
$ crenv install -l
Available versions:
  0.5.0
  0.5.1
  0.5.2

略

  0.17.1
  0.17.2
  0.17.3
  0.17.4
  0.18.0
```

ここでは、利用可能な最新バージョンである 0.18.0を利用します。

```
$ crenv install 0.18.0
Resolving Crystal download URL by Remote Cache ... ok
Downloading Crystal binary tarball ...
Moving the Crystal directory ...ok
Checking if Shards already exists ... ok
Install successful
```

Mac OS X環境では、利用可能なHomebrewのバイナリが存在する場合、そちらが優先して利用されます。
Linux/FreeBSD環境では、公式でリリースされているバイナリがインストールされます。

正常にインストールされたかどうか、`crenv versions`で確認してみます。

```
$ crenv versions
  0.18.0
```

インストールされたCrsytalを利用するには、`crenv global`コマンドで利用するバージョンを指定します。

```
$ crenv global 0.18.0
$ crystal -v
Crystal 0.18.0 (2016-06-14)
```

### crenv以外のインストール方法

Homebrewやapt/yumなどを利用することにより、Crystalインストールすることもできます。
aptやyumはCrystal言語公式のリポジトリが公開されているので、そちらをご利用下さい。

## プロジェクトの作成

Crystalのインストールが終了したら、プロジェクトを作成してみましょう。
プロジェクトを作成するには`crystal init`コマンドを利用します。

```
$ crystal init
TYPE is missing
Usage: crystal init TYPE NAME [DIR]

TYPE is one of:
    lib    creates library skeleton
    app    creates application skeleton

NAME - name of project to be generated,
       eg: example
DIR  - directory where project will be generated,
       default: NAME, eg: ./custom/path/example

    --help show this help
```

作成するプロジェクトの種類として、ライブラリとアプリケーションを選ぶことができます。
ここでは、アプリケーションを選びます。

```
$ crystal init app example
      create  example/.gitignore
      create  example/LICENSE
      create  example/README.md
      create  example/.travis.yml
      create  example/shard.yml
      create  example/src/example.cr
      create  example/src/example/version.cr
      create  example/spec/spec_helper.cr
      create  example/spec/example_spec.cr
Initialized empty Git repository in /Users/username/project/example/.git/
```

これでexample配下にプロジェクトの雛形が出来上がりました。
実際の開発では、こちらを利用して開発を進めていくことになります。

## パッケージマネージャー Shards の使い方
ShardsはCrystal標準のパッケージマネージャーです。
先ほど生成した雛形にも含まれている、shard.ymlというファイルを利用します。

Shardsでは、依存ライブラリのバージョンを設定ファイルshard.ymlに記述し、
Shardsを使ってライブラリをインストールします。
基本的には、RubyのBundlerなどと同じような使い方です。

shard.ymlは、以下のようにただ依存パッケージを列挙していく形で記述します。
詳しい記述方法は、Shardsの[SPEC](https://github.com/crystal-lang/shards/blob/master/SPEC.md)を参照して下さい。

```
name: package_name # あなたのライブラリの名前
version: 0.1.0 # あなたのライブラリのバージョン

dependencies:
  dependency_pkg_1: # 依存しているパッケージ名
    github: user/repo # GitHub に存在する場合
  dependency_pkg_2:
    version: ~> 0.1.0 # 依存バージョンを指定 (<, <=, >=, >, ~> が使える)

development_dependencies: # 開発で使う依存パッケージ
  development_dependency_pkg_1:
    ... (略)

license: MIT
```

ライブラリのバージョニングは、[Semantic Versioning](http://semver.org/)に基づいて行ってください。
Gitリポジトリ上のタグも、それに基づいてv0.1.0(プレフィックスとしてvをつける) のように作成する必要があります。
Shardsや他の開発者がそのようにバージョニングされていることを期待するので、必ず従う必要があります。

shard.ymlを記述した後に、`shard install`コマンドを実行することにより依存ライブラリがインストールされます。
詳しい使い方は、Shardsのヘルプをご覧ください。

```
$ shards --help
shards [options] <command>

Commands:
    check
    init
    install
    list
    prune
    update

Options:
    --no-color
    --version
    --production
    -v, --verbose
    -q, --quiet
    -h, --help
```

ぜひ、crenvとShardsで快適なCrystal開発ライフをお過ごしください!

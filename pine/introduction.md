# Crystal 開発環境の構築

Crystal は Ruby 風のシンタックスを持ったコンパイル型言語です。
Crystal は Crystal 自身によって書かれたコンパイラを持つ、セルフホスティング言語です。
そのため、Crystal の開発を始めるには、はじめにバイナリで配られているのコンパイラをインストールする必要があります。

この記事では、Crystal を始めるにあたって FIXME

## crenv
### crenv とは ?
Crystal をインストールするには、[crenv](https://github.com/pine613/crenv) を使うのが便利です。

crenv は Ruby における rbenv からフォークしたツールであり、
プロジェクトごとに任意のバージョンの Crystal を用いることを容易にします。
基本的な使い方は、[rbenv](https://github.com/sstephenson/rbenv) と変わりません。

crenv を用いると、グローバルに 1 つのバージョンをインストールした場合と異なり、
Crystal のバージョンアップにより急に動作しなくなることが無くなります。
そのため、安心して開発に取り組むことができます。

### 対応環境
Crystal が動作する環境は Mac OS X、Linux (i686/x64) 及び FreeBSD (x64) です。
crenv は、そのいずれの環境でも動作します。

その他に、以下のツールがインストールされている必要があります。
(一般的な開発者の環境では、インストールされていると思われます。)

- Git
- FIXME

### anyenv を用いて crenv をインストール (推奨)
[anyenv](https://github.com/riywo/anyenv) という、複数の env 系を切り替えるツールがあります。
もし、anyenv を既に利用している場合は、以下のコマンドひとつで導入することができます。

```
$ anyenv install crenv
```

anyenv のバージョンが古い場合、以下のコマンドで anyenv 自体を更新してから crenv のインストールを試して下さい。

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

インストール後、お使いのシェル (bash, zsh 等) に対して設定を追加してください。

```
export PATH="$HOME/.crenv/bin:$PATH"
eval "$(crenv init -)"
```

以上でインストールは終了です。
シェルを再起動すれば、`crenv` が使えるようになっています。

```
$ exec $SHELL -l
$ crenv --version
crenv 1.0.1-7-g585d167
```

### crenv を用いて Crystal をインストール
crenv がインストールされたら、Crystal のインストールに移ります。
`crenv install -l` を実行して、利用可能な Crystal のバージョンを列挙してみましょう。

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

ここでは、利用可能な最新バージョンである 0.18.0 を利用します。

```
$ crenv install 0.18.0
Resolving Crystal download URL by Remote Cache ... ok
Downloading Crystal binary tarball ...
https://homebrew.bintray.com/bottles/crystal-lang-0.18.0.el_capitan.bottle.tar.gz
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
  0     0    0     0    0     0      0      0 --:--:--  0:00:01 --:--:--     0
100 9181k  100 9181k    0     0  5548k      0  0:00:01  0:00:01 --:--:-- 54.8M
ok
Moving the Crystal directory ...ok
Checking if Shards already exists ... ok
Install successful
```

Mac OS X 環境では、利用可能な Homebrew のバイナリが存在する場合、そちらが優先して利用されます。
Linux / FreeBSD 環境では、公式でリリースされているバイナリがインストールされます。

インストールされたか `crenv versions` で確認してみます。

```
$ crenv versions
  0.18.0
```

インストールされた Crsytal を利用するには、`crenv global` コマンドで利用するバージョンを指定します。

FIXME

## crenv 以外のインストール方法
Homebrew や apt/yum などを利用することにより、Crystal インストールすることもできます。
apt や yum は Crystal 言語公式のリポジトリが公開されているので、そちらをご利用下さい。

# プロジェクトの作成
FIXME

# パッケージマネージャー Shards の使い方
FIXME

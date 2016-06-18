# CrystalとWeb
## CrystalでWebアプリを作成する
Crystalでは標準でWebサーバの機能を提供しています。
公式のサンプルをそのまま掲載しますが、以下のコードをビルド、実行するとブラウザから「http://localhost:8080」でアクセスするとそのまま「Hello World」が表示されます。

`http_sample.cr`
```
# A very basic HTTP server
require "http/server"

server = HTTP::Server.new(8080) do |context|
  context.response.content_type = "text/plain"
  context.response.print "Hello world"
end

puts "Listening on http://0.0.0.0:8080"
server.listen
```

ビルド、実行は以下の手順です。
```
crystal build --release http_sample.cr
./http_sample
```

もっと複雑なWebアプリを作成したい場合は、役立つフレームワークが幾つか有志の手で作られております。
以前第3回Crystal勉強会で紹介させていただいたFrost[^1]や、同勉強会で@pine613さんが紹介されたKemal[^2]などが代表的ですが、他の情報については「Awesome Crystal」[^3]で取り上げられているので本稿では割愛します。
本稿ではKemalを主に例として挙げ、Crystalでのミニブログ機能を持つWebアプリの制作方法を簡単に紹介します。

[^1]: Frost https://github.com/ysbaddaden/frost
[^2]: @pine613さんが紹介されたKemal https://speakerdeck.com/pine613/crystal-teshi-ji-falseuehusahisuhazuo-rerufalseka
[^3]: Awesome Crystal https://github.com/veelenga/awesome-crystal

尚、本章でのサンプルはCrystal ver0.17.4で確認しております。
また、説明に使用したサンプルは以下に格納しております。

https://github.com/ucmsky/kemal-sample

## Kemal

Crystalで現在最も活発に開発されているWebフレームワークがKemalです。RubyでいうところのSinatra風の設計を思想で作られており、シンプルな実装でWebアプリを作成することが出来ます。

URL http://kemalcr.com/  
github https://github.com/sdogruyol/kemal  

### Kemalインストール

適当な作業用のディレクトリ以下で、以下のコードを実行してみます。ディレクトリが作成され幾つか雛形が作成されます。
（本稿ではサンプルアプリを「kemal-sample」として進めます）

```
crystal init app kemal-sample
cd kemal-sample
```

`shard.yml`ファイルに以下の内容を追記します。

```
dependencies:
  kemal:
    github: sdogruyol/kemal
    branch: master
```

以下のコマンドを実行することでKemal本体をインストールすることが出来ます。

```
shards install
```

### Kemal FirstStep

インストールまで問題なく動かせたら続いて簡単なサンプルを作成してみましょう。
カレントのsrcディレクトリ以下に以下の名前のファイルとディレクトリを作成します。

`src/kemal-sample.cr`
```
require "kemal"

# http://localhost:3000/ または
# http://localhost:3000/articles/ のどちらでもアクセスできるようにする
["/", "/articles"].each do |path|
  get path do |env|
    articles = [
      {"id" => 1, "title" => "title1", "body" => "body1"},
      {"id" => 2, "title" => "title2", "body" => "body2"},
      {"id" => 3, "title" => "title3", "body" => "body3"},
    ]

    render "src/views/index.ecr"
  end
end

Kemal.run
```

`src/views/index.ecr`
```
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8"/>
  <title>post item</title>
</head>
<body>
  <% articles.each do |article| %>
  <table>
    <tr>
      <td><%=article["title"] %></td>
    </tr>
    <tr>
      <td><%=article["body"] %></td>
    </tr>
  </table>
  <% end %>
</body>
</html>
```

記述したら、以下のコマンドでビルド、実行します。
```
crystal build --release src/kemal-sample.cr
./kemal-sample
```

ブラウザで「http://localhost:3000/」でアクセスします。
以下の内容が表示されていれば取り敢えず問題ありません。

```
title1
body1
title2
body2
title3
body3
```

また、「http://localhost:3000/articles」でアクセスしても同様の表示がされます。


### DBと連動する

Kemalで作ったアプリからDBにアクセスすることも出来ます。
kemal-pgもしくはkemal-mysqlを使用することでPostgreSQLか、もしくはMySQLを使用することが出来ます。
今回はPostgreSQLを使用します。

テーブル名:artiles

| カラム名 | 型     |
| -------  | -------|
| id       | serial |
| title    | text   |
| body     | text   |

DBを作成します。
```
createdb kemal_sample -O your_owner
```

DDLを作成しロードします。
`create_articles.sql`
```
create table articles (
  id serial primary key,
  title  text,
  body   text
);
```

```
psql -U postgres -d kemal_sample -f create_articles.sql
```

作成した後、`shard.yml`ファイルに以下の内容を追記します。

```
dependencies:
  kemal-pg:
    github: sdogruyol/kemal-pg
    branch: master
```

編集後、以下のコマンドを実行します。

```
shards install
```

### 投稿一覧ページの編集

本章からいよいよWebアプリらしく記事の一覧ページと詳細ページ、新規投稿ページをそれぞれ作成していきます。
また、全ページで共通で使用するテンプレートは別に作成し、テンプレートヘッダに新規投稿ページと投稿リストページヘのリンクを表示し、ページ内に各ページのコンテンツを表示するように修正していきます。

### レイアウトページの作成

まず雛形のページを`application.ecr`という名前で作成します。

`src/views/application.ecr`
```
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8"/>
  <title>kemal sample</title>
  <!-- bootstrapを使用する -->
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7" crossorigin="anonymous">
  <link rel="stylesheet" href="/css/custom.css">
</head>
<body>
<header class="navbar navbar-fixed-top navbar-inverse">
  <div class="container">
    <a id="logo">sample app</a>
    <nav>
      <ul class="nav navbar-nav navbar-right">
        <li><a href="/articles">ArticleList</a></li>
        <li><a href="/articles/new">新規投稿</a></li>
      </ul>
    </nav>
  </div>
</header>
  <div class="container">
    <%= content %>
  </div>
</body>
</html>
```

本サンプルではBootStrapを使用します。CDNを使用しますので特にダウンロード不要ですが、ダウンロードする場合は別途「 http://getbootstrap.com/ 」から必要なファイルをダウンロードし、プロジェクトカレントの/public以下に配置してください。

### CSSの作成

ページ修飾用のCSSを作成します。本サンプルではrails tutorial( http://railstutorial.jp/ )をそのまま参考にします。

`public/css/custom.css`
```
body {
  padding-top: 60px;
}

section {
  overflow: auto;
}

textarea {
  resize: vertical;
}

.center {
  text-align: center;
}

.center h1 {
  margin-bottom: 10px;
}

h1, h2, h3, h4, h5, h6 {
  line-height: 1;
}

h1 {
  font-size: 3em;
  letter-spacing: -2px;
  margin-bottom: 30px;
  text-align: center;
}

h2 {
  font-size: 1.2em;
  letter-spacing: -1px;
  margin-bottom: 30px;
  text-align: center;
  font-weight: normal;
  color: #777;
}

p {
  font-size: 1.1em;
  line-height: 1.7em;
}

#logo {
  float: left;
  margin-right: 10px;
  font-size: 1.7em;
  color: #fff;
  text-transform: uppercase;
  letter-spacing: -1px;
  padding-top: 9px;
  font-weight: bold;
}

#logo:hover {
  color: #fff;
  text-decoration: none;
}
```

### 一覧ページの修正

記事一覧ページを以下の内容で修正します。

`src/views/index.ecr`
```
<h2>Article List</h2>
<table class="table table-striped">
<thead>
  <tr>
    <td>title</td>
  </tr>
<tbody>
  <% articles.each do |article| %>
  <tr>
    <td><a href="/articles/<%=article["id"] %>" target="_top"><%=article["title"] %></a></td>
  </tr>
  <% end %>
</tbody>
</table>
```

### 新規投稿ページ

記事の記事投稿用のページを新規作成します。

以下のファイルを追加します。

`src/views/articles/new.ecr` データ追加用画面
```
<h2>新規投稿</h2>
<form method="post", action="/articles">
  <input type="text" name="title" size="10" maxlength="10" />
  <br />
  <br />
  <textarea name="body" cols="40" rows="4"></textarea>
  <br />
  <br />
  <input type="submit" value="post">
</form>
```

### 詳細ページ

一覧ページから記事タイトルをクリックした時に遷移する詳細ページを作成します。

`src/views/articles/show.ecr` データの詳細表示画面
```
<h2>Article</h2>
<% articles.each do |article| %>
  <h3><%=article["title"] %></h3>
  <p><%=article["body"] %></p>
<br />
<% end %>
```

### Kemalプログラム改修

`kemal-sample.cr`を以下の内容で修正します。

`src/kemal-sample.cr`
```
require "kemal"
# 注記
# 本サンプルではkemal-pgを直接requireしない
# https://github.com/sdogruyol/kemal-pg/issues/1
require "pg"
require "pool/connection"
pg = ConnectionPool.new(capacity: 25, timeout: 0.1) do
  PG.connect("postgres://your_owner@localhost:5432/kemal_sample")
end


["/", "/articles"].each do |path|
  get path do |env|
    conn = pg.connection
    # クエリの実行
    result = conn.exec({Int32, String, String}, "select id, title, body from articles")
    pg.release
    # ハッシュへの変換
    articles = result.to_hash
    render "src/views/index.ecr", "src/views/application.ecr"
  end
end

get "/articles/new" do |env|
  render "src/views/articles/new.ecr", "src/views/application.ecr"
end

post "/articles" do |env|
  # env.params.bodyでformのvalueを取得できます
  title_param = env.params.body["title"]
  body_param = env.params.body["body"]
  params = [] of String
  params << title_param
  params << body_param
  conn = pg.connection
  conn.exec("insert into articles(title, body) values($1::text, $2::text)", params)
  pg.release
  env.redirect "/"
end

get "/articles/:id" do |env|
  id = env.params.url["id"].to_i32
  params = [] of Int32
  params << id
  conn = pg.connection
  result = conn.exec({Int32, String, String}, "select id, title, body from articles where id = $1::int8", params)
  pg.release
  articles = result.to_hash
  render "src/views/articles/show.ecr", "src/views/application.ecr"
end

Kemal.run
```

`render "src/views/articles/show.ecr", "src/views/application.ecr"` の形式でecrファイルをレンダリングすることで、railsのようにファイルを入れ子の形で描画することが出来ます。

Webアプリ再起動後に`http://localhost:3000/`にアクセスすると、まだ記事が投稿されていないので空欄になっています。  
`http://localhost:3000/articles/new` にアクセスすると、タイトルと本文を入力する画面が表示されており、入力後に一覧に遷移すると成功です。  
記事タイトルをクリックすると詳細画面に遷移すると成功です。

### オブジェクトのCRUD

KemalはRESTfulに対応しており、get、post以外にも、put、delete、patchにも対応しております。  
記事編集機能をサンプルに追加しながら説明します。  

新規ページで`src/views/articles/edit.ecr` を追加します。  
また、記事詳細ページからedit.ecrへのリンクを追加します。

`src/views/articles/show.ecr` データの詳細表示画面
```
<h2>Article</h2>
<% articles.each do |article| %>
  <h3><%=article["title"] %></h3>
  <p><%=article["body"] %></p>
<br />
<!-- 追加 -->
<a href="/articles/<%=article["id"] %>/edit" target="_top" class="btn btn-primary">edit</a>
<% end %>
```

`src/views/articles/edit.ecr` データの編集画面
```
<h2>投稿編集</h2>
<% articles.each do |article| %>
<form method="post", action="/articles/<%=article["id"] %>">
  <!-- hiddenフィールドにname="_method"、valueにputを設定する。 -->
  <input type="hidden", name="_method", value="put" />
  <input type="text" name="title" size="10" maxlength="10" value="<%=article["title"] %>" />
  <br />
  <br />
  <textarea name="body" cols="40" rows="4"><%=article["body"] %></textarea>
  <br />
  <br />
  <input type="submit" value="edit" class="btn btn-primary">
</form>
<% end %>
```

ブラウザによってはformがget、post以外には対応していない場合、以下のhiddenフィールドの設定でputやdeleteで送信することが出来ます。

`kemal-sample.cr`を以下の内容で修正します。

`src/kemal-sample.cr`
```
(中略)
get "/articles/:id/edit" do |env|
  id = env.params.url["id"].to_i32
  params = [] of Int32
  params << id
  conn = pg.connection
  result = conn.exec({Int32, String, String}, "select id, title, body from articles where id = $1::int8", params)
  pg.release
  articles = result.to_hash
  render "src/views/articles/edit.ecr", "src/views/application.ecr"
end

put "/articles/:id" do |env|
  id = env.params.url["id"].to_i32
  title_param = env.params.body["title"]
  body_param = env.params.body["body"]
  params = [] of String | Int32
  params << title_param
  params << body_param
  params << id
  conn = pg.connection
  conn.exec("update articles set title = $1::text, body = $2::text where id = $3::int8", params)
  pg.release
  env.redirect "/articles/#{id}"
end

Kemal.run
```

これで、データの追加から一覧表示、データの編集までの一連の流れが行えるようになります。


## Herokuへのデプロイ

Crystalで作成したアプリをHerokuにデプロイすることが出来ます。
いくつかビルドバックが公開されていますが、以下の点が満たせなかったので自作しました。

- デプロイに使用するCrystalのバージョンは任意で指定したい
- ビルドするファイル名は適宜指定したい
- ビルド時の環境変数を適宜指定したい
- ビルドオプションは適宜指定したい

URLは以下のとおりです。

heroku-buildpack-crystal
https://github.com/ucmsky/heroku-buildpack-crystal

実装にあたってはElixirのビルドパックを参考にさせていただきました。

heroku-buildpack-elixir
https://github.com/HashNuke/heroku-buildpack-elixir

### ビルドパックの使い方

Herokuアプリ作成時に以下のコマンドを実行します。

```
heroku create --buildpack "https://github.com/ucmsky/heroku-buildpack-crystal.git"
```

本ビルドパックではCrystalのバージョンやビルドコマンドを適宜指定するため、コンフィグファイルをリポジトリに加える必要があります。
コンフィグファイルはファイル名を`crystal_buildpack.config`として設定します。
以下の設定をファイルに記述します。

設定例
```
# Crystal version
# 使用するCrystalのバージョン（必須）
crystal_version=0.17.4

# Always rebuild from scratch on every deploy?
# ダウンロードしたCrystal本体などをクリアし再ダウンロードするか
#  Crystalのバージョンを変えてリビルドするときはtrueに設定する
always_rebuild=false

# Export heroku config vars
# ビルド時に渡されるHerokuの環境変数
config_vars_to_export=(DATABASE_URL)

# A command to run right after compiling the app
# コンパイル後に実行するコマンド
# 必要なければ未設定で可
post_compile="pwd"

# Build command
# デプロイ時にビルドするコマンドを設定（必須）
# 複数設定可能でその場合は空白区切りで記述
build_command=("make db_migrate" "make build")
```

尚、ファイルは作成しなくても動かせますが、その場合以下の設定がデフォルトで適用されます。

```
# Use latest version
crystal_version=latest

# ダウンロードしたCrystal本体は再ダウンロードしない
always_rebuild=false

# ビルド時に渡される環境変数は"DATABASE_URL"
config_vars_to_export=(DATABASE_URL)

# ビルドコマンドは"make run"
build_command=("make run")
```

### アプリのデプロイ

では実際にデプロイするまでを行ってみます。
まず前項でも記載しましたが、以下のコマンドでHerokuにアプリを作成します。
（アプリ名は任意で、重複しなければなんでも構いません）

```
heroku create kemal-sample-160601 --buildpack "https://github.com/ucmsky/heroku-buildpack-crystal.git"
```

データベースを設定します。PostgreSQLを追加します。（Hobbyパックが指定されます）

```
heroku addons:add heroku-postgresql
```

設定したら、PostgreSQLのURLをアプリ側に適用します。

`src/kemal-sample.cr`
```
require "kemal"
require "pg"
require "pool/connection"
pg = ConnectionPool.new(capacity: 25, timeout: 0.1) do
  PG.connect(ENV["DATABASE_URL"])
end
```

HerokuのPostgerSQLにテーブルを作成します。

```
heroku pg:psql
kemal-sample-160601::DATABASE=> \i /path/to/file/create_articles.sql
```

configファイルとProcfileを作成し、Herokuにpushします。

`crystal_buildpack.config`
```
crystal_version=0.17.4
always_rebuild=false
config_vars_to_export=(DATABASE_URL)
post_compile="pwd"
build_command=("crystal build --release ./src/kemal-sample.cr")
```

`Procfile`
```
web: ./kemal-sample -p $PORT -b 0.0.0.0
```

```
git add .
git commit -m "add"
git push heroku master
```

デプロイ後に`https://kemal-sample-160601.herokuapp.com/`にアクセスすると、エラーが表示されなく、かつ　`/articles/new`からデータが追加できれば成功です。

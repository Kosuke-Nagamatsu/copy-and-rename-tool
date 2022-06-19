# コピー・リネームツール
あるファイルを何千もコピーしたい。そう思いRubyのライブラリを調べたところ `FileUtilsモジュール` を使うことでできたので、残しておきます。小さいことかもしれませんが、作業負担が軽くなりとても嬉しかったです。

<br>

## やりたいこと
- 元となるファイルをコピーし、何千個のファイルを用意したい
- ファイル数ごとにディレクトリを分けたい
  例えば、2というディレクトリには2個、10というディレクトリには10個、100... のように分けたい
- ファイル名（aaa_bbb_ccc_bbb.pdf）のbbb部分を一意にしたい
  少し分かりにくいですが、bbbの部分だけ違う名前になるようにコピーしたい

<br>

## 方法
### 1. ファイル数ごとにディレクトリを作る
まずは各ディレクトリを用意します。手動でも良いのですが、組み込みライブラリのDirクラスを使ってみました。
https://docs.ruby-lang.org/ja/latest/class/Dir.html#S_MKDIR

```ruby
Dir.mkdir("data/#{number}")
```
`data/` に `#{number}` ディレクトリを作ります。`number` には各ファイル数（2, 10, 100...）を順番に渡しているため、2という名前のディレクトリ、10という名前のディレクトリ...が作られていきます。

<br>

### 2. 1.のディレクトリへファイルをコピーする
標準ライブラリのFileUtilsモジュールを使いました。
https://docs.ruby-lang.org/ja/latest/method/FileUtils/m/copy.html

```ruby
FileUtils.cp('コピー元', 'コピー先')
```

```ruby
FileUtils.cp('data/1/aaa_bbb_ccc_ddd.pdf', "data/#{number}/aaa_bbb#{index}_ccc_ddd.pdf")
```

`data/1/` にある `aaa_bbb_ccc_ddd.pdf` を 1.で作った `data/#{number}/` にコピーします。その際、`aaa_bbb#{index}_ccc_ddd.pdf` にリネームしています。これをコピーするファイルの数だけ繰り返します。

<br>

### 3. ファイル名（aaa_bbb_ccc_bbb.pdf）のbbb部分を一意にする
`bbb#{index}` の `index` を1ずつ増やし、違う名前にしています。

<br>

## 実行手順
numbersの値を用意したいファイル数に編集します。

```ruby
# 2, 100, 1000のセット
numbers = [2, 100, 1000]

# 3000だけ
numbers = [3000]
```

デフォルト
```ruby
numbers = [2, 10, 100, 1000, 2000, 3000]
```

実行

```
ruby copy_and_rename.rb
```

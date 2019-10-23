---
layout: post
title: Javaの検査例外と非検査例外について
tags: [java, exception]
type: article
description: "Javaの検査例外と非検査例外について自分の理解をまとめてみた。"
---

Javaの検査例外と非検査例外について自分の理解をまとめてみた。  
なおJava初心者が書いた記事であり間違っている可能性も大いにあるのでご容赦を。

<!-- more -->

## 検査例外と非検査例外の違い

* 非検査例外(unchecked exception)
  - 例: NullPointerExceptionなど
  - 大体の言語には非検査例外しかない
  - java.lang.RuntimeExceptionのサブクラス
  - プログラミングエラーで関数が想定外の使われ方をしている場合にthrowされる例外
      + 例: 型の違う変数を引数に渡している
  - プログラミングエラーになる原因はゴマンとあり予め想定できないので、  
    callerに例外ハンドリングをさせず実行を止める
* 検査例外(checked exception)
  - 例: IOExceptionなど
  - java.lang.Exceptionのサブクラス
  - プログラミングエラーがなく想定通りの使われ方をしてもthrowされる例外
      + 例: ディスク容量に空きがないのでファイルの書き込みができない
  - 予め想定されうる例外なので、callerに例外ハンドリングを強制して対処(回復)させる


## 例

### 検査例外

```java
class Example {

    public static void main (String[] args) {
        Example.methodA();
    }

    public static void methodA() {
        throw new Exception("throws checked exception");
    }
}
```

```sh
$ javac Example.java && java Example
Example.java:8: error: unreported exception Exception; must be caught or declared to be thrown
        throw new Exception("throws checked exception");
        ^
1 error
```

checked exceptionは投げるだけではコンパイルエラーになる。

```java
class Example {

    public static void main (String[] args) {
        Example.methodA();
    }

    public static void methodA() throws Exception {
        throw new Exception("throws checked exception");
    }
}
```

```sh
$ javac Example.java && java Example
Example.java:4: error: unreported exception Exception; must be caught or declared to be thrown
        Example.methodA();
                       ^
1 error
```

calleeのメソッド定義に`throws`を書くだけではコンパイルエラー。

```java
class Example {

    public static void main (String[] args) {
        try {
            Example.methodA();
        } catch (Exception e) {
            System.err.println(e.getMessage());
        }
        System.out.println("finished");
    }

    public static void methodA() {
        throw new Exception("throws checked exception");
    }
}
```

```sh
$ javac Example.java && java Example
Example.java:13: error: unreported exception Exception; must be caught or declared to be thrown
        throw new Exception("throws checked exception");
        ^
1 error
```

callerで`catch`するだけでもコンパイルエラー。


```java
class Example {

    public static void main (String[] args) {
        try {
            Example.methodA();
        } catch (Exception e) {
            System.err.println(e.getMessage());
        }
        System.out.println("finished");
    }

    public static void methodA() throws Exception {
        throw new Exception("throws checked exception");
    }
}
```

```sh
$ javac Example.java && java Example
throws checked exception
finished
```

calleeのメソッド定義に`throws`を加え、callerで検査例外をcatchする必要がある。

```java
class Example {

    public static void main (String[] args) {
        try {
            Example.methodA();
        } catch (Exception e) {
            System.err.println(e.getMessage());
        }
        System.out.println("finished");
    }

    public static void methodB() throws Exception {
        throw new Exception("throws checked exception");
    }

    public static void methodA() throws Exception {
        methodB();
    }
}
```

callerでcatchせず`throws`を定義することで、さらに上位のcallerに例外を流すこともできる。

### 非検査例外

```java
class Example {

    public static void main (String[] args) {
        Example.methodA();
    }

    public static void methodA() {
        throw new RuntimeException("throws unchecked exception");
    }
}
```

```sh
$ javac Example.java && java Example
Exception in thread "main" java.lang.RuntimeException: throws unchecked exception
        at Example.methodA(Example.java:8)
        at Example.main(Example.java:4)
```

非検査例外はcalleeで投げるだけでよく、callerはcatchしない（するべきではない？）。

## 感想

検査例外によってcalleeの内部に閉じておくべきものが  
callerに見えてしまっている気がする。  
callerでは下位のレイヤーを意識したくないのに、対処を強制されている感じ。  
callerは下位レイヤーの知識がないので  
catchしてもどうそれに対処すればいいのかとなるような。。。

結局callerに例外ハンドリングを強制するのではなく、  
calleeで非検査例外を投げて実行を止める方がいいのでは、と思ってしまう。

## 参考URL

* [Java のチェック例外と非チェック例外の考察まとめ - 全力で怠けたい](http://ebc-2in2crc.hatenablog.jp/entry/20120729/1343557350)
* [Javaの検査例外は、呼び出し側の責任でない異常系 - Qiita](http://qiita.com/yuba/items/d41290eca726559cd743)
* [【Effective Java】項目５８：回復可能な状態にはチェックされる例外を、プログラミングエラーには実行時例外を使用する - The King's Museum](http://hjm333.hatenablog.com/entry/2016/07/26/223044)
* [Java/Androidにおける例外設計、あるいは「契約による設計」によるシンプルさの追求 - Qiita](http://qiita.com/yuya_presto/items/3b651d6b0cf38f77e933)

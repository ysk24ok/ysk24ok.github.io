---
layout: slide
title: python_unittest
---

## Pythonでテストを書くにあたって

---
### 背景
- - -
* データサイエンスチームではPythonを採用

* テスト仕様書に基づいてテストコードを書きたい

* テストフレームワークの種類、
  書き方などを改めて確認・共有

* ゆくゆくはテスト自動化

---
### テストを書くメリット
- - -

* テストのしやすさを意識することで見やすいコードになる
  - 1つのメソッドに1つの処理
* テストを見れば期待される実行結果が分かる
* テストの存在により、変更・追加・リファクタが容易になる
  - 壊れたら怖いから触るのやめとこう、がなくなる

---
### 今日話す事・話さない事
- - -

* 話す事
  - unittest
  - nose
  - mocking
* 話さない事
  - pytest

---
### What's unittest ?
- - -

* Python2系・Python3系の標準テストライブラリ
  - JUnit、PHPUnitなどと似ている(というかほぼ同じ？)
* 命名規則
  - テストクラスはunittest.TestCaseを継承
  - テストメソッドはtest_*で始める


---
### ディレクトリ構成
- - -

```bash
$ tree .
operation2
└─ bin
       └─ cron
              └─ python
                      ├─ calc.py    # Pythonバッチスクリプト
                      └─ tests
                              └─ test_calc.py   # それに対応するテストスクリプト
```

---
### テストフィクスチャ・テストケース
- - -

```python
### calc.py
class Calc(object):
    def __init__(self, num):
        self._num = num

    def func1(self, x):
        return self._num + x
```


```python
### tests/test_calc.py
import unittest
import calc     # PYTHONPATHにパス指定する必要あり

class TestCalc(unittest.TestCase):
    def setUp(self):    # 初期化処理
        self._calc = calc.Calc(5)

    def test_func1(self):
        self.assertEqual(self._calc.func1(3), 8)

    def tearDown(self):   # 終了処理
        pass

if __name__ == "__main__":
      unittest.main()
```

---
### テストファイルをmainとして実行
- - -

```bash
### success
$ python3 tests/test_calc.py
.
----------------------------------------------------------------------
Ran 1 test in 0.000s

OK
```

```bash
### fail
$ python3 tests/test_calc.py
F
======================================================================
FAIL: test_func1 (__main__.TestCalc)
----------------------------------------------------------------------
Traceback (most recent call last):
  File "tests/test_calc.py", line 14, in test_func1
    self.assertEqual(self._calc.func1(3), 7)
AssertionError: 8 != 7

----------------------------------------------------------------------
Ran 1 test in 0.001s

FAILED (failures=1)
```

---
### テストファイルをモジュールとして実行
- - -

```bash
### unittestモジュールをmainとしてモジュール単位で実行
$ python3 -m unittest tests.test_calc

### クラス単位で実行
$ python3 -m unittest tests.test_calc.TestCalc
```

* PYTHONPATHを指定する必要がない
* if __name__ == "__main__":を記述する必要がない

ことから、この書き方を推奨

---
### テストディスカバリ
- - -

```bash
### 指定したディレクトリ内のテストを自動実行
$ python3 -m unittest discover -s tests
```

---
### テストスイート
- - -

```python
import unittest
import test_calc

if __name__ == "__main__":
    suite = unittest.TestSuite()
    # テストメソッド単位で追加
    suite.addTest(test_calc.TestCalc('test_func1'))
    # テストクラス単位で追加
    suite.addTest(unittest.makeSuite(test_calc.TestCalc))
    # テストスイートを実行
    unittest.TextTestRunner().run(suite)
```


---
### unittestの問題点
- - -

* テストファイルを作成するたびにunittest.TestCaseを継承しなければならない
* ディスカバリが再帰検索してくれない
* カバレッジを表示できない

---
### Yet Another Python Test Fremework
- - -

# nose

```bash
$ pip3 install nose
```

---
### What's nose ?
- - -

* unittestベース
* OSSでも採用されている(らしい)
* 命名規則に基づき再帰的にテストを実行
* 命名規則
  - ディレクトリ名・ファイル名はtest*で始める
  - テストクラスはTest*で始める
  - メソッド名はtest*で始める

---
### ディレクトリ構成
- - -

```bash
$ tree .
operation2
└─ bin
       └─ cron
              └─ python
                      ├─ calc.py
                      └─ tests
                              └─ test_calc.py
                              └─ test_others
                                        └─ test_func.py   # unittestでは見つけられない

```

---
### 書き方
- - -

```python
### calc.py
class Calc(object):
    def __init__(self, num):
        self._num = num
    def func1(self, x):
        return self._num + x
```

```python
### tests/test_calc.py
from nose.tools import with_setup, eq_
import calc

class Fixtures(object):
    @classmethod
    def setup(cls):
        cls.calc = calc.Calc(5)
    @classmethod
    def teardown(cls):
       cls.calc = None

@with_setup(Fixtures.setup, Fixtures.teardown)
def test_func1():
    eq_(Fixtures.calc.func1(3), 7, "not equal!!")
```

---
### unittestも実行できる
- - -

```python
### tests/test_others/test_func1.py
import unittest
import calc

def func2(x):
    return x + 100

class TestFunc(unittest.TestCase):
    def test_func1(self):
        self.assertEqual(func2(3), 102)
```

---
### 実行
- - -

```bash
$ nosetests -v tests/
test_calc.TestCalc.test_func1 ... FAIL
test_func1 (test_func.TestFunc) ... FAIL

======================================================================
FAIL: test_calc.TestCalc.test_func1
----------------------------------------------------------------------
Traceback (most recent call last):
  File "/usr/local/lib/python3.4/site-packages/nose/case.py", line 198, in runTest
    self.test(*self.arg)
  File "/Users/yusuke-nishioka/nose/python/tests/test_calc.py", line 15, in test_func1
    assert self._calc.func1(3) == 7
AssertionError

======================================================================
FAIL: test_func1 (test_func.TestFunc)
----------------------------------------------------------------------
Traceback (most recent call last):
  File "/Users/yusuke-nishioka/nose/python/tests/test_others/test_func.py", line 9, in test_func1
    self.assertEqual(func2(3), 102)
AssertionError: 103 != 102

----------------------------------------------------------------------
Ran 2 tests in 0.011s

FAILED (failures=2)
```

---
### unittest v.s. nose
- - -

* noseでは再帰検索でテストを実行できる
  - 1コマンドで済む
* noseではunittest.TestCaseを継承するという制約がない
  - ただし、テストケースに毎回デコレータをつける必要がある
  - 裏を返せばテストケースごとに初期化処理を変更できる
* カバレッジを表示できる(pip3 install coverage)

## => noseの方が良さげ


---
### 基本ルール
- - -

* noseを採用
  - 1バッチスクリプトにつき1テストモジュール
  - テストモジュール名(ファイル名): test_[テストしたいバッチファイル名].py
  - テストクラス名: Test*
  - テストメソッド名: test_*

---
### mockingについて
- - -

* unittest.mock
  - 外部のサービス(DB、その他APIなど)に依存せずテストするための仕組み

---
### ディレクトリ構造
- - -

```bash
$ tree .
operation2
└─ bin
       └─ cron
              └─ python
                      ├─ get_rows.py
                      └─ tests
                              └─ test_get_rows.py
```

---
### DBアクセス
- - -

```python
# get_rows.py
class Calc(object):
    def select_all(self, dbh):
        cursor = dbh.cursor()
        sql = "SELECT * FROM users"
        cursor.execute(sql)

        grouped = {}
        for rows in cursor.fetchall():
            # こねくり回す
        return grouped

if __name__ == "__main__":
    calc = Calc()
    calc.select_all(dbh)
```

---
### DBアクセステスト
- - -

```python
from nose.tools import with_setup
from unittest.mock import MagicMock
import get_rows

class Fixtures(object)
    @classmethod
    def setup(cls):
        cls.mock = MagicMock()    # db handlerを模したmockを作成
        cls.mock.cursor().fetchall.return_value = [
            [1, "Giants"], [2, "Tigers"],
        ]
        cls._calc = get_rows.Calc()
    def teardown(cls):
        pass

@with_setup(Fixtures.setup, Fixtures.teardown)
def test_select_all(self):
    grouped = get_rows.select_all(Fixtures.mock)
    # こねくり回した結果が期待した通りかチェック
```


---
### 参考ページ
- - -
* unittest
  - http://docs.python.jp/3/library/unittest.html#unittest.TestSuite
  - http://akiyoko.hatenablog.jp/entry/2015/01/01/212712

* nose
  - http://momijiame.tumblr.com/post/70768835863/python-nose-coverage
  - http://momijiame.tumblr.com/post/23042509434/python-nose
  - http://chocolapod.sakura.ne.jp/blog/entry/80

* mock
  - http://momijiame.tumblr.com/post/22379282563/pymox-python


---

ご清聴ありがとうございました

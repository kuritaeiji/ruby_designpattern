# 1. Template Method
  クラス内で状況によって一部のアルゴリズムを、いくつものパターンに変更したい時は、サブクラスを用いる。
  サブクラスにはアルゴリズムを変更したいメソッドのみを定義し、スーパークラスには共通のメソッド+フックメソッドを定義する。
  サブクラスの選択によってアリゴリズムを変更できる。
  つまりアルゴリズムを一部変更したいときは各々のサブクラスに責任を押し付ければ良い
# 2. Strategy
　クラス内で状況によって一部のアルゴリズムを、いくつものパターンに変更したい時は、ストラテジーを用いる。
  状況によって変化する一部のアルゴリズムをストラテジーへ移譲する。
  コンテキストはストラテジーをもちストラテジーを切り替えることによって、多様性をもたらす。
  状況により一部のアルゴリズムが変化する場合、そのアルゴリズムをサブクラスに押し付けるとテンプレートメソッドになり、ストラテジーに押し付けるとストラテジーバターンになる。
  また、押し付けるアルゴリズムが一つの場合はProcオブジェクトが使える。
# 3. Observer
  あるオブジェクトのデータが変化したとき、変化したことを他のオブジェクトに通知したいときはオブザーバーパターンを用いる。
  通知を発信するsubjectは通知を受け取るobserverを持ち、observerにメッセージを送る。
  railsの場合はコールバックもしくはオブザーバーにより実現する。   　　      　https://www.techscore.com/blog/2012/12/25/rails%E3%81%AE%E3%82%AA%E3%83%96%E3%82%B6%E3%83%BC%E3%83%90%E3%81%BE%E3%81%A8%E3%82%81/

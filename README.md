# 1. Template Method
  クラス内で状況によって一部のアルゴリズムを、いくつものパターンに変更したい時は、サブクラスを用いる。
  サブクラスにはアルゴリズムを変更したいメソッドのみを定義し、スーパークラスには共通のメソッド+フックメソッドを定義する。
  サブクラスの選択によってアリゴリズムを変更できる。
  つまりアルゴリズムを一部変更したいときは各々のサブクラスに責任を押し付ければ良い
# 2. Strategy
　クラス内で状況によって一部のアルゴリズムを、いくつものパターンに変更したい時は、ストラテジーを用いる。
  状況によって変化する一部のアルゴリズムをストラテジーへ移譲する。
  コンテキストはストラテジーをもちストラテジーを切り替えることによって、多様性をもたらす。
  状況により一部のアルゴリズムが変化する場合、そのアルゴリズムをサブクラスに押し付けるとテンプレートメソッドパターンになり、ストラテジーに押し付けるとストラテジーバターンになる。
  また、押し付けるアルゴリズムが一つの場合はProcオブジェクトが使える。
# 3. Observer
  あるオブジェクトのデータが変化したとき、変化したことを他のオブジェクトに通知したいときはオブザーバーパターンを用いる。
  通知を発信するsubjectは通知を受け取るobserverを持ち、observerにメッセージを送る。
  railsの場合はコールバックもしくはオブザーバーにより実現する。   　　      　https://www.techscore.com/blog/2012/12/25/rails%E3%81%AE%E3%82%AA%E3%83%96%E3%82%B6%E3%83%BC%E3%83%90%E3%81%BE%E3%81%A8%E3%82%81/
# 4.Composit
  あるオブジェクトが複数のオブジェクトから成る時は、compositパターンを使う。compositパターンでは、全体の基底クラスとなるcomponentと、複数のオブジェクトを持つcomposit、オブジェクトを持たないleafから成る。
  compositを定義するcompositクラスが作られる時もある。compositパターンで注意すべきことは二つある。一つ目はこオブジェクトについてだけで無く、親オブジェクトの情報も持たせること。二つ目は、ツリーの深さが一段しか
  存在しないと思わないことである。ツリーの深さが二段以上ある時はツリーを再帰的に下るようにする。
  railsの場合はhas_manyやbelongs_toによってcompositを実現している。
# 5.Iterator
  あるコレクションの要素に順にアクセスする方法を提供するのがIterator。iteratorには内部イテレーターと外部イテレーターがある。
# 6.Command
  アルゴリズムを一部変更したい時は、commandパターンが使える。また、一連の複数の命令を実行させたい時もcommandパターンを使える。commandパターンは複数の命令のリストを保存でき、元に戻したい時も元に戻せる機能も追加
  できる。commandパターンはcompositパターンと相性が良い。
# 7.Adapter
  あるクライアントがあるターゲットを参照しているが、ターゲットはクライアントが要求するインターフェイスを実装していない場合はadapterパターンが使える。adapterパターンはインスタンス変数としてターゲットをもち、足りないインターフェイスを実装しているクラスである。また、rubyでは実行時にクラスを上書きできるため単純であればクラスを上書きするか、インスタンスに特異メソッドを定義する。
# 8.Proxy
  proxyパターンでは、proxyオブジェクトが本物のオブジェクト(subject)を持ち、同じインターフェイスを持つ。そのインターフェイスはsubjectへと移譲しているだけ。proxyには3つの役割がある。1つ目はリモートプロキシである。
  オブジェクトやデータがネットワーク越しにある時、クライアントサイドではプロキシを使ってオブジェクトやデータにアクセスする。javascriptではaxiosなどがプロキシにあたる。2つ目は防御プロキシである。アクセス制御をする。railsではコントローラーに当たる。3つ目は仮想プロキシである。オブジェクトのメソッドが呼び出される直前まで、オブジェクトの生成を遅らせる目的で使われる。
# 9.Decorator
  デコレーターパターンはオブジェクトやクラスに機能を追加するために使われる。機能を追加するクラスをデコレータークラスが持ち、デコレータークラスは機能を追加するクラスに引数を変えて移譲する。
  rubyではメタプログラミングが使えるため、エイリアスメソッドチェインやモジュールをオブジェクトに追加することで機能を追加できる。
# 10.Singleton
  シンクルトンパターンはクラスのインスタンスがグローバルに使われ、プログラム内で唯一の存在である時に使われるパターンである。singletonの作り方はクラスインスタンス変数に唯一のインスタンスを代入し、instanceクラスメソッドが呼ばれたときのみに遅延生成し、newメソッドはプライベートメソッドにする。モジュールやクラス自身をオブジェクトに見立てることでもsingletonを作れる。sngletonパターンはグローバルに使われるため密結合しやすい。よって
singletonが使われる箇所は限定しなければならない。
# 11.Factory
  あるクラスが多くのオブジェクトを持つ時にはfactoryパターンが使える。factoryパターンにはfactory_methodとabstract_factoryの２種類がある。factory_methodはtemplate_methodのようにサブクラスにオブジェ   クトを作る責任を押し付け、abstract_factoryはstrategyのように外部のオブジェクトにオブジェクトを作る責任を押し付ける。引数にクラスを持たせることで動的に作成するオブジェクトを変更できる。
# 12.Builder
  あるクラスを作る労力が大きい時にはbuilderパターンが使える。builderクラスはinitializeで作りたいオブジェクトの標準を持ち、その後builderのメソッドを呼び出していくことで、オブジェクトを作成する。また、builderから作成したオブジェクトを返す時に作成したオブジェクトの妥当性も検証することができる。マジックメソッドを使ってメソッド名を解析し、それに基づいてメソッドを呼び出すことでオブジェクトを作成することもできる。builderパターンは作成する労力の大きいオブジェクトに使い、factoryパターンは適切にオブジェクトを組み合わせることが難しい時に使う。
# 13.Interpreter
  interpreterパターンはcompositパターンを特化したパターンであり、再起的に下って動作する。式からASTを作るためにパーサーも使えるが、パーサーを作る労力を考えると無くても良い。

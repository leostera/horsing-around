actor A
  new create(env: Env) =>
    let b = B(env)
    let c = Counter(0) // 0
    b.print(c.incr())  // 1
    b.print_counter(c.value()) // { _i: 1 }

actor B
  let e: Env

  new create(env: Env) =>
    e = env

  be print(i: U128) =>
    i

  be print_counter(c: Countable iso) =>
    c.get()

trait Countable
  fun get(): U128

class val CounterValue is Countable
  let _i : U128

  new create(startValue : U128) =>
    _i = startValue

  fun get() : U128 =>
    _i

class ref Counter is Countable
  var _i : U128 = 0

  new create(startValue : U128) =>
    _i = startValue

  fun value(): Countable =>
    CounterValue(_i)

  fun ref incr(): U128 =>
    _i = _i + 1

  fun get(): U128 =>
    _i

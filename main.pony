/**
  We are using an Actor to initalize the program and orchestrate
  some classes and primitives.
*/
actor Main
  new create(env: Env) =>
    Saluter.create(env)

actor Saluter is Salutes
  new create(env: Env) =>  
    salute(env)

  be salute(env: Env) =>  
    let w = Wombat.withHunger("Tombat", Starved)
    let s = Utils.salute(w)
    env.out.print(s)
    let h = Utils.isHungry(w)
    env.out.print(h)

/** Probably wrong way of encoding this in Pony */
trait Some[Value]
  fun some(): Value
type Option[A] is (Some[A] | None) 


/**
  We can use primitives to group functions too.
  */
primitive Utils
  fun salute(w: Named): String =>
    "Hello there, " + w.name() + "!"

  fun isHungry(w: Starvable): String =>
    match w.hunger()
    | Starved => "You seem hungry!"
    | Satiated => "You seem satiated"
    end

/**
  We use primitive values without any functions to signify
  markers.

  We can put them together in a type alias with a | to turn them
  into enumerations.
  */
primitive Starved
primitive Satiated
type Hunger is (Starved | Satiated)


/**
  We can use traits for nominal subtyping, and interfaces for
  structural subtyping.

  We can define aliases, such as Pet, to mean products of traits,
  such as "both Named and Starvable".
*/
trait Salutes
  be salute(env: Env)
trait Named
  fun name() : String
trait Starvable
  fun hunger(): Hunger
interface HasName
  fun name(): String
type Pet is (Named & Starvable)


class Wombat is Pet
  let _name : String
  var _hunger : Hunger

  new create(name' : String) =>
    _name = name'
    _hunger = Satiated 

  new withHunger(name' : String, hunger' : Hunger) =>
    _name = name'
    _hunger = hunger'

  fun hunger(): Hunger => _hunger

  fun name(): String => _name

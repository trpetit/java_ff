-- Seed data for local development (loaded at startup into the in-memory H2 database).
-- All users have the password "Password1!".
-- IDs stay below 1000 so they never collide with generated IDs (identity columns start at 1000).

INSERT INTO users(id, name, email, password, bio, image) VALUES
    (1, 'lambda_lucy', 'lambda_lucy@example.com', '$2a$10$rkqKwmjX.N7wYH/rkl2o0.361vOhLgSVLnxCiYhaGrh.WHiOWAlDa', 'Scala developer, recovering Java programmer. I write about making functional programming approachable.', 'https://api.dicebear.com/9.x/initials/svg?seed=lambda_lucy'),
    (2, 'monad_max', 'monad_max@example.com', '$2a$10$rkqKwmjX.N7wYH/rkl2o0.361vOhLgSVLnxCiYhaGrh.WHiOWAlDa', 'Typelevel enthusiast. Cats, Cats Effect and fs2 all day long.', 'https://api.dicebear.com/9.x/initials/svg?seed=monad_max'),
    (3, 'curry_carla', 'curry_carla@example.com', '$2a$10$rkqKwmjX.N7wYH/rkl2o0.361vOhLgSVLnxCiYhaGrh.WHiOWAlDa', 'Teaching FP at university. Haskell by night, Scala by day.', 'https://api.dicebear.com/9.x/initials/svg?seed=curry_carla'),
    (4, 'typelevel_tom', 'typelevel_tom@example.com', '$2a$10$rkqKwmjX.N7wYH/rkl2o0.361vOhLgSVLnxCiYhaGrh.WHiOWAlDa', 'Type-level programming, Scala 3 metaprogramming and other dark arts.', 'https://api.dicebear.com/9.x/initials/svg?seed=typelevel_tom'),
    (5, 'effect_eva', 'effect_eva@example.com', '$2a$10$rkqKwmjX.N7wYH/rkl2o0.361vOhLgSVLnxCiYhaGrh.WHiOWAlDa', 'ZIO contributor. Building resilient backends one effect at a time.', 'https://api.dicebear.com/9.x/initials/svg?seed=effect_eva');

INSERT INTO user_followings(follower_id, followee_id) VALUES
    (1, 2),
    (1, 3),
    (1, 5),
    (2, 4),
    (2, 1),
    (3, 1),
    (3, 4),
    (4, 2),
    (4, 5),
    (4, 3),
    (5, 2);

INSERT INTO tags(id, tag_value) VALUES
    (1, 'architecture'),
    (2, 'backend'),
    (3, 'beginners'),
    (4, 'category-theory'),
    (5, 'cats'),
    (6, 'cats-effect'),
    (7, 'concurrency'),
    (8, 'effects'),
    (9, 'error-handling'),
    (10, 'fs2'),
    (11, 'functional-programming'),
    (12, 'haskell'),
    (13, 'http4s'),
    (14, 'immutability'),
    (15, 'metaprogramming'),
    (16, 'monads'),
    (17, 'recursion'),
    (18, 'scala'),
    (19, 'scala3'),
    (20, 'streaming'),
    (21, 'testing'),
    (22, 'type-classes'),
    (23, 'types'),
    (24, 'zio');

INSERT INTO articles(id, author_id, title, slug, description, body, created_at, updated_at) VALUES (1, 1, 'Why Scala in 2026', 'why-scala-in-2026', 'A pragmatic look at where Scala shines today',
'Every few years someone declares Scala dead, and every few years it quietly keeps shipping.

## What Scala gives you

- **A strong type system** that catches whole classes of bugs at compile time
- **Immutability by default** in the standard collections
- **First-class functions** without ceremony
- **The JVM ecosystem**, plus Scala.js and Scala Native

## Scala 3 made it friendlier

```scala
enum Shape:
  case Circle(radius: Double)
  case Rectangle(width: Double, height: Double)

def area(shape: Shape): Double = shape match
  case Shape.Circle(r)       => math.Pi * r * r
  case Shape.Rectangle(w, h) => w * h
```

Optional braces, enums and a cleaner implicit story make the language much easier to pick up than it used to be.

If you care about correctness and expressiveness, Scala is still one of the best tools around.',
'2026-09-15 09:00:00', '2026-09-15 09:00:00');

INSERT INTO articles(id, author_id, title, slug, description, body, created_at, updated_at) VALUES (2, 3, 'Pure Functions Explained', 'pure-functions-explained', 'The single idea the rest of functional programming builds on',
'A function is **pure** when:

1. Its result depends only on its arguments
2. It has no observable side effects

```scala
// Pure
def add(a: Int, b: Int): Int = a + b

// Impure: reads and mutates outside state
var total = 0
def addToTotal(n: Int): Int =
  total += n
  total
```

## Why bother?

Pure functions are **referentially transparent**: you can replace a call with its result without changing the program. That makes code easier to test, to refactor and to reason about, especially when things run concurrently.

Of course, real programs need side effects. The trick in FP is not to avoid them, but to *describe* them as values and run them at the edge of the program. More on that in a later post.',
'2026-09-17 10:00:00', '2026-09-17 10:00:00');

INSERT INTO articles(id, author_id, title, slug, description, body, created_at, updated_at) VALUES (3, 2, 'A Gentle Introduction to Cats', 'a-gentle-introduction-to-cats', 'Type classes for everyday Scala code',
'[Cats](https://typelevel.org/cats/) is a library of abstractions for functional programming in Scala. You don''t need category theory to use it.

## Combining things with Semigroup

```scala
import cats.syntax.all.*

val merged = Map("a" -> 1, "b" -> 2) |+| Map("b" -> 3, "c" -> 4)
// Map(a -> 1, b -> 5, c -> 4)
```

## Validating with Validated

```scala
import cats.data.ValidatedNel

def validateName(name: String): ValidatedNel[String, String] =
  if name.nonEmpty then name.validNel else "name is empty".invalidNel

def validateAge(age: Int): ValidatedNel[String, Int] =
  if age >= 0 then age.validNel else "age is negative".invalidNel

(validateName(""), validateAge(-1)).mapN(Person.apply)
// Invalid(NonEmptyList(name is empty, age is negative))
```

Unlike `Either`, `Validated` accumulates **all** the errors instead of stopping at the first one.',
'2026-09-19 11:00:00', '2026-09-19 11:00:00');

INSERT INTO articles(id, author_id, title, slug, description, body, created_at, updated_at) VALUES (4, 5, 'Getting Started with ZIO 2', 'getting-started-with-zio-2', 'Your first steps with the ZIO effect system',
'A `ZIO[R, E, A]` is a description of a program that needs an environment `R`, may fail with `E` and succeeds with `A`.

```scala
import zio.*

object HelloApp extends ZIOAppDefault:
  val program: ZIO[Any, Throwable, Unit] =
    for
      _    <- Console.printLine("What is your name?")
      name <- Console.readLine
      _    <- Console.printLine(s"Hello, $name!")
    yield ()

  def run = program
```

Nothing happens when you *create* `program`. It only runs when the ZIO runtime executes it, which is what makes effects composable.

## Typed errors

Because the error type is part of the signature, the compiler tells you exactly which failures are handled:

```scala
val safe: ZIO[Any, Nothing, String] =
  ZIO.attempt(riskyCall()).orElseSucceed("fallback")
```',
'2026-09-21 12:00:00', '2026-09-21 12:00:00');

INSERT INTO articles(id, author_id, title, slug, description, body, created_at, updated_at) VALUES (5, 4, 'Opaque Types in Scala 3', 'opaque-types-in-scala-3', 'Zero-cost type safety for your domain',
'Mixing up a `UserId` and an `OrderId` when both are `Long` is an easy bug to write. Opaque types fix it without any runtime overhead.

```scala
object Ids:
  opaque type UserId = Long
  object UserId:
    def apply(value: Long): UserId = value

  extension (id: UserId) def value: Long = id

import Ids.*

def findUser(id: UserId): Option[User] = ???

findUser(UserId(42))   // compiles
findUser(42L)          // does not compile
```

Inside `Ids`, `UserId` *is* a `Long`. Outside, it is a distinct type. At runtime it''s just a `Long`: no boxing, no wrapper class.',
'2026-09-23 13:00:00', '2026-09-23 13:00:00');

INSERT INTO articles(id, author_id, title, slug, description, body, created_at, updated_at) VALUES (6, 3, 'Understanding Monads Without the Jargon', 'understanding-monads-without-the-jargon', 'flatMap is all you need',
'Forget burritos. A monad is a type with two operations:

- `pure`: put a value in a context
- `flatMap`: chain a computation that itself returns a context

You already use them:

```scala
val result: Option[Int] =
  for
    a <- Some(1)
    b <- Some(2)
  yield a + b
// Some(3)
```

The `for` comprehension is just sugar for `flatMap` and `map`. The same syntax works with `Option`, `Either`, `List`, `Future`, `IO`...

## The point

Each monad decides what "and then" means:

| Monad    | "and then" means                        |
|----------|-----------------------------------------|
| Option   | continue if there is a value            |
| Either   | continue if there is no error           |
| List     | continue for every element              |
| IO       | continue after the effect has run       |

That''s it. The laws just make sure chaining behaves predictably.',
'2026-09-25 09:00:00', '2026-09-25 09:00:00');

INSERT INTO articles(id, author_id, title, slug, description, body, created_at, updated_at) VALUES (7, 2, 'Cats Effect IO in Practice', 'cats-effect-io-in-practice', 'Resources, fibers and error handling with Cats Effect 3',
'Cats Effect''s `IO` is a pure description of a side-effecting computation.

## Safe resource handling

```scala
import cats.effect.*
import scala.io.Source

def lines(path: String): Resource[IO, Source] =
  Resource.fromAutoCloseable(IO.blocking(Source.fromFile(path)))

val count: IO[Int] = lines("data.txt").use(src => IO.blocking(src.getLines().size))
```

The file is closed whether `use` succeeds, fails or is cancelled.

## Lightweight concurrency

```scala
val both: IO[(User, List[Order])] =
  (fetchUser(id), fetchOrders(id)).parTupled
```

Fibers are cheap: you can run hundreds of thousands of them on a handful of threads.',
'2026-09-27 10:00:00', '2026-09-27 10:00:00');

INSERT INTO articles(id, author_id, title, slug, description, body, created_at, updated_at) VALUES (8, 1, 'Immutability Is a Feature', 'immutability-is-a-feature', 'Why val and immutable collections make code easier to trust',
'When a value can''t change, you never have to ask "who modified this?".

```scala
case class Account(owner: String, balance: BigDecimal)

val before = Account("lucy", 100)
val after  = before.copy(balance = before.balance + 50)
// before is untouched
```

## But isn''t copying slow?

Scala''s immutable collections use **structural sharing**: prepending to a `List` or updating a `Vector` reuses most of the existing structure. In practice the cost is small, and you get:

- thread safety for free
- trivially correct undo/history
- no defensive copies

Start with `val` everywhere and only reach for `var` when you have measured a reason to.',
'2026-09-29 11:00:00', '2026-09-29 11:00:00');

INSERT INTO articles(id, author_id, title, slug, description, body, created_at, updated_at) VALUES (9, 5, 'Dependency Injection with ZLayer', 'dependency-injection-with-zlayer', 'Wiring services together without a framework',
'ZIO''s `ZLayer` describes how to build a service from its dependencies.

```scala
trait UserRepo:
  def find(id: Long): Task[Option[User]]

final class UserService(repo: UserRepo):
  def greet(id: Long): Task[String] =
    repo.find(id).map(_.fold("Who are you?")(u => s"Hello, ${u.name}"))

object UserService:
  val layer: URLayer[UserRepo, UserService] = ZLayer.fromFunction(UserService(_))
```

Then at the edge of the app:

```scala
program.provide(UserService.layer, PostgresUserRepo.layer, DataSource.layer)
```

If a dependency is missing, you get a **compile-time** error telling you exactly which one. No reflection, no runtime surprises.',
'2026-10-01 12:00:00', '2026-10-01 12:00:00');

INSERT INTO articles(id, author_id, title, slug, description, body, created_at, updated_at) VALUES (10, 4, 'Type Classes in Scala 3 with given and using', 'type-classes-in-scala-3-with-given-and-using', 'The new syntax for an old and powerful pattern',
'Type classes let you add behaviour to types you don''t own.

```scala
trait Show[A]:
  extension (a: A) def show: String

given Show[Int] with
  extension (a: Int) def show = s"Int($a)"

given [A](using Show[A]): Show[List[A]] with
  extension (as: List[A]) def show = as.map(_.show).mkString("[", ", ", "]")

List(1, 2, 3).show
// [Int(1), Int(2), Int(3)]
```

## Deriving instances

```scala
case class Point(x: Int, y: Int) derives Show
```

`given` / `using` replace most uses of Scala 2 implicits and make the intent much clearer.',
'2026-10-03 13:00:00', '2026-10-03 13:00:00');

INSERT INTO articles(id, author_id, title, slug, description, body, created_at, updated_at) VALUES (11, 2, 'Streaming Data with fs2', 'streaming-data-with-fs2', 'Constant-memory processing of large inputs',
'[fs2](https://fs2.io) streams are pull-based, resource-safe and purely functional.

```scala
import fs2.io.file.{Files, Path}
import fs2.text

val wordCount: IO[Long] =
  Files[IO].readAll(Path("big.log"))
    .through(text.utf8.decode)
    .through(text.lines)
    .filter(_.contains("ERROR"))
    .compile
    .count
```

The file is read in chunks, so a 50 GB log uses about the same memory as a 50 KB one.

## Concurrency built in

```scala
stream.parEvalMap(maxConcurrent = 8)(enrich)
```

Back-pressure, cancellation and resource cleanup are all handled for you.',
'2026-10-05 09:00:00', '2026-10-05 09:00:00');

INSERT INTO articles(id, author_id, title, slug, description, body, created_at, updated_at) VALUES (12, 3, 'Recursion and Tail Calls', 'recursion-and-tail-calls', 'Looping the functional way without blowing the stack',
'Without mutable variables, loops become recursion.

```scala
def sum(xs: List[Int]): Int = xs match
  case Nil          => 0
  case head :: tail => head + sum(tail)
```

This works, but each call adds a stack frame: a long enough list throws `StackOverflowError`.

## Use an accumulator

```scala
import scala.annotation.tailrec

def sum(xs: List[Int]): Int =
  @tailrec
  def loop(rest: List[Int], acc: Int): Int = rest match
    case Nil          => acc
    case head :: tail => loop(tail, acc + head)
  loop(xs, 0)
```

`@tailrec` makes the compiler check that the recursive call is in tail position and turn it into a loop. If it isn''t, compilation fails.

And most of the time, `xs.foldLeft(0)(_ + _)` is all you need.',
'2026-10-07 10:00:00', '2026-10-07 10:00:00');

INSERT INTO articles(id, author_id, title, slug, description, body, created_at, updated_at) VALUES (13, 1, 'Pattern Matching Beyond switch', 'pattern-matching-beyond-switch', 'Destructuring, guards and exhaustiveness checks',
'Scala''s `match` is much more than a `switch` statement.

```scala
sealed trait Event
case class Login(user: String)                 extends Event
case class Purchase(user: String, total: Int)  extends Event
case object Heartbeat                          extends Event

def describe(e: Event): String = e match
  case Login(u)                     => s"$u logged in"
  case Purchase(u, t) if t > 1000   => s"$u made a big purchase!"
  case Purchase(u, t)               => s"$u spent $t"
  case Heartbeat                    => "still alive"
```

Because `Event` is `sealed`, the compiler **warns you when a case is missing**. Add a new event type and every non-exhaustive match lights up.

That one feature removes a whole category of production bugs.',
'2026-10-09 11:00:00', '2026-10-09 11:00:00');

INSERT INTO articles(id, author_id, title, slug, description, body, created_at, updated_at) VALUES (14, 5, 'Error Handling Without Exceptions', 'error-handling-without-exceptions', 'Option, Either and typed errors in effect systems',
'Exceptions are invisible in function signatures. Functional code makes failure explicit.

```scala
enum ParseError:
  case Empty
  case NotANumber(input: String)

def parseAge(s: String): Either[ParseError, Int] =
  if s.isEmpty then Left(ParseError.Empty)
  else s.toIntOption.toRight(ParseError.NotANumber(s))
```

Callers *must* deal with the `Left` case. They can''t forget, because the types won''t line up.

## Rules of thumb

- `Option` when absence is normal and needs no explanation
- `Either` when the caller needs to know *why*
- Typed errors in `ZIO` / `EitherT` when effects are involved
- Exceptions only for truly unrecoverable defects',
'2026-10-11 12:00:00', '2026-10-11 12:00:00');

INSERT INTO articles(id, author_id, title, slug, description, body, created_at, updated_at) VALUES (15, 4, 'Functors Applicatives and Monads', 'functors-applicatives-and-monads', 'A practical tour of the type class hierarchy',
'Each level of the hierarchy adds one capability.

## Functor: transform the value

```scala
Option(2).map(_ + 1) // Some(3)
```

## Applicative: combine independent values

```scala
(Option(2), Option(3)).mapN(_ + _) // Some(5)
```

## Monad: sequence dependent computations

```scala
Option(2).flatMap(x => if x > 0 then Some(x * 10) else None)
```

## Why the distinction matters

Applicatives can run independent computations **in parallel** or **accumulate errors**, because nothing depends on a previous result. Monads can''t, since each step needs the previous one.

Use the weakest abstraction that does the job.',
'2026-10-13 13:00:00', '2026-10-13 13:00:00');

INSERT INTO articles(id, author_id, title, slug, description, body, created_at, updated_at) VALUES (16, 2, 'Building a REST API with http4s', 'building-a-rest-api-with-http4s', 'A small, purely functional HTTP service',
'http4s treats an HTTP service as a function `Request => IO[Response]`.

```scala
import cats.effect.*
import org.http4s.*
import org.http4s.dsl.io.*
import org.http4s.ember.server.EmberServerBuilder

val routes = HttpRoutes.of[IO] {
  case GET -> Root / "hello" / name => Ok(s"Hello, $name")
  case GET -> Root / "health"       => Ok("up")
}

object Main extends IOApp.Simple:
  def run = EmberServerBuilder.default[IO]
    .withHttpApp(routes.orNotFound)
    .build
    .useForever
```

Since routes are plain values, you can test them by calling the function directly, no server needed:

```scala
routes.orNotFound.run(Request(uri = uri"/health"))
```',
'2026-10-15 09:00:00', '2026-10-15 09:00:00');

INSERT INTO articles(id, author_id, title, slug, description, body, created_at, updated_at) VALUES (17, 3, 'What Haskell Taught Me About Scala', 'what-haskell-taught-me-about-scala', 'Lessons from a purely functional language',
'Learning Haskell made me a better Scala programmer. Some takeaways:

## Types are documentation

A Haskell signature like `lookup :: Eq k => k -> [(k, v)] -> Maybe v` tells you almost everything. Aim for Scala signatures that are just as honest.

## Laziness is a tool, not a default

Haskell is lazy everywhere; Scala is strict with opt-in laziness (`lazy val`, `LazyList`, by-name parameters). Strict by default is easier to reason about for performance.

## Effects belong in the type

`IO` in Haskell is mandatory. In Scala it''s a choice, but Cats Effect and ZIO give you the same discipline.

## Scala has things Haskell doesn''t

Seamless Java interop, a huge ecosystem, and a gentle on-ramp for teams coming from OO.',
'2026-10-17 10:00:00', '2026-10-17 10:00:00');

INSERT INTO articles(id, author_id, title, slug, description, body, created_at, updated_at) VALUES (18, 1, 'Property-Based Testing with ScalaCheck', 'property-based-testing-with-scalacheck', 'Let the computer find your edge cases',
'Instead of writing examples, describe properties that should hold for *all* inputs.

```scala
import org.scalacheck.Prop.forAll
import org.scalacheck.Properties

object ListProps extends Properties("List"):
  property("reverse twice is identity") = forAll { (xs: List[Int]) =>
    xs.reverse.reverse == xs
  }

  property("sorted is ordered") = forAll { (xs: List[Int]) =>
    xs.sorted.zip(xs.sorted.drop(1)).forall(_ <= _)
  }
```

ScalaCheck generates hundreds of random inputs and, when a property fails, **shrinks** the input to the smallest failing case.

Pure functions are a perfect fit: no setup, no mocks, just inputs and outputs.',
'2026-10-19 11:00:00', '2026-10-19 11:00:00');

INSERT INTO articles(id, author_id, title, slug, description, body, created_at, updated_at) VALUES (19, 5, 'Structured Concurrency with ZIO Fibers', 'structured-concurrency-with-zio-fibers', 'Concurrency that cleans up after itself',
'ZIO fibers are lightweight threads managed by the runtime.

```scala
val fastest: Task[String] =
  fetchFrom("eu").race(fetchFrom("us"))

val all: Task[List[Price]] =
  ZIO.foreachPar(products)(fetchPrice).withParallelism(16)

val bounded: Task[Report] =
  buildReport.timeoutFail(new TimeoutException)(30.seconds)
```

## Structured means no leaks

When a parent fiber is interrupted, its children are interrupted too. In `race`, the loser is cancelled automatically, and any resources it acquired are released.

Compare that to juggling `Future`s, where a "cancelled" computation keeps running in the background.',
'2026-10-21 12:00:00', '2026-10-21 12:00:00');

INSERT INTO articles(id, author_id, title, slug, description, body, created_at, updated_at) VALUES (20, 4, 'Inline and Macros in Scala 3', 'inline-and-macros-in-scala-3', 'Compile-time programming without the pain of Scala 2 macros',
'Scala 3 metaprogramming starts with `inline`.

```scala
inline def debug(inline expr: Any): Unit =
  println(s"${compiletime.codeOf(expr)} = $expr")

debug(1 + 2 * 3)
// prints: 1 + 2 * 3 = 7
```

## Compile-time checks

```scala
import scala.compiletime.error

inline def positive(inline n: Int): Int =
  inline if n <= 0 then error("must be positive") else n

positive(5)  // ok
positive(-1) // compile error: must be positive
```

For the heavy lifting there are quoted macros (`''{ ... }` and `${ ... }`), but `inline` alone covers a surprising number of use cases.',
'2026-10-23 13:00:00', '2026-10-23 13:00:00');

INSERT INTO articles(id, author_id, title, slug, description, body, created_at, updated_at) VALUES (21, 2, 'Tagless Final in Five Minutes', 'tagless-final-in-five-minutes', 'Abstracting over the effect type, and when not to',
'Tagless final means writing your algebra over an abstract effect `F[_]`.

```scala
trait Users[F[_]]:
  def find(id: Long): F[Option[User]]

def welcome[F[_]: Monad](users: Users[F], id: Long): F[String] =
  users.find(id).map(_.fold("stranger")(_.name))
```

## Benefits

- Swap in `IO` in production and a simple `State` or `Id` in tests
- The constraints (`Monad`, `Concurrent`...) document what the code is allowed to do

## Costs

- More type parameters, harder error messages
- Most apps only ever use one effect type

My take: great for libraries, optional for applications. Concrete `IO` with traits for services is perfectly fine.',
'2026-10-25 09:00:00', '2026-10-25 09:00:00');

INSERT INTO articles(id, author_id, title, slug, description, body, created_at, updated_at) VALUES (22, 3, 'Folds Are Everywhere', 'folds-are-everywhere', 'foldLeft, foldRight and the shape of recursion',
'Most recursive functions over lists follow the same pattern. That pattern is a **fold**.

```scala
val xs = List(1, 2, 3, 4)

xs.foldLeft(0)(_ + _)                 // sum: 10
xs.foldLeft(1)(_ * _)                 // product: 24
xs.foldLeft(List.empty[Int])((acc, x) => x :: acc) // reverse
```

## Left or right?

- `foldLeft` processes from the start and is stack-safe on `List`
- `foldRight` processes from the end, and is the natural fit for building lists back up in order

Once you see folds, you''ll notice that `map`, `filter`, `sum`, `count` and `exists` are all special cases of it.',
'2026-10-27 10:00:00', '2026-10-27 10:00:00');

INSERT INTO articles(id, author_id, title, slug, description, body, created_at, updated_at) VALUES (23, 1, 'Case Classes Are Data', 'case-classes-are-data', 'Equality, copy and pattern matching for free',
'A `case class` gives you a lot with a single line:

```scala
case class Point(x: Int, y: Int)

val p = Point(1, 2)
val q = p.copy(y = 3)   // Point(1, 3)
p == Point(1, 2)        // true: structural equality
```

- `equals` and `hashCode` based on the fields
- a readable `toString`
- `copy` for immutable updates
- an extractor for pattern matching

Use them for data, and keep behaviour in functions.',
'2026-08-20 09:00:00', '2026-08-20 09:00:00');

INSERT INTO articles(id, author_id, title, slug, description, body, created_at, updated_at) VALUES (24, 2, 'Ref and Deferred', 'ref-and-deferred', 'Shared state and one-shot signals in Cats Effect',
'`Ref` is a purely functional mutable reference, and `Deferred` is a value that will be set exactly once.

```scala
for
  counter <- Ref.of[IO, Int](0)
  _       <- counter.update(_ + 1).parReplicateA_(100)
  value   <- counter.get
yield value // 100
```

Together they are enough to build most concurrency primitives: latches, queues, semaphores.',
'2026-08-22 10:00:00', '2026-08-22 10:00:00');

INSERT INTO articles(id, author_id, title, slug, description, body, created_at, updated_at) VALUES (25, 5, 'ZIO Test in Practice', 'zio-test-in-practice', 'Tests as values, with built-in test services',
'In ZIO Test, a test is just a value:

```scala
test("addition") {
  assertTrue(1 + 1 == 2)
}
```

The real power is in the **test services**: `TestClock`, `TestRandom` and `TestConsole` let you
test time-dependent code without sleeping.

```scala
for
  fiber <- ZIO.sleep(1.hour).fork
  _     <- TestClock.adjust(1.hour)
  _     <- fiber.join
yield assertCompletes
```',
'2026-08-24 11:00:00', '2026-08-24 11:00:00');

INSERT INTO articles(id, author_id, title, slug, description, body, created_at, updated_at) VALUES (26, 4, 'Union and Intersection Types', 'union-and-intersection-types', 'Two new ways to combine types in Scala 3',
'Scala 3 adds `|` and `&` at the type level.

```scala
def show(value: Int | String): String = value match
  case i: Int    => s"number $i"
  case s: String => s"text $s"

trait Logging { def log(msg: String): Unit }
trait Metrics { def inc(name: String): Unit }

def run(env: Logging & Metrics): Unit = ???
```

Union types are handy for error channels, intersection types for capabilities.',
'2026-08-26 12:00:00', '2026-08-26 12:00:00');

INSERT INTO articles(id, author_id, title, slug, description, body, created_at, updated_at) VALUES (27, 3, 'Laziness in Haskell and Scala', 'laziness-in-haskell-and-scala', 'Evaluate only what you need',
'Haskell is lazy by default. Scala is strict by default, but gives you the tools:

- `lazy val` evaluates once, on first access
- by-name parameters (`=> A`) evaluate on each use
- `LazyList` builds infinite sequences

```scala
val naturals: LazyList[Int] = LazyList.from(0)
naturals.filter(_ % 2 == 0).take(3).toList // List(0, 2, 4)
```

Laziness separates *describing* a computation from *running* it, which is the core idea of effect systems too.',
'2026-08-28 13:00:00', '2026-08-28 13:00:00');

INSERT INTO articles(id, author_id, title, slug, description, body, created_at, updated_at) VALUES (28, 1, 'Option Is Not Null', 'option-is-not-null', 'Making absence explicit in the type',
'`null` hides in every reference type. `Option` makes absence visible:

```scala
def findUser(id: Long): Option[User] = ???

findUser(42)
  .map(_.email)
  .getOrElse("unknown")
```

The compiler now reminds you to handle the missing case. Combine it with `for` comprehensions to chain
several optional lookups without nested `if`s.',
'2026-08-30 09:00:00', '2026-08-30 09:00:00');

INSERT INTO articles(id, author_id, title, slug, description, body, created_at, updated_at) VALUES (29, 2, 'Resource Safety with Resource', 'resource-safety-with-resource', 'Acquire, use, release, even on failure',
'`Resource` pairs an acquisition with its release:

```scala
val file: Resource[IO, BufferedReader] =
  Resource.fromAutoCloseable(IO(new BufferedReader(new FileReader("data.txt"))))

file.use(reader => IO(reader.readLine()))
```

Resources compose with `flatMap`, and are released in reverse order, even when the program fails or is cancelled.',
'2026-09-01 10:00:00', '2026-09-01 10:00:00');

INSERT INTO articles(id, author_id, title, slug, description, body, created_at, updated_at) VALUES (30, 5, 'ZIO Streams Basics', 'zio-streams-basics', 'Streams, sinks and pipelines',
'A `ZStream` is an effectful, possibly infinite sequence of values.

```scala
ZStream.fromIterable(1 to 1000)
  .filter(_ % 3 == 0)
  .map(_ * 2)
  .run(ZSink.sum)
```

Like fs2, it runs in constant memory and handles back-pressure for you.',
'2026-09-03 11:00:00', '2026-09-03 11:00:00');

INSERT INTO articles(id, author_id, title, slug, description, body, created_at, updated_at) VALUES (31, 4, 'Match Types', 'match-types', 'Computing types from types',
'Match types let you pattern match at the type level:

```scala
type Elem[X] = X match
  case String      => Char
  case Array[t]    => t
  case Iterable[t] => t

val c: Elem[String] = ''a''
val i: Elem[List[Int]] = 1
```

Useful in libraries, rarely needed in application code.',
'2026-09-05 12:00:00', '2026-09-05 12:00:00');

INSERT INTO articles(id, author_id, title, slug, description, body, created_at, updated_at) VALUES (32, 1, 'Higher-Order Functions', 'higher-order-functions', 'Functions that take or return functions',
'`map`, `filter` and `fold` are higher-order functions: they take a function as an argument.

```scala
def twice(f: Int => Int): Int => Int = f andThen f

val addTwo = twice(_ + 1)
addTwo(5) // 7
```

Once you are comfortable passing behaviour around, many design patterns become plain function composition.',
'2026-09-07 13:00:00', '2026-09-07 13:00:00');

INSERT INTO articles(id, author_id, title, slug, description, body, created_at, updated_at) VALUES (33, 3, 'Algebraic Data Types', 'algebraic-data-types', 'Sums, products and making illegal states unrepresentable',
'An algebraic data type is built from **products** (this *and* that) and **sums** (this *or* that).

```scala
enum Payment:
  case Card(number: String, expiry: String)
  case Transfer(iban: String)
  case Cash
```

The compiler checks that every pattern match handles every case, so adding a new payment method shows
you every place to update.',
'2026-09-09 09:00:00', '2026-09-09 09:00:00');

INSERT INTO articles(id, author_id, title, slug, description, body, created_at, updated_at) VALUES (34, 2, 'Testing Cats Effect Code', 'testing-cats-effect-code', 'munit-cats-effect and TestControl',
'With `munit-cats-effect`, tests can return an `IO`:

```scala
test("counter increments") {
  Ref.of[IO, Int](0).flatMap(ref => ref.update(_ + 1) >> ref.get).assertEquals(1)
}
```

For time-based code, `TestControl` runs the program on a simulated clock, so a one-hour timeout takes milliseconds.',
'2026-09-11 10:00:00', '2026-09-11 10:00:00');

INSERT INTO articles(id, author_id, title, slug, description, body, created_at, updated_at) VALUES (35, 1, 'Writing Your First sbt Build', 'writing-your-first-sbt-build', 'The minimum you need to know',
'A minimal `build.sbt`:

```scala
ThisBuild / scalaVersion := "3.7.0"

lazy val root = project
  .in(file("."))
  .settings(
    name := "hello",
    libraryDependencies += "org.scalameta" %% "munit" % "1.1.0" % Test
  )
```

Then `sbt run`, `sbt test` and `sbt ~compile` cover most of your day.',
'2026-09-13 11:00:00', '2026-09-13 11:00:00');

INSERT INTO articles_tags(article_id, tag_id) VALUES
    (1, 18),
    (1, 19),
    (1, 11),
    (2, 11),
    (2, 3),
    (3, 18),
    (3, 5),
    (3, 22),
    (4, 18),
    (4, 24),
    (4, 8),
    (5, 18),
    (5, 19),
    (5, 23),
    (6, 11),
    (6, 16),
    (6, 3),
    (7, 18),
    (7, 6),
    (7, 8),
    (8, 11),
    (8, 14),
    (8, 18),
    (9, 18),
    (9, 24),
    (9, 1),
    (10, 18),
    (10, 19),
    (10, 22),
    (11, 18),
    (11, 10),
    (11, 20),
    (11, 6),
    (12, 11),
    (12, 17),
    (12, 18),
    (13, 18),
    (13, 3),
    (14, 11),
    (14, 9),
    (14, 18),
    (15, 11),
    (15, 5),
    (15, 4),
    (16, 18),
    (16, 13),
    (16, 6),
    (16, 2),
    (17, 12),
    (17, 18),
    (17, 11),
    (18, 18),
    (18, 21),
    (18, 11),
    (19, 18),
    (19, 24),
    (19, 7),
    (20, 18),
    (20, 19),
    (20, 15),
    (21, 18),
    (21, 5),
    (21, 1),
    (21, 8),
    (22, 11),
    (22, 17),
    (22, 3),
    (23, 18),
    (23, 14),
    (23, 3),
    (24, 6),
    (24, 7),
    (24, 18),
    (25, 24),
    (25, 21),
    (25, 18),
    (26, 19),
    (26, 23),
    (26, 18),
    (27, 12),
    (27, 11),
    (27, 18),
    (28, 9),
    (28, 3),
    (28, 18),
    (29, 6),
    (29, 8),
    (29, 18),
    (30, 24),
    (30, 20),
    (30, 18),
    (31, 19),
    (31, 23),
    (31, 15),
    (32, 11),
    (32, 3),
    (32, 18),
    (33, 11),
    (33, 23),
    (33, 18),
    (34, 6),
    (34, 21),
    (34, 18),
    (35, 18),
    (35, 3),
    (35, 2);

INSERT INTO article_favorites(article_id, user_id) VALUES
    (1, 3),
    (2, 2),
    (2, 4),
    (3, 3),
    (3, 5),
    (4, 1),
    (4, 4),
    (5, 2),
    (5, 5),
    (6, 1),
    (7, 4),
    (8, 3),
    (8, 5),
    (9, 1),
    (9, 4),
    (10, 2),
    (10, 5),
    (11, 1),
    (11, 3),
    (12, 2),
    (12, 4),
    (13, 3),
    (13, 5),
    (14, 1),
    (14, 4),
    (15, 2),
    (15, 5),
    (16, 1),
    (16, 3),
    (17, 2),
    (17, 4),
    (18, 3),
    (18, 5),
    (19, 1),
    (19, 4),
    (20, 2),
    (20, 5),
    (21, 1),
    (21, 3),
    (22, 2),
    (22, 4),
    (1, 2),
    (4, 2),
    (6, 2),
    (8, 2),
    (9, 2),
    (13, 2),
    (14, 2),
    (18, 2),
    (19, 2),
    (23, 2),
    (25, 2),
    (26, 2),
    (27, 2),
    (28, 2),
    (30, 2),
    (31, 2),
    (32, 2),
    (33, 2),
    (35, 2),
    (5, 3),
    (7, 3),
    (9, 3),
    (10, 3),
    (14, 3),
    (15, 3),
    (19, 3),
    (23, 3),
    (25, 3),
    (26, 3),
    (29, 3),
    (30, 3),
    (31, 3),
    (34, 3),
    (35, 3),
    (23, 4),
    (25, 1),
    (27, 5),
    (30, 4),
    (33, 1),
    (35, 5);

INSERT INTO comments(id, author_id, article_id, body, created_at, updated_at) VALUES
    (1, 3, 1, 'Agreed! Scala 3 enums alone were worth the migration for us.', '2026-09-15 10:30:00', '2026-09-15 10:30:00'),
    (2, 2, 1, 'Nice summary. I would add the Typelevel and ZIO ecosystems to the list.', '2026-09-15 12:00:00', '2026-09-15 12:00:00'),
    (3, 1, 2, 'This is the post I send to every new team member.', '2026-09-17 14:30:00', '2026-09-17 14:30:00'),
    (4, 4, 3, 'Validated is so underrated. Great example.', '2026-09-19 17:00:00', '2026-09-19 17:00:00'),
    (5, 5, 3, 'ZIO Prelude has a similar Validation type, for those on the ZIO side.', '2026-09-19 18:30:00', '2026-09-19 18:30:00'),
    (6, 2, 4, 'Typed errors are the killer feature, nice intro.', '2026-09-21 21:00:00', '2026-09-21 21:00:00'),
    (7, 1, 6, 'The table at the end finally made it click for me, thanks!', '2026-09-25 19:30:00', '2026-09-25 19:30:00'),
    (8, 4, 6, 'Good luck explaining the laws without the jargon though :)', '2026-09-25 21:00:00', '2026-09-25 21:00:00'),
    (9, 5, 6, 'Bookmarked for the next workshop.', '2026-09-25 22:30:00', '2026-09-25 22:30:00'),
    (10, 5, 7, 'Resource is one of my favourite things in Cats Effect.', '2026-09-28 01:00:00', '2026-09-28 01:00:00'),
    (11, 3, 10, 'Much nicer than Scala 2 implicits. Students get it right away.', '2026-10-04 05:30:00', '2026-10-04 05:30:00'),
    (12, 2, 12, 'Worth mentioning that foldLeft is often the simplest answer.', '2026-10-08 04:00:00', '2026-10-08 04:00:00'),
    (13, 1, 15, 'This finally made the hierarchy clear to me.', '2026-10-14 08:30:00', '2026-10-14 08:30:00'),
    (14, 5, 16, 'Routes as plain functions make testing so easy.', '2026-10-16 06:00:00', '2026-10-16 06:00:00'),
    (15, 2, 18, 'ScalaCheck found a bug in our date parsing within minutes.', '2026-10-20 09:30:00', '2026-10-20 09:30:00'),
    (16, 5, 21, 'Strong agree on "optional for applications".', '2026-10-26 09:00:00', '2026-10-26 09:00:00'),
    (17, 1, 21, 'Concrete IO everywhere and we never looked back.', '2026-10-26 10:30:00', '2026-10-26 10:30:00');

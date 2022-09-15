# This code is licensed under MIT license (see LICENSE.txt for details)

{.push header: "<utility>".}

type
  CppPair*[T1, T2] {.importcpp: "std::pair<'0, '1>".} = object
    first*: T1
    second*: T2

# Constructor

proc initCppPair*[T1, T2](): CppPair[T1, T2] {.importcpp: "'0(@)", constructor.}
proc initCppPair*[T1, T2](x: T1, y: T2): CppPair[T1, T2] {.constructor, importcpp: "std::pair<'1, '2>(@)".}
proc initCppPair*[T1, T2](p: CppPair[T1, T2]): CppPair[T1, T2] {.constructor, importcpp: "'0(@)".}

# Member functions

proc swap*[T1, T2](this, other: var CppPair[T1, T2]) {.importcpp: "#.swap(@)".}

# Non-member functions

proc `==`*[T1, T2](lhs, rhs: CppPair[T1, T2]): bool {.importcpp: "# == #".}
proc `!=`*[T1, T2](lhs, rhs: CppPair[T1, T2]): bool {.importcpp: "# != #".}
proc `<`*[T1, T2](lhs, rhs: CppPair[T1, T2]): bool {.importcpp: "# < #".}
proc `<=`*[T1, T2](lhs, rhs: CppPair[T1, T2]): bool {.importcpp: "# <= #".}
proc `>`*[T1, T2](lhs, rhs: CppPair[T1, T2]): bool {.importcpp: "# > #".}
proc `>=`*[T1, T2](lhs, rhs: CppPair[T1, T2]): bool {.importcpp: "# >= #".}

proc get*[T1, T2](T: typedesc, p: CppPair[T1, T2]): T {.importcpp: "std::get<'0>(@)".}

proc getImpl[T1, T2](n: int, p: CppPair[T1, T2], T: typedesc): T {.importcpp: "std::get<#>(@)".}

{.pop.} # header

proc get*[T1, T2](n: static int, p: CppPair[T1, T2]): auto =
  when n == 0:
    type ResultType = T1
  elif n == 1:
    type ResultType = T2
  else:
    {.error: "index in pair must be 0 or 1".}
  getImpl(n, p, ResultType)

# Let C++ destructor do their things
proc `=destroy`[T1, T2](x: var CppPair[T1, T2]) =
  discard

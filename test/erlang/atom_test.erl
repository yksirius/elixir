-module(atom_test).
-export([kv/1]).
-include("elixir.hrl").
-include_lib("eunit/include/eunit.hrl").

eval(Content) ->
  { Value, Binding, _ } = elixir:eval(Content, []),
  { Value, Binding }.

kv([{Key,nil}]) -> Key.

atom_with_punctuation_test() ->
  {'a?',[]} = eval(":a?"),
  {'a!',[]} = eval(":a!"),
  {'||',[]} = eval(":||").

kv_with_punctuation_test() ->
  {'a?',[]} = eval("Erlang.atom_test.kv(a?: nil)"),
  {'a!',[]} = eval("Erlang.atom_test.kv(a!: nil)"),
  {'foo bar',[]} = eval("Erlang.atom_test.kv(\"foo bar\": nil)").

quoted_atom_test() ->
  {foo,[]} = eval(":\"foo\""),
  {foo,[]} = eval(":'foo'").

atom_with_interpolation_test() ->
  {foo,[]} = eval(":\"f#{\"o\"}o\"").

quoted_atom_chars_are_escaped_test() ->
  {'"',[]} = eval(":\"\\\"\"").
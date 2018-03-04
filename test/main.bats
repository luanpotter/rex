#!/usr/bin/env bats

function rex {
  node ../index.js "$@"
}

@test "simple test" {
  result="$(echo 'foo' | rex 'foo' 'bar')"
  [ "$result" = "bar" ]
}

@test "regex test" {
  result="$(echo 'foof' | rex '^f' 'g')"
  [ "$result" = "goof" ]
}

@test "file test" {
  printf "foo\nbar\nfaaf" > file
  cat file | rex '^f' 'g' | sponge file
  result=$(cat file)
  expected=$(printf "goo\nbar\ngaaf")
  rm file
  [ "$result" = "$expected" ]
}

@test "escape test" {
  result=$(printf "$ 12.00\n123\n$ 1.75" | rex '^\$ ([\d\.]*)$' '$1 $')
  expected=$(printf "12.00 $\n123\n1.75 $")
  [ "$result" = "$expected" ]
}

#!/usr/bin/env bats

function rex {
  node ../index.js "$@"
}

@test "simple test" {
  printf "foo\nbar\nfaaf" > file
  echo 'file' | rex -f '^f' 'g'
  result=$(cat file)
  expected=$(printf "goo\nbar\ngaaf")
  rm file
  [ "$result" = "$expected" ]
}

@test "whole dir" {
  cp -r files files_tmp
  find files_tmp | rex -f '  ' '\t'

  result1=$(cat files_tmp/a.sh)
  result2=$(cat files_tmp/inner/b.sh)

  rm -r files_tmp

  expected=$(printf "\techo 'hey'\n\techo 'bye'")
  [ "$result1" = "$expected" ]

  expected=$(printf "\t\tcat inner/b.sh")
  [ "$result2" = "$expected" ]
}
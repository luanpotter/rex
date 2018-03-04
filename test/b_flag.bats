#!/usr/bin/env bats

function rex {
  node ../index.js "$@"
}

@test "normal mode test" {
  echo 'foof' | rex -b '^f' 'g' | sponge file
  result_stdout=$(cat file)
  result_file=$(cat __rex__.bak)

  rm file
  rm __rex__.bak

  [ "$result_stdout" = "foof" ]
  [ "$result_file" = "goof" ]
}

@test "file mode test" {
  cp -r files files_tmp
  find files_tmp | rex -fb '  ' '\t'

  result1_file=$(cat files_tmp/a.sh)
  result2_file=$(cat files_tmp/inner/b.sh)
  result1_bkp=$(cat files_tmp/a.sh.bak)
  result2_bkp=$(cat files_tmp/inner/b.sh.bak)

  rm -r files_tmp

  expected=$(printf "  echo 'hey'\n  echo 'bye'")
  [ "$result1_file" = "$expected" ]
  expected=$(printf "\techo 'hey'\n\techo 'bye'")
  [ "$result1_bkp" = "$expected" ]

  expected=$(printf "    cat inner/b.sh")
  [ "$result2_file" = "$expected" ]
  expected=$(printf "\t\tcat inner/b.sh")
  [ "$result2_bkp" = "$expected" ]
}
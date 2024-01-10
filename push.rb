#!/usr/bin/env ruby
comment = ARGV[0]
res = `git add .&&git commit -m #{comment}&&git push`
p res 


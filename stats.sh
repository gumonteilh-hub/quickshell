#!/usr/bin/env bash

prev_total=0
prev_idle=0

while true; do
  read -r cpu a b c idle rest < /proc/stat

  total=$((a + b + c + idle))

  diff_idle=$((idle - prev_idle))
  diff_total=$((total - prev_total))

  if [ "$diff_total" -ne 0 ]; then
    cpu_usage=$(( (100 * (diff_total - diff_idle)) / diff_total))
  else 
    cpu_usage=0
  fi
  
  prev_total=$total
  prev_idle=$idle

  echo "{\"cpu\": $cpu_usage}"
  
  sleep 2
done


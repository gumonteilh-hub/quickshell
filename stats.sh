#!/usr/bin/env bash

prev_total=0
prev_idle=0

while true; do
  #CPU
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

  #RAM
  mem_total=$(awk '/^MemTotal:/ {print $2}' /proc/meminfo)
  mem_available=$(awk '/^MemAvailable:/ {print $2}' /proc/meminfo)
  ram_usage=$(( (mem_total - mem_available) * 100 / mem_total ))

  echo "{\"cpu\": $cpu_usage, \"ram\": $ram_usage}"
  
  sleep 2
done


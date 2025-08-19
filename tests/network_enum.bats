#!/usr/bin/env bats

@test "is_user_root returns success for root user" {
  source <(sed -n '18,22p' NetworkEnum.sh)
  run is_user_root
  [ "$status" -eq 0 ]
}

@test "is_user_root returns failure for non-root user" {
  run sudo -u nobody bash -c 'source <(sed -n "18,22p" NetworkEnum.sh); is_user_root'
  [ "$status" -ne 0 ]
}

@test "ping_scan builds nmap command" {
  source <(sed -n '46,53p' NetworkEnum.sh)
  date() { echo "01-02-2006-jan-15-04-05"; }
  nmap() { echo "$@" > cmd.out; }
  ping_scan "targets.txt"
  run cat cmd.out
  [ "$output" = "-sP -PE -iL targets.txt -oA Client_pingscan-01-02-2006-jan-15-04-05" ]
  rm cmd.out
}

@test "dns_zone_transfer builds dnsrecon command" {
  source <(sed -n '76,80p' NetworkEnum.sh)
  date() { echo "01-02-2006-jan-15-04-05"; }
  dnsrecon() { echo "$@" > cmd.out; }
  dns_zone_transfer "example.com"
  run cat cmd.out
  [ "$output" = "-d example.com -a --xml Client_zone_transfer-01-02-2006-jan-15-04-05.xml" ]
  rm cmd.out
}

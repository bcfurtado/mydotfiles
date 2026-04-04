ps() {
  command ps "$@" | ov -H1 --column-delimiter "/\s+/" --column-rainbow --column-mode
}

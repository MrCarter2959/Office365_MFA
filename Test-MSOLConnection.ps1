function Test-MSOLConnection {
  Get-MSolDomain -ErrorAction SilentlyContinue | Out-Null
  $?
}
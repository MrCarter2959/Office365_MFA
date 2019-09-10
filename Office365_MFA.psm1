# Load function files
Get-ChildItem -Path $PSScriptRoot -Filter '*.ps1' -Recurse -Exclude '*.ps1xml' | ForEach-Object {
  .$_.FullName
}
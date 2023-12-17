@echo off
rem ****************************
rem * (c) 2023 Alexander Predl *
rem *      office@predl.cc     *
rem *       License: MIT       *
rem * with help of ChatGPT 3.5 *
rem ****************************
powershell Get-ChildItem -Force ^| ForEach-Object {$item = $_;try {$acl = Get-Acl $item.FullName  -ErrorAction Stop} catch {Write-Host "$($_.Exception.Message)"};$size = $item.Length;$sizeFormatted = switch ($true) {{ $size -ge 1TB } {[string][math]::Round($size / 1TB, 2)+' TB';break };{ $size -ge 1GB } {[string][math]::Round($size / 1GB, 2)+' GB';break }; { $size -ge 1MB } {[string][math]::Round($size / 1MB, 2)+' MB';break }; { $size -ge 1KB } { [string][math]::Round($size / 1KB, 2)+' kB';break }; Default "{[string]$size+' B'}"};[PSCustomObject]@{Mode = $item.Mode;Owner = $acl.Owner;Size = $sizeFormatted;LastWriteTime = $item.LastWriteTime;Name = $item.Name}} ^| Format-Table -AutoSize

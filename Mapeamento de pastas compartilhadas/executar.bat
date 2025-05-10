@echo off
:: Executar script PowerShell com permissões elevadas
PowerShell -ExecutionPolicy Bypass -NoProfile -Command "& {Start-Process PowerShell -ArgumentList '-ExecutionPolicy Bypass -File \"%~dp0script.ps1\"' -Verb RunAs}"
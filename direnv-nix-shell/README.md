Wenn einzelne Nix Packages automatisch in einem Projektverzeichnis verfügbar sein sollen und die Funktionalitäten von nix flake nicht nötig sind -> Dann ein einfaches shell erstellen wie in diesem Beispiel.
`shell.nix` `.envrc`

## schnelle, temporäre Nix Shells
Nützliche nix packages.

Python `python`
```bash
nix-shell -p python2
nix-shell -p python314
```

Zip
```bash
nix-shell -p zip
```
 
### Weniger häufig genutzt
Kubernetes TUI
```bash
nix-shell -p k9s
```

CLI aufnehmen mit `asciinema` und zu gif exportieren mit `agg`. 
```bash
nix-shell -p asciinema asciinema-agg
```

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
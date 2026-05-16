Wenn einzelne Nix Packages automatisch in einem Projektverzeichnis verfügbar sein sollen und die Funktionalitäten von nix flake nicht nötig sind -> Dann ein einfaches shell erstellen wie in diesem Beispiel.
`shell.nix` `.envrc`
\
(vorher mit nix-shell command geschrieben, neu schreibe ich einfach den package name)

## schnelle, temporäre Nix Shells
Nützliche nix packages.

Python `python`
```bash
nix-shell -p python2
nix-shell -p python314
```

Zip
- zip
- unzip
```bash
nix-shell -p zip
```

 
### Weniger häufig genutzt
Editor
- neovim (benutzen mit nvim <file>)


C Programmierung
- nutze `nix flake init --template github:jasmin-f/nix#bsys-lock` 
- valgrind (finde memory probleme in eigenem c programm) [infos](https://valgrind.org/docs/manual/QuickStart.html) oder nutze ` gcc -fanalyzer` 
``` 
gcc program.c -g 
valgrind ./a.out <argument>
valgrind --leak-check=yes ./a.out <argument>
``` 

Kubernetes TUI
```bash
nix-shell -p k9s
```

CLI aufnehmen mit `asciinema` und zu gif exportieren mit `agg`. 
```bash
nix-shell -p asciinema asciinema-agg
```

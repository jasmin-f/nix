# Nix Flakes

## nix-direnv

In .envrc diese Zeile schreiben #devShell anpassen
    
    use flake /mnt/c/Users/jf/code/wsl/nix/#<devShell>


## Häufigste Projektordner

cd /home/jf/wsl-code/ost_3_semester/cpl


<!-- auf Windows:
cd /mnt/c/Users/jf/code/wsl/nix/  
cd /mnt/c/Users/jf/code/studium/  
auf WSL:  
cd /home/jf/wsl-code/ost_3_semester/cpl   -->


## UML
in WSL mit nix:

    # .envrc: use flake /mnt/c/Users/jf/code/wsl/nix/#uml
    # oder nix develop .#uml 
    # Projektordner ist auf windows gespeichert
    cd /mnt/c/Users/jf/code/studium/ost_3_semester/sep1/uml 
    plantuml

- Auf die gewünschte .puml Datei im plantuml viewer doppelklicken
- vs code nebenbei öffnen (in windows oder wsl), die gleiche Datei bearbeiten
- Tipp: die offizielle plantuml vscode extension nutzen für korrekten Syntax
  

## VS Code korrekt öffnen in wsl
    code . --remote
oder so
    code . --remote wsl+Ubuntu


## Datei ausführen
Eine executable in wsl heisst nicht .exe sondern hat keine Endung
ausführen mit: ./HelloWorld
# Nix Flakes
## Ordner
auf Windows:
cd /mnt/c/Users/jf/code/wsl/nix/  
cd /mnt/c/Users/jf/code/studium/  
auf WSL:  
cd /home/jf/wsl-code/ost_3_semester/cpl  


## UML
in WSL: 

    nix develop .#uml
    cd /mnt/c/Users/jf/code/studium/ost_3_semester/sep1/uml 
    plantuml

- Auf die gewünschte .puml Datei im plantuml viewer doppelklicken
- vs code nebenbei öffnen, die gleiche Datei bearbeiten
- Tipp: die offizielle plantuml vscode extension nutzen für korrekten Syntax
  

## VS Code korrekt öffnen in wsl
    code . --remote
oder so
    code . --remote wsl+Ubuntu


## Datei ausführen
Eine executable in wsl heisst nicht .exe sondern hat keine Endung
ausführen mit: ./HelloWorld
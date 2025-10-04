# Nix Flakes

Hier sind meine Nix Flakes gespeichert für verschiedene Entwicklungsumgebungen im Studium. 
Java und IntelliJ benutze ich auf Windows, das Nix ist auf wsl.

# Inhaltsverzeichnis

- [Nix Installation](#nix-installieren-und-einrichten)

- [Nix Flakes](#nix-flakes)

- [Packages](#packages)

- [Nix Sprache](#nix-sprache)

- [Begriffe](#begriffe)

- [Nützliche Links](#links)

- [nix-direnv = Devshell starten bei öffnen von Ordner](#nix-direnv)

- [Andere Informationen](#weitere-infos)

- [TODOs (für mich)](#todo)

## Nix installieren und einrichten


1. WSL Terminal öffnen (wenn auf Windows mit WSL)
2.  curl -L https://nixos.org/nix/install | sh
3. nach installation meldung beachten: **. /home/jf/.nix-profile/etc/profile.d/nix.sh** (erstellt Umgebungsvariable) 
4. nix --version sollte funktionieren


Updaten: https://nix.dev/manual/nix/2.18/installation/upgrading

Alternativer Download (Multiuser wird empfohlen) : [nixos.org/download](https://nixos.org/download/)

###  Nach Installation flakes aktivieren
<!-- (und Github token?) -->

konfigurieren nach Installation:
/etc/nix/nix.conf file   (auf wsl, nicht im windows. Wenn Ordner und Datei nicht vorhanden, sie selber erstellen!) 
    
```Shell
cd /etc
sudo mkdir nix
sudo touch nix.conf

# Die Datei muss diese Zeile enthalten:
experimental-features = nix-command flakes
```

Datei anpassen Beispiel

    sudo chown jf /etc/nix/nix.conf
    code /etc/nix/nix.conf
    --extra-experimental-features nix-command


## Nix Flakes

"nix <befehl>" ist ein flakes Befehl. "nix/ ..." ist der originale alte Weg (hier nicht genutzt).

### dev environments

Ich nutze Flake Nix mit Dev Environments

<!-- mkshell
im flake.nix zusätzlich devShells.${system} = .. schreiben
    dann z.B. nodejs und python ergänzen
    nix develop .#nodejs  aufrufen, dann node --version

praktisch: default = pkgs.mkShell .. definieren, muss im rec stehen, default ist speziell definiert. -->


Gehe in den Ordner mit dieser flake.nix Datei und führe dort diese Befehle aus (Beispiel: cd /mnt/c/Users/jf/code/wsl/nix)

    nix develop
    nix develop .#flakeShell
    nix develop .#dotnet
    nix develop .#web1

## Flake schreiben

flake.nix beim 1. Mal generieren (oder von hier kopieren) 

    nix flake new <name vom flake>
oder erstelle flake mit default settings:

    nix flake init -t github:hercules-ci/flake-parts

- flake.lock wird automatisch erstellt
- Git benutzen und bei Änderungen mindestens git add ausführen.

Nix Sprache prüfen mit

    nix eval .


### Weitere Commands (nix flake)

```Nix
nix search (package suchen, nix search <flake> ..)  
nix profile (package, geht nicht um compiler+installer zu installiern)  
nix run (test ohne permanente installation)  
nix shell (packages..)  
nix build  
    nix build nixpkgs#hello  
    build kompiliert nicht immer neu, wenn vorhanden nimmt es das aus dem Cache  
nix profile  
    nix shell, nix run, nix build sind zum testen und daten können wieder weggehen (ad hoc). nix profile benutzen wenn es bleiben soll.  
```

<!-- hier -- nötig
nix run nixpkgs#ripgrep -- --version  -->


### testen

nix eval --expr '1 + 2'
nix eval --file example.nix { … }

im nix repl: (nix-repl>)
    1. :load datei.nix
    2. description "test"

## Packages

### Package finden

Package ist z.B. Programmiersprache oder Programm. Die NixOS Packages sind die gleichen wie die für Flakes. 

    nix search nixpkgs <name>
oder ich bevorzuge: https://search.nixos.org/packages

## Bestimmte Versionen von Packages benutzen
Das ist die Einschränkung von nix, es wird nicht empfohlen von Nix Herstellern... 


- Kann nicht package mit gewisser Versionsnummern auswählen
- Schwierig ein Package einzeln zu aktualisieren
    
1. Workaround: 2 nixpackages einrichten (alt und neu) : im devshell die nixpkgs mischen / auswählen ODER irgendwie mit overlays
    
2. Workaround  
    package mit versionsnummer (hash/nixpkgs reference) auswählen
    z.B. hier: https://www.nixhub.io/ https://lazamar.co.uk/nix-versions/

<!-- ### custom packages

{ lib, stdenv, fetchurl }

stdenv : standard library for nix builds
mkDerivation (mk wegen mk für makefile <https://www.greasyguide.com/linux/run-makefile-windows/>)
pname schreiben nicht name -->

## Nix Sprache

Flakes werden mit der nix sprache geschrieben. Es ist eine funktionale Programmiersprache (wie Haskell).

Es gibt currying und hat einen speziellen Syntax. Aber types gibt es gar nicht, auch nicht im Hintergrund.


Beispiel:
    outputs  function of inputs… output = {..}: {packages.. = nixpkgs…};
    nix build .#test (. = aktueller ordner)

Nix language <https://nix.dev/manual/nix/2.28/language/>

### "Typen" / Sprach Bausteine

dictionary, key value attribute set <https://nix.dev/tutorials/nix-language.html#attribute-set>

Zeilen mit ; beenden, mehrzeilig mit ''  .. \n .. \n .. ''

function mit : geschrieben, outputs = {self, nixpkgs }: { … };

[1 2 3] // Liste mit Abstand

{ lib, stdenv, fetchurl } // argumente mit komma

{
  string = "hello";
  integer = 1;
} // attribute set mit semikolon


rec {} : steht für recursive, es ist ein recursives attribute set. Kann auch mit let in geschrieben werden. let definiert lokale Variable.


bei let die lokalen Variablen definieren und in in benutzen .   
positional arguments : Reihenfolge von Argumenten relevant

let 
    sum = arg1: arg2: arg1 + arg2;
    add1 = sum 1;
in
    add1 2  //mit semikolon?



### Argument set

geschweifte klammern weil es ein argument set ist
let 
    sum = {arg1, arg2 ? 2 }: arg1 + arg2;
in
    sum {arg1 = 1; }




inputs.nixpkgs.url = ist ein verkettetes attribute set…

## Begriffe

nix != nixos != nixospkgs &rarr; nicht verwechseln, gehören alle zu Nix.

nixpkgs : nixos/nixpkgs, <https://github.com/nixos/nixpkgs>

pkgs ist eigentlich "nix packages and functions"

attribute path = z.B. legacyPackages.x86_..-linux... legacyPackages ist hier normal.

substitutor : cache der build ersetzt wenn vorhanden 

library / framework : library you call and framework calls you. die definierte "Variable/attribute set" im outputs wird aufgeruft (also wie framework)

/nix/store hat wichtige Dateien

## Links

- https://noogle.dev/
- https://www.youtube.com/results?search_query=librephoenix

Dokumentation
- https://nixos.org/
- https://nix.dev/

Infos 
- https://github.com/colemickens/nixos-flake-example

Einrichtung Tutorials
- https://www.kunxi.org/blog/2020/11/nix-on-wsl/
- https://garnix.io/docs/installing-nix
- https://discourse.nixos.org/t/first-time-user-where-should-i-create-my-nix-conf/39655
- https://dev.to/arnu515/getting-started-with-nix-and-nix-flakes-mml
- https://tech.aufomm.com/my-nix-journey-use-nix-with-ubuntu/

Interessantes 
- https://starship.rs/guide/


## nix-direnv

Damit nicht jedes Mal im Nix Ordner nix develop .#<> manuell aufgerufen werden und dann zum Projektordner gewechselt muss. 
Direnv ruft automatisch Befehle im dazugehörigen Ordner auf, mit nix-direnv ist direnv für nix optimiert.

Normales **direnv** installieren:
```Bash
    sudo apt  install direnv  # version 2.32.1-2ubuntu0.24.04.3
    direnv --version
```

Installation von **nix-direnv** mit nix-homemanager (Link: https://github.com/jasmin-f/nix-home-manager)

Die Datei .envrc im gewünschten Projektordner erstellen und diese Zeile schreiben (Ordner muss auf Nix Flake Ordner zeigen, #devShell anpassen)
    
    use flake /mnt/c/Users/jf/code/wsl/nix/#<devShell>


<blockquote>
💡 
Die Warnung, dass es länger lädt, ignorieren (ausser es lädt wirklich zu lange). 
</blockquote>

#### nicht vergessen "Deinstallation"

Nix-direnv verhindert "Garbage Collection" von Nix, was machen wenn Dev Environment wahrscheinlich nicht mehr benötigt wird? (muss noch getestet werden)
- .direnv Ordner löschen und manuell Garbage Collection starten
- nix-collect-garbage --delete-old --dry-run --delete-older-than 30d



## TODO
- Wie Internetzugang sperren? 
- VS Code extensions auch einrichten mit nix flakes?

## Weitere Infos

### UML
in WSL mit nix:

    # .envrc: use flake /mnt/c/Users/jf/code/wsl/nix/#uml
    # oder nix develop .#uml 

    # Projektordner ist auf windows gespeichert
    cd /mnt/c/Users/jf/code/studium/ost_3_semester/sep1/uml 
    plantuml

- Auf die gewünschte .puml Datei im plantuml viewer doppelklicken
- vs code nebenbei öffnen (in windows oder wsl), die gleiche Datei bearbeiten
- Tipp: die offizielle plantuml vscode extension nutzen für korrekten Syntax
  

### VS Code korrekt öffnen in wsl

    code . --remote
    # oder so:
    code . --remote wsl+Ubuntu


### Datei ausführen

Eine executable in wsl heisst nicht .exe sondern hat keine Endung
ausführen mit: ./HelloWorld

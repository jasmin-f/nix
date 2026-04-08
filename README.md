# Nix Flakes

Java und IntelliJ (Jetbrains Programme) installiere ich auf Windows, das Nix ist auf wsl.
Hier sind meine Nix Informationen, Templates und mein .gitignore Template gespeichert.

# Inhaltsverzeichnis

- [Nix Installation](#nix-installieren-und-einrichten)

- [Nix Flakes](#nix-flakes)

- [Packages](#packages)

- [Nix Sprache](#nix-sprache)

- [Begriffe](#begriffe)

- [Nützliche Links](#links)

- [nix-direnv = Devshell starten bei öffnen von Ordner](#nix-direnv)

- [Andere Informationen](#weitere-infos)



## Nix installieren und einrichten

1. WSL Terminal öffnen (wenn auf Windows mit WSL)
2.  curl -L https://nixos.org/nix/install | sh
3. nach installation meldung beachten: **. /home/jf/.nix-profile/etc/profile.d/nix.sh** (erstellt Umgebungsvariable) 
4. nix --version sollte funktionieren


Updaten: https://nix.dev/manual/nix/2.18/installation/upgrading

Alternativer Download (Multiuser wird empfohlen) : [nixos.org/download](https://nixos.org/download/)

###  Nach Installation flakes aktivieren

#### Variante 1 : einfach

```shell

mkdir -p /etc/nix
echo "experimental-features = nix-command flakes" > ~/.config/nix/nix.conf
```
<!-- mkdir -p ~/.config/nix
echo "experimental-features = nix-command flakes" > ~/.config/nix/nix.conf -->

#### Variante 2 : ausführlich (optional)
konfigurieren nach Installation:
/etc/nix/nix.conf file   (auf wsl, nicht im windows. Wenn Ordner und Datei nicht vorhanden, diese selber erstellen!) 
    
```Shell
cd /etc
sudo mkdir nix
sudo touch nix.conf

# Die Datei muss diese Zeile enthalten:
experimental-features = nix-command flakes
```

Datei anpassen Beispiel
```shell
sudo chown jf /etc/nix/nix.conf
code /etc/nix/nix.conf
--extra-experimental-features nix-command
```


#### Testen
```shell
nix run nixpkgs#hello
```

🥳

-----

## Nix Flakes

"nix <befehl>" ist ein flakes Befehl. "nix/ ..." ist der originale alte Weg (hier nicht genutzt).

### dev environments

Ich nutze Flake Nix mit Dev Environments.

Gehe in den Ordner mit dieser flake.nix Datei und führe dort diese Befehle aus (Beispiel: cd /mnt/c/Users/jf/code/wsl/nix)

    nix develop
    nix develop .#flakeShell
    nix develop .#dotnet
    nix develop .#web1

Praktischer mit [nix-direnv](#nix-direnv). Informationen zur [mkShell](#nix-shell-mit-mkshell).


## Flake schreiben

flake.nix beim 1. Mal generieren (oder von hier kopieren) 

    nix flake new <name vom flake>
    
oder erstelle flake mit default settings:

    nix flake init
    
    nix flake init --template github:omega-800/devshell-templates#<template>
    nix flake init -t github:hercules-ci/flake-parts

- flake.lock wird automatisch erstellt
- Git benutzen und bei Änderungen mindestens git add ausführen.

Nix Sprache prüfen mit

    nix eval .


### Weitere Commands (nix flake)

```Nix
nix search <> # package suchen, nix search <flake> ..

# test ohne permanente installation
nix run  

# build kompiliert nicht immer neu, wenn vorhanden nimmt es das aus dem "Cache" 
nix shell (packages..)  
nix build  
nix build nixpkgs#hello  
    
# nix shell, nix run, nix build sind zum testen und daten können wieder weggehen (ad hoc). nix profile benutzen wenn es bleiben soll.
nix profile  
nix profile list
nix profile add nixpkgs#jetbrains.webstorm
nix profile remove nixpkgs#jetbrains.webstorm
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


## Nix Shell mit mkShell

### Unterschied stdenv und mkShell
[Dokumentation stdenv](https://nixos.org/manual/nixpkgs/stable/#sec-using-stdenv)
[Dokumentation mkShell](https://nixos.org/manual/nixpkgs/stable/#sec-pkgs-mkShell)

**mkShell** pkgs.mkShell is a specialized stdenv.mkDerivation that removes some repetition when using it with nix-shell (or nix develop).

**stdenv** standard library for nix builds  
mkDerivation (mk wegen mk für makefile)

### Unterschied packages und buildInputs
packages = nativeBuildInputs

Standardmässig das "packages" Attribut benutzen.   

> Bei stdenv werden die **dependencies von packages** im "buildInputs" Attribut definiert. 
> " This attribute ensures that the bin subdirectories of these packages appear in the PATH environment variable during the build, that their include subdirectories are searched by the C compiler, and so on. (See the section called “Package setup hooks” for details.) " [Quelle](https://nixos.org/manual/nixpkgs/stable/#sec-using-stdenv:~:text=Many%20packages%20have%20dependencies%20that%20are%20not%20provided%20in%20the%20standard%20environment%2E%20It%E2%80%99s%20usually%20sufficient%20to%20specify%20those%20dependencies%20in%20the%20buildInputs%20attribute)


Beispiel aus der Doku
```nix
stdenv.mkDerivation {
  pname = "libfoo"; # pname schreiben statt name
  version = "1.2.3";
  # ...
  buildInputs = [
    libbar
    perl
    ncurses
  ];
}
```

Beispiel von meiner Shell mit mkShell
```nix
# nix develop .#dotnet (.NET) 
dotnet = pkgs.mkShell {
    packages = with pkgs; [ 
    jetbrains.rider 
    dotnetCorePackages.sdk_8_0_3xx-bin 
    ];

    shellHook = ''
    echo ""
    echo "C#"
    echo "rider ."
    echo ""
    '';
};
```


## Nix Sprache

Flakes werden mit der nix sprache geschrieben. Es ist eine funktionale Programmiersprache (wie Haskell).

Es gibt currying und hat einen speziellen Syntax. Aber types gibt es gar nicht, auch nicht im Hintergrund.


Beispiel:
```nix
outputs  function of inputs… output = {..}: {packages.. = nixpkgs…};
nix build .#test (. = aktueller ordner)
```


Nix language <https://nix.dev/manual/nix/2.28/language/>

### "Typen" / Sprach Bausteine
dictionary, key value attribute set <https://nix.dev/tutorials/nix-language.html#attribute-set>

Zeilen mit `;` beenden, mehrzeilig mit `''  .. \n .. \n .. ''`

function mit `:` geschrieben, `outputs = {self, nixpkgs }: { … };`

```nix
[1 2 3] # Liste mit Abstand

{ lib, stdenv, fetchurl } # Argumente mit Komma

{
  string = "hello";
  integer = 1;
} # attribute set mit Semikolon
```


`rec {}` : steht für recursive, es ist ein recursives attribute set. Kann auch mit let in geschrieben werden. let definiert lokale Variable.


bei `let` die lokalen Variablen definieren und in `in` benutzen.   
positional arguments : Reihenfolge von Argumenten relevant

```nix
let 
    sum = arg1: arg2: arg1 + arg2;
    add1 = sum 1;
in
    add1 2  //mit semikolon?
```



### Argument set

geschweifte klammern weil es ein argument set ist
```nix
let 
    sum = {arg1, arg2 ? 2 }: arg1 + arg2;
in
    sum {arg1 = 1; }
```

`inputs.nixpkgs.url` = ist ein verkettetes attribute set

## Begriffe

nix != nixos != nixospkgs &rarr; nicht verwechseln, gehören alle zu Nix.

nixpkgs : nixos/nixpkgs, <https://github.com/nixos/nixpkgs>

pkgs ist eigentlich "nix packages and functions"

attribute path = z.B. legacyPackages.x86_..-linux... legacyPackages ist hier normal.

substitutor : cache der build ersetzt wenn vorhanden 

library / framework : library you call and framework calls you. die definierte "Variable/attribute set" im outputs wird aufgeruft (also wie framework)

Unter /nix/store sind wichtige Dateien abgelegt

## Links

Beispiel Flakes
- https://github.com/omega-800/devshell-templates


- https://noogle.dev/
- https://www.youtube.com/results?search_query=librephoenix

Dokumentation
- https://nixos.org/
- https://nix.dev/


Einrichtung Tutorials
- https://www.kunxi.org/blog/2020/11/nix-on-wsl/
- https://garnix.io/docs/installing-nix
- https://discourse.nixos.org/t/first-time-user-where-should-i-create-my-nix-conf/39655
- https://dev.to/arnu515/getting-started-with-nix-and-nix-flakes-mml
- https://tech.aufomm.com/my-nix-journey-use-nix-with-ubuntu/
- https://nix.dev/manual/nix/2.18/quick-start

<!-- Interessantes 
- https://starship.rs/guide/ -->

## nix-direnv
 
- https://nix.dev/guides/recipes/direnv.html
- https://direnv.net/

### Ein Nix flake pro Projekt
Damit beim wechseln in einen Ordner mit nix flake, automatisch das Development Environment gestartet wird, gibt es direnv. Die wichtige Konfigurationsdatei für direnv ist ".envrc".

Installation von **nix-direnv** mit nix-home-manager ([Home-manager Notizen](https://github.com/jasmin-f/nix-home-manager))

Der Projektordner von flake besitzt eine flake.nix Datei im root-Ordner, zusätzlich wird die .envrc Datei mit dem Inhalt `use flake` erstellen.

<blockquote>
💡 Die Warnung, dass es länger lädt, ignorieren (ausser es lädt wirklich zu lange).
</blockquote>

### Ein nix flake für alle Projekte (nicht empfohlen)
Damit nicht jedes Mal im Nix Ordner nix develop .#<> manuell aufgerufen werden und dann zum Projektordner gewechselt muss. 
Direnv ruft automatisch Befehle im dazugehörigen Ordner auf, mit nix-direnv ist direnv für nix optimiert.

Installation von **nix-direnv** mit nix-home-manager ([Home-manager Notizen](https://github.com/jasmin-f/nix-home-manager))

Die Datei .envrc im gewünschten Projektordner erstellen und diese Zeile schreiben (Ordner muss auf Nix Flake Ordner zeigen, #devShell anpassen)
    
    use flake /mnt/c/Users/jf/code/wsl/nix/#<devShell>

<blockquote>
💡 Die Warnung, dass es länger lädt, ignorieren (ausser es lädt wirklich zu lange).
</blockquote>

### direnv allow
Wenn aufgefordert ausführen.

    direnv allow

Oder permanent setzen in ~/.config/direnv/direnv.toml

    [whitelist]
    prefix = [ "~/wsl-code/ost_3_semester", "~/loremipsum" ]
    

#### nicht vergessen "Deinstallation"
Nix-direnv verhindert "Garbage Collection" von Nix, was machen wenn Dev Environment wahrscheinlich nicht mehr benötigt wird? (muss noch getestet werden)
- .direnv Ordner löschen und manuell Garbage Collection starten
- nix-collect-garbage --delete-old --dry-run --delete-older-than 30d


## Nix ohne Flakes
Packages die nützlich sind kann man auch ohne Flake benutzen. Wenn Packages selten oder zum Testen benötigt werden sehr praktisch.
So muss keine Flake (mit flake.nix) Datei angepasst werden.

Beispiel von nix-shells im [direnv-nix-shell](/direnv-nix-shell/README.md) Ordner

### Nix Package Testen (empfohlen)
    nix-shell --packages <Packetname>
    nix-shell -p <Packetname>

### Nix Package Installieren
    nix-env --install --attr nixpkgs.<Packetname>


### Nix Package Deinstallieren
    nix-env --uninstall <Packetname>

### Updaten
Updated alle installierten Packages (auch die von flake?)
    nix-channel --update nixpkgs
    nix-env --upgrade '*'

Rückgängig (1 nix-env command)
    nix-env --rollback

### Garbage Collector
    nix-collect-garbage --delete-old

### Packages
- ruby_3_4 (gem Umgebungsvariable)
- obsidian

<!-- ## TODO
- Wie Internetzugang sperren? > apparmor oder network config
- VS Code extensions auch einrichten mit nix flakes (wsl)? > recommended extensions json oder (nicht performant auf wsl) vscodium flake -->

### VS Code korrekt öffnen in wsl

    code . --remote
    # oder so:
    code . --remote wsl+Ubuntu


### Datei ausführen

Eine executable in wsl heisst nicht .exe sondern hat keine Endung
ausführen mit: ./HelloWorld

### Nix Flakes Templates 
(gemacht für mein Setup mit WSL)

Im Ordner "nix-flakes" befinden sich meine Nix Flake Templates für verschiedene isolierte Entwicklungsumgebungen. Im Readme in dem Ordner stehen weitere Informationen.


### Fehlende Manpage hinzufügen
Die Manpage wird nicht immer automatisch mit dem Flake verfügbar gemacht.
<!-- nicht so einfach, weil das ist systemlevel und deshalb kann das nicht die shell machen -->
Hier ist mein Lösungsweg mit dem Fallbeispiel von Clang.


flake starten und herausfinden welche Version von Package in Nutzung ist
```shell
nix develop
clang -v
# clang version 21.1.8
```

suche Pfad zu manpage von Package clang.
Package Dateien finden:
```
ls /nix/store/*clang*/
```

ich habe dieses ausgewählt mit der korrekten Version
```shell
/nix/store/lqdpgi6zs1wvc4490cpw8nbj34n5wv4h-clang-manpages-21.1.0/

# ich hatte auch dieses gefunden:
# /nix/store/wi30i30p28sckk88dgcqh3v0n0nn3lkv-clang-manpages-19.1.7/
```

schaue das sich dort in etwa dieser Pfad befindet `man1/clang.1.gz`, hier war es erst im Unterordner `share/man/` drin
```shell
/nix/store/lqdpgi6zs1wvc4490cpw8nbj34n5wv4h-clang-manpages-21.1.0/share/man/man1/clang.1.gz
```

entferne `man1/clang..gz` vom pfad und ergänze es so zu den exports als bash command
```shell
export MANPATH="/nix/store/lqdpgi6zs1wvc4490cpw8nbj34n5wv4h-clang-manpages-21.1.0/share/man/:${MANPATH:-:}"
```

oder mit escapen von `${` mithilfe von `''${` zum nix shellhook
```nix
shellHook = ''
    export MANPATH="/nix/store/lqdpgi6zs1wvc4490cpw8nbj34n5wv4h-clang-manpages-21.1.0/share/man/:''${MANPATH:-:}"
'';
```

#### Nützliche Commands für Manpage in Nix
manpage Pfade anzeigen
```shell
manpath
```

Unnötig aber interessant: manpage manuell entzippen und anschauen (ich habe die Datei zuerst in einen Testordner verschoben)
```shell
gunzip -d clang.1.gz
```

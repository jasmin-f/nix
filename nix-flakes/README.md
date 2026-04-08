## Nix Flakes
[Aktivieren von flakes](../README.md#nach-installation-flakes-aktivieren)

### Flake nutzen
Nutze diesen Befehl um ein Template einzurichten, wobei template mit dem Ordnername (hier in nix-flakes) ersetzt wird.

```bash
nix flake init --template github:jasmin-f/nix#<ordnername>
nix flake new --template github:jasmin-f/nix#<ordnername>

# mit flake.lock:
nix flake init --template github:jasmin-f/nix#<ordnername>-lock

# alias für command erstellen
# nfi <templatename>
# nfi <templatename> <ordner>
nfi() { nix flake new --refresh --template "github:jasmin-f/nix#$1-lock" "$2"; } 
```


#### Weitere Templates:
- https://github.com/omega-800/devshell-templates (flake.nix code für templates übernommen und mehr)
- https://github.com/the-nix-way/dev-templates/tree/main


#### Notiz
python flake entspricht nicht der Vorlage
aktuell nur x86_64-linux

<!-- 
Zu unwichtige Notizen:\
Projekte mit Nix Flakes die hier nicht als Template verfügbar sind
- SEP1 Project Automation 

Auf Windows installiert
- Webstorm Programme, .NET mit Rider, weil die Version mit Rider auf Nix langsam war

-->
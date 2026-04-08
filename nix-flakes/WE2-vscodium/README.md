## vscodium mit extensions über flake installieren
Damit kann ich die extensions mit flake installieren.
[Quelle und detailierte Infos](https://github.com/nix-community/nix-vscode-extensions)

**aktuell nicht in Benutzung** weil es sich zeitlich (performance auf wsl) mehr lohnt die vscode extensions selber zu installieren und mit normalem VS code zu arbeiten :)  

### Extensions finden / testen ob vorhanden
```bash
nix repl
nix-vscode-extensions = builtins.getFlake github:nix-community/nix-vscode-extensions/fd5c5549692ff4d2dbee1ab7eea19adc2f97baeb
# extensions = nix-vscode-extensions.extensions.${system}
extensions = nix-vscode-extensions.extensions.x86_64-linux
extensions.vscode-marketplace.golang<tab> # sucht alle passenden extensions! teste dann nochmals .<tab> da es evt. länger ist
extensions.vscode-marketplace.<extension-id><tab> # der syntax sollte meistens stimmen, testen indem 1 Buchstabe nicht eingegeben wird und dann <tab>

extensions.vscode-marketplace.<extension>.version # Version anzeigen, lädt es herunter
```

Hinweis: die extension id von vscode marketplace beachtet gross-kleinschreibung, bei nix ist beim Name der Extension alles kleingeschrieben.

### Tipps
die packages können so definiert werden (siehe flake.nix)
```nix
packages.default = vscode-with-extensions.override {
    vscode = vscodium;
    vscodeExtensions = [
        pkgs.vscode-marketplace.dbaeumer.vscode-eslint
        pkgs.vscode-marketplace.esbenp.prettier-vscode
        pkgs.vscode-marketplace.ritwickdey.liveserver
    ];
};
```

### empfohlen vscode Einstellungen übernehmen
Indem ich im Projekt als workspace Ordner die settings.json einfüge, kann ich meine Einstellungen beibehalten in vscodium.

### Extensions Sammlung
- ms-vscode-remote.remote-wsl
- ritwickdey.LiveServer
- alefragnani.Bookmarks
- Gruntfuggly.todo-tree
- agutierrezr.emmet-keybindings (aktuelle Version?)

- James-Yu.latex-workshop
- 64kramsystem.markdown-code-blocks-asm-syntax-highlighting
- DavidAnson.vscode-markdownlint
- myriad-dreamin.tinymist

- jnoortheen.nix-ide
- jebbs.plantuml
- ms-vscode-remote.remote-ssh
- ms-vscode-remote.remote-ssh-edit

- Keno.uikit-3-snippets

- ms-vscode.cpptools
- ms-vscode.cmake-tools
- 13xforever.language-x86-64-assembly

- ms-vscode-remote.remote-containers
- eamodio.gitlens


### fonts temporär auf wsl/linux installieren
[Quelle](https://www.geeksforgeeks.org/techtips/how-to-install-fonts-on-linux/)
Create or use this directory:
```bash
/usr/local/share/fonts/
# ~/.local/share/fonts/
```
Refresh the font cache to apply changes:
```bash
    fc-cache -f -v
```
Once done, your newly added fonts will appear in applications like LibreOffice, GIMP, or your text editor.
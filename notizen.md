# weitere Notizen

Die nicht so ausarbeitet und relevanten Notizen stehen hier.


### cppreference lokal

C++ Reference als HTML lokal

*einfacher*: auf [cppreference](https://en.cppreference.com/w/Cppreference%253AArchives.html) das Zip File herunterladen und im Ordner "reference/en" anschauen.

*komplizierter*
 [C++ Reference Github](https://github.com/PeterFeicht/cppreference-doc)  umwandeln mit make:
```bash
cd /mnt/c/Users/jf/
cd 'OneDrive - OST'/'0 Laptop'/ebook\ dateien/3.\ Semester/C++/

nix-shell -p gnumake42  
make doc_html
```


## Fonts einrichten
https://wiki.nixos.org/wiki/Fonts

Fonts anzeigen:
    fc-list

hier fonts für ubuntu/wsl platzieren
    \\wsl.localhost\Ubuntu\usr\local\share\fonts
    sudo cp /mnt/c/<path to font>.ttf /usr/local/share/fonts/

    sudo cp /mnt/c/Users/jf/code/00_dokumente/fonts/Roboto /usr/local/share/fonts/ -r

Fonts installieren
    sudo fc-cache -fv



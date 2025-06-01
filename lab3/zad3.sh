#!/usr/bin/env bash
#
# Systemy operacyjne 2 – laboratorium nr 3 – semestr letni 2020/2021
#
# Celem zajęć jest pogłębienie wiedzy na temat struktury systemu plików,
# poruszania się po katalogach i kontroli uprawnień w skryptach powłoki.
#
# Przygotowane rozwiązania nie muszą być całkowicie uniwersalne. Zakładamy,
# że ogólna struktura katalogów się nie zmienia (nie będzie już więcej/mniej
# poziomów podkatalogów), jednakże same nazwy i zawartości plików (o ile
# nie są podane wprost w treści zadań) mogą być dowolne i ulegać zmianie,
# a przygotowane rozwiązania nadal powinny działać.
#
# Wszystkie chwyty dozwolone, ale ostatecznie w wyniku ma powstać tylko to,
# o czym mowa w treści zadania – tworzone samodzielnie ewentualne tymczasowe
# pliki pomocnicze należy usunąć.
#

#
# Zadanie 3.
# Utworzyć w katalogu `ddd` dowiązania do wszystkich plików wykonywalnych
# z katalogu `aaa`. Nazwy tworzonych dowiązań mają pokrywać się z nazwami
# oryginalnych plików. Rodzaj dowiązania nie ma znaczenia, ale należy
# upewnić się, że nie zmienimy żadnych istniejących plików w `ddd`.
#


src_dir="aaa"
dest_dir="ddd"

# Upewniamy się, że katalog źródłowy i docelowy istnieją
if [ ! -d "$src_dir" ]; then
    echo "Błąd: katalog '$src_dir' nie istnieje."
    exit 1
fi

if [ ! -d "$dest_dir" ]; then
    echo "Błąd: katalog '$dest_dir' nie istnieje."
    exit 1
fi

# Iteracja po plikach wykonywalnych w katalogu aaa
find "$src_dir" -maxdepth 1 -type f -executable | while read plik; do
    nazwa=$(basename "$plik")
    cel="$dest_dir/$nazwa"

    if [ -e "$cel" ]; then
        echo "Pomijam: '$cel' już istnieje."
    else
        ln -s "../$plik" "$cel"
        if [ $? -eq 0 ]; then
            echo "Utworzono dowiązanie: $cel -> ../$plik"
        else
            echo "Błąd podczas tworzenia dowiązania dla: $plik"
        fi
    fi
done
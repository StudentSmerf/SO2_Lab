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
# Zadanie 10.
# Wyszukać w podanym katalogu (pierwszy argument skryptu) wszystkie dowiązania
# twarde do wskazanego pliku (drugi argument skryptu). Nie trzeba uwzględniać
# podkatalogów przy przeszukiwaniu. Wyświetlić same nazwy znalezionych plików.
# Na początku skontrolować liczbę argumentów skryptu i istnienie odpowiednich
# elementów; jeśli podany katalog lub plik nie istnieją – zwrócić ze skryptu
# kod błędu (komenda: exit 1).
#
# Przykład uruchomienia: ./zadA.sh 'bbb' 'ddd/wanted'
#


if [ "$#" -ne 2 ]; then
    exit 1
fi

katalog="$1"
plik="$2"

# Sprawdzenie, czy katalog istnieje i jest katalogiem
if [ ! -d "$katalog" ]; then
    exit 1
fi

# Sprawdzenie, czy plik istnieje i jest plikiem zwykłym
if [ ! -f "$plik" ]; then
    exit 1
fi

# Pobranie inode i urządzenia pliku docelowego
inode_docelowego=$(stat -c %i "$plik")
device_docelowego=$(stat -c %d "$plik")

# Szukanie w katalogu (bez rekurencji) plików o tym samym inode i device
find "$katalog" -maxdepth 1 -type f -inum "$inode_docelowego" -exec stat -c '%d %n' {} \; | while read dev nazwa; do
    if [ "$dev" = "$device_docelowego" ]; then
        basename "$nazwa"
    fi
done


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
# Zadanie 4.
# Utworzyć w katalogu `ddd` dowiązania do katalogów `aaa`, `bbb` i `ccc`.
# Nazwy dowiązań mają być takie same, jak nazwy oryginalnych katalogów.
# Zadbać o to, żeby wielokrotne uruchomienie skryptu nie tworzyło żadnych
# dodatkowych plików/dowiązań wewnętrznych.
#


# Lista katalogów do powiązania
katalogi=("aaa" "bbb" "ccc")
katalog_docelowy="ddd"

# Upewniamy się, że katalog docelowy istnieje
if [ ! -d "$katalog_docelowy" ]; then
    echo "Błąd: katalog docelowy '$katalog_docelowy' nie istnieje."
    exit 1
fi

for kat in "${katalogi[@]}"; do
    if [ -d "$kat" ]; then
        cel="$katalog_docelowy/$kat"

        if [ -e "$cel" ]; then
            echo "Dowiązanie/katalog '$cel' już istnieje – pomijam."
        else
            ln -s "../$kat" "$cel"
            if [ $? -eq 0 ]; then
                echo "Utworzono dowiązanie: $cel -> ../$kat"
            else
                echo "Błąd podczas tworzenia dowiązania do: $kat"
            fi
        fi
    else
        echo "Źródłowy katalog '$kat' nie istnieje – pomijam."
    fi
done



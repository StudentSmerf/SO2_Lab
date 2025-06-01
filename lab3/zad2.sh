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
# Zadanie 2.
# Utworzyć w katalogu `ddd` dowiązanie symboliczne o nazwie `drugi`
# do pliku `podstawa` z katalogu `aaa`. Rodzaj ścieżki (względna/bezwzględna)
# nie ma znaczenia, ale dowiązanie musi być poprawne. Nie tworzyć dowiązania,
# jeśli jakikolwiek plik o nazwie `drugi` już istnieje w `ddd`.
#


katalog_docelowy="ddd"
plik_docelowy="drugi"
plik_zrodlowy="../aaa/podstawa"  # Ścieżka względna z ddd do aaa/podstawa
pelna_sciezka_docelowa="$katalog_docelowy/$plik_docelowy"

# Sprawdzenie, czy plik już istnieje
if [ -e "$pelna_sciezka_docelowa" ]; then
    echo "Plik '$pelna_sciezka_docelowa' już istnieje. Dowiązanie nie zostało utworzone."
else
    # Tworzenie dowiązania symbolicznego
    ln -s "$plik_zrodlowy" "$pelna_sciezka_docelowa"
    if [ $? -eq 0 ]; then
        echo "Dowiązanie symboliczne '$pelna_sciezka_docelowa' do '$plik_zrodlowy' zostało utworzone."
    else
        echo "Błąd: Nie udało się utworzyć dowiązania symbolicznego."
    fi
fi
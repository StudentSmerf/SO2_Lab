#!/usr/bin/env bash
#
# Systemy operacyjne 2 – laboratorium nr 5 – semestr letni 2020/2021
#
# Celem zajęć jest nabranie doświadczenia w pracy z mechanizmem łącz
# nienazwanych, wykorzystując przy tym szereg podstawowych narzędzi
# do przetwarzania danych tekstowych.
#
# Tradycyjnie nie przywiązujemy zbyt dużej wagi do środowiska roboczego.
# Zakładamy, że format i układ danych w podanych plikach nie ulega zmianie,
# ale same wartości, inne niż podane wprost w treści zadań, mogą ulec zmianie,
# a przygotowane zadania wciąż powinny działać poprawnie (robić to, co trzeba).
#
# Wszystkie chwyty dozwolone, ale w wyniku ma powstać tylko to, o czym jest
# mowa w treści zadania – nie generujemy żadnych dodatkowych plików pośrednich.
#

#
# Zadanie 7.
# Odnaleźć w pliku `dodatkowe/ps-aux` proces, który zużywa najwięcej czasu
# procesora (trzecia kolumna). Jako wynik zwrócić numer procesu (druga kolumna)
# oraz po spacji pełną nazwę procesu (wszystko od 11 kolumny do końca wiersza).
#

#NR > 1 - pominięcie pierwszej linii
# $3+0 - konwersja do liczby, aby uniknąć problemów z porównywaniem
# NF - liczba pól w bieżącym wierszu

awk 'BEGIN {
    max_cpu_time = -1
    max_pid = ""
    proc_name = ""
}

NR > 1 {
    if ($3+0 > max_cpu_time+0) {
        max_cpu_time = $3
        max_pid = $2
        proc_name = ""
        for (i=11; i<=NF; i++) {
            if (i == NF) {
                proc_name = proc_name $i
            } else {
                proc_name = proc_name $i " "
            }
        }
    }
}
END {
    print max_pid, proc_name
}' dodatkowe/ps-aux
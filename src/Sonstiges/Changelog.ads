package Changelog is
   
   -- Version 0.00.8130 => 0.00.81 (06.08.2021):
   
   -- 
   -- Kleinigkeiten korrigiert.
   
   
   
   -- Version 0.00.8110 => 0.00.8130 (05.08.2021):
   
   -- Menschlichen Forschungsbaum überarbeitet und deutlich erweitert.
   -- Experimente mit richtiger Grafik gemacht.
   -- Kleinigkeiten korrigiert.
   
   
   
   -- Version 0.00.8100 => 0.00.8110 (04.08.2021):
   
   -- Zeit seit letzter Änderung des diplomatischen Zustandes wird jetzt am Ende jeder Runde erhöht (mit Überlaufschutz).
   -- Grenzen für die maximale Sympathie, in Abhängigkeit vom aktuellen Status, eingebaut.
   -- Sympathie wird am Ende jeder Runde für bekannte Rassen um eins bis zum Maximum erhöht.
   -- Einige diplomatischen Zustände rausgeworfen um die unnötige Komplexität zu reduzieren.
   -- Man kann jetzt Geld verlangen.
   -- Prüfungen ob die Änderuing des aktuellen Zustandes möglich ist, in Abhängigkeit von Sympathie und letzter Zustandänderung, eingebaut.
   -- Aktuelle Sympathiewerte werden bei Zustandänderung jetzt angepasst.
   -- Geld schenken/verlangen hat jetzt Auswirkung auf die aktuelle Sympathie.
   -- Rassenspezifische Bewertung von Kartenfeldern/Verbesserungen eingebaut.
   -- Kommentare und Kleinigkeiten korrigiert/angepasst.
   
   
   
   -- Version 0.00.8080 => 0.00.8100 (03.08.2021):
   
   -- ImSpiel fertig überarbeitet.
   -- Es ist jetzt möglich die vorhandene Ressourcenmenge einzustellen.
   -- Fehler behoben der dazu führte das zwei Einwohner einer Stadt verhunderten statt Einer.
   -- Vereinfachte Abfrage für die Gesamtproduktion eines Feldes eingebaut.
   -- Automatische Arbeiterbelegung in den Städte verbessert. Es werden jetzt Felder mit höheren Werte bevorzugt belegt und bei fehlender Nahrungsproduktion Felder mit hoher Nahrungsproduktion zuerst belegt.
   -- Fehler behoben der verhinderte dass beim Städtewachstum die Umgebung nicht korrekt aufgedeckt wurde.
   -- Fehler behoben der verhinderte das beim Wachstum der Stadtumgebungsgröße noch freie Arbeiter verteilt wurden.
   -- Unnötigen Code gelöscht.
   -- Angefangen die Änderungen des diplomatischen Zustandes anhand des aktuellen Zustandes einzuschränken.
   -- Interne Diplomatiewerte um Zeit seit letzter diplomatischer Änderung und aktueller Sympathiebewertung erweitert.
   -- Kommentare und Kleinigkeiten korrigiert/überarbeitet/angepasst/zusammengefasst/hinzugefügt.
   
   
   
   -- Version 0.00.8060 => 0.00.8080 (02.08.2021):
   
   -- Fehler behoben der verhinderte dass man in einer Hafenstadt Schiffe bauen kann.
   -- Platzierung von neu gebauten Einheiten/Einheiten die aus einem Schiff entladen werden verbessert.
   -- Angefangen das Diplomatiesystem einzubauen.
   -- Das Ändern des diplomatischen Zustandes vereinheitlicht.
   -- Sichtbarkeitscheat setzt jetzt auch alle Rassen auf Bekannt.
   -- Es ist jetzt möglich den diplomatischen Zustand zu einer anderen Rasse zu ändern.
   -- Angefangen ein Handelsmenü einzubauen.
   -- Wenn ein menschlicher Spieler das Spiel verlässt und noch weitere Menschen vorhanden sind, wird das Spiel jetzt nicht mehr beendet sonder die Rasse des Spielers auf die KI übertragen.
   -- Eine Möglichkeit eingebaut Einheiten einer anderen Rasse unter bestimmten Bedingungen von seinem eigenen Land zu entfernen.
   -- Fehler behoben der dazu führte dass eine Spielerrasse auch dann auf die KI gesetzt wurde wenn nur die Runde beendet wurde.
   -- Karten tauschen/kaufen/verkaufen ist jetzt möglich bringt/kostet aber noch kein Geld und es existiert keine Ablehnungsmöglichkeit.
   -- Kontakte tauschen/kaufen/verkaufen ist jetzt möglich bringt/kostet aber noch kein Geld und es existiert keine Ablehnungsmöglichkeit.
   -- Man kann jetzt Geld verschenken, wenn man mehr Geld als 0 hat.
   -- Angefangen einen Ironmanmodus einzubauen.
   -- Es ist jetzt auch möglich die Heimatstadt während der Bewegung einer Einheit zu ändern.
   -- Angefangen ImSpiel zu überarbeiten und übersichtlicher zu gestalten.
   -- Contracts, Kommentare und Kleinigkeiten korrigiert/überarbeitet/angepasst.
   
   
   
   -- Version 0.00.8040 => 0.00.8060 (01.08.2021):
   
   -- Kartengenerator für die Oberflächenlandschaft überarbeitet, er berücksichtigt jetzt den bereits vorhandenen Grund bei der Bestimmung des Grundes für ein unbelegtes Feld.
   -- Ladezeiten auf Enum umgeschrieben.
   -- Der Kartengenerator für Flusserzeugung berücksichtigt jetzt die Kartentemperatur für die Erzeugung von Flüssen und ist leicht schneller.
   -- Reihenfolge der Kartengenerierung überarbeitet.
   -- Ressourcenmaximum rausgeworfen, der Ressourcengenerator platziert jetzt auf Basis verschiedenen Wahrscheinlichkeiten die Ressourcen auf den dazu passenden Feldern.
   -- Angefangen eine Möglichkeit einzubauen die vorhandene Ressourcenmenge einzustellen.
   -- Kleinigkeiten korrigiert/überarbeitet/angepasst.
   
   
   
   -- Version 0.00.8020 => 0.00.8040 (31.07.2021):
   
   -- Das Plündern von Verbesserungen und Straßen gibt jetzt eine kleine Menge Geld.
   -- Angefangen die verschiedenen Tugelarten einzubauen.
   -- Sichtweite der Stadt ist jetzt ihre Umgebungsgröße + 1.
   -- Noch mehr Zeit mit UmgebungErreichbarTesten verschwendet ohne zu einem Ergebnis zu kommen.
   -- Mehr Vorbereitungen für Grenzmöglichkeiten erledigt.
   -- Procedure eingebaut um zu prüfen ob eine Rasse noch Einheiten/Städte hat und um sie vollständig zu entfernen.
   -- Kartengenerator angefangen zu überarbeitet.
   -- Angefangen das Diplomatiesystem zu erweitern.
   -- Kommentar und Kleinigkeiten korrigiert/überarbeitet/angepasst/vereinfacht.
   
   
   
   -- Version 0.00.7990 => 0.00.8020 (30.07.2021):
   
   -- Allen Rassen einen richtigen Namen gegeben.
   -- Alle Datenbanken mit rassenspezifischem Inhalt in einzelne Teile aufgeteilt, welche beim Spielstart in die Gesamtdatenbank geschrieben werden.
   -- Alle anderen Datenbank werden jetzt ebenfalls beim Spielstart beschrieben.
   -- Die Datenbanken werden jetzt alle mit Standardinhalten befüllt, wenn keine Datendateien gefunden werden.
   -- Einen großen Haufen unnötigen Code gelöscht.
   -- Diverse Schleifenprüfungen auf vor die Schleife verschoben, so dass diese Prüfung nicht mehr für jeden Schleifenwert durchlaufen wird.
   -- Einheiten- und Städtelimits eingebaut und alle Schleifen daran angepasst, Limit ist aber noch nicht vom Nutzer festlegbar.
   -- Einheiten- und Städtelimits werden jetzt im Spielstand gespeichert und geladen.
   -- Die Passierbarkeit der Anfangseinheiten jeder Rasse an ihren Lebensraum angepasst, Passierbarkeit Küstenwasser und Kartengrund Erdgestein hinzugefügt.
   -- Die Startplatzierung an die unterschiedlichen Startsiedler und Rasseneigenschaften angepasst.
   -- Changelog um Datumsangabe erweitert, äußerst wichtig und erwähnenswert.
   -- Kommentare, Contracts und Kleinigkeiten korrigiert/angepasst/überarbeitet/entfernt.
   
   
   
   -- Version 0.00.7970 => 0.00.7990 (29.07.2021):
   
   -- Aktuelle Koordinatenposition wird jetzt immer angezeigt und nicht nur wenn man Cheats nutzt.
   -- Permanente Kostenberechnung wird jetzt im Stadtrecord gespeichert und beim Bauen/Entfernen einer Einheit modifiziert anstatt am Ende einer Runde über tausende Elemente zu loopen.
   -- Es ist jetzt möglich die Heimatstadt einer Einheit zu ändern.
   -- Heimatstadt von eigenen Einheiten wird jetzt angezeigt.
   -- Permanente Kosten für vorhandene Gebäude werden jetzt beim Bauen/Verkaufen eines Gebäudes modifiziert anstatt am Ende einer Runde über hunderte Elemente zu loopen.
   -- Beim Entfernen einer Stadt werden jetzt alle Heimatstadtwerte von Einheiten die diese Stadt als Heimatstadt haben auf 0 gesetzt.
   -- Kleine Änderungen an der Textdarstellung im Spiel.
   -- Im Baumenü werden jetzt die permanenten Kosten von Einheiten und Gebäuden angezeigt.
   -- Das Erzeugen von Einheiten sollte mit der Standardprocedure jetzt auch dann funktioneren wenn die Einheiten anders als durch das Bauen in einer Stadt erschaffen werden.
   -- Angefangen den Rassen richtige Namen zu geben.
   -- Kleinigkeiten korrigiert/angepasst/überarbeitet.
   
   
   
   -- Version 0.00.7950 => 0.00.7970 (28.07.2021):
   
   -- Unnötigen Code in den Stadtsystemen gelöscht und diverse Proceduren zusammengefasst.
   -- Die Prüfungen für verschiedene Stadtwerteänderungen in eine eigene Datei/eigene Proceduren ausgelagert.
   -- Verschiedene Abfragen für Werte aus der Kartendatenbank oder für Kartenfelder zentralisiert.
   -- Den Rassen verschiedenen Lebewesen zugewiesen.
   -- Array für die Werte von DurchStadtBelegterGrund in zwei Funktionen umgewandelt.
   -- Angefangen die einzelnen Rassenbestandteile der Forschung/Einheiten/Gebaeude/RassenDatenbanken in einzelne Dateien auszulagern.
   -- Die Laden- und Speicherfunktionen für die Datenbanken um die RassenDatenbank erweitert.
   -- Permanente Kosten für Einheiten und Begäude werden jetzt bei den Berechnungen für die Stadtwerte berücksichtigt.
   -- Kleinigkeiten korrigiert/angepasst/überarbeitet/vereinfacht.
   
   
   
   -- Version 0.00.7910 => 0.00.7950 (27.07.2021):
   
   -- RassenDatenbank angelegt um verschiedene Verhaltensweisen für die KI zu ermöglichen.
   -- RassenAllgemein angelegt um Werte aus der RassenDatenbank abzufragen.
   -- LeerKonstante für RassenListeRecord angelegt.
   -- Die Leerwerte in GlobaleKonstanten und die Datenbank übersichtlicher gestaltet.
   -- Erzeugung von Einheiten vereinfacht und verallgemeinert.
   -- Einheiten bekommen beim Erzeugen die Herstellungsstadt als Heimatstadt zugewiesen.
   -- Einheiten und Gebäude können jetzt permanente Kosten für verschiedene Ressourcen haben.
   -- Einfaches Beförderungssystem für siegreiche Einheiten eingebaut.
   -- Fehler behoben der dazu führte dass über das TransportArray hinausgeloopt wurde.
   -- Es ist jetzt nicht mehr möglich Kartenfelder ohne Verbesserungen zu plündern.
   -- Fehler behoben der dazu führte dass die Stadtbelegung nicht korrekt entfernt wurde, wenn eine Stadt aufhört zu existieren.
   -- Es ist jetzt möglich feindliche Städte zu zerstören.
   -- Einfache Siegbedingungen eingebaut.
   -- Benachrichtung eingebaut wenn man am Ende einer Runde eine Siegbedingung erfüllt.
   -- Es wird jetzt gespeichert/geladen ob bereits Gewonnen wurde.
   -- Fehler behoben der bei der Schrumpfung einer Stadt die Arbeiter nicht korrekt entfernte.
   -- Hülle für die Bewertung einzelner Spieler für die KI angelegt.
   -- Fehlermeldung eingebaut wenn man zweimal die gleiche Rasse belegen will.
   -- Zufällige Rassenauswahl wählt jetzt keine bereits belegte Rasse mehr aus.
   -- Tugel eingebaut, was auch immer das für eine Form sein soll, funktioniert auch sehr komisch/nicht richtig.
   -- Es wird jetzt die Ladung eigener Schiffe angezeigt.
   -- Das Berechnen einiger Werte aus GlobaleVeriablen.Wichtiges in eine eigene Datei ausgelagert.
   -- Unnötigen Code gelöscht.
   -- Kommentare, Contracts und Kleinigkeiten korrigiert/angepasst/überarbeitet/vereinfacht.
   
   

   -- Version 0.00.7890 => 0.00.7910 (26.07.2021):
   
   -- Bewegungssystem fertig überarbeitet, sollte jetzt übersichtlich sein.
   -- Durch die Überarbeitung unnötigen Code gelöscht.
   -- Maximale Transportkapazität für Transporter eingebaut.
   -- Fehler in der Suchenfunktion für Einheiten korrigiert, welcher falsche Werte lieferte wenn die Einheit in einem Transporter ist.
   -- Diverse 0-Werte in 0-Konstanten umgebaut.
   -- KI benennt ihre Städte jetzt nach einem der drei Testnamen.
   -- Fehler behoben der das Ziel der KI vor der Wegplanung immer wieder auf 0 setzte.
   -- Angefangen die Aufgabenermittlung und Aufgabenfestlegung der KI zu verallgemeinern.
   -- Kleinigkeiten korrigiert.
   
end Changelog;

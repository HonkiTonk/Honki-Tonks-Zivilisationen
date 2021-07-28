package Changelog is
   
   -- Version 0.00.7970 => 0.00.79:
   
   --
   -- Kleinigkeiten korrigiert.
   
   
   
   -- Version 0.00.7950 => 0.00.7970:
   
   -- Unnötigen Code in den Stadtsystemen gelöscht und diverse Proceduren zusammengefasst.
   -- Die Prüfungen für verschiedene Stadtwerteänderungen in eine eigene Datei/eigene Proceduren ausgelagert.
   -- Verschiedene Abfragen für Werte aus der Kartendatenbank oder für Kartenfelder zentralisiert.
   -- Den Rassen verschiedenen Lebewesen zugewiesen.
   -- Array für die Werte von DurchStadtBelegterGrund in zwei Funktionen umgewandelt.
   -- Angefangen die einzelnen Rassenbestandteile der Forschung/Einheiten/Gebaeude/RassenDatenbanken in einzelne Dateien auszulagern.
   -- Die Laden- und Speicherfunktionen für die Datenbanken um die RassenDatenbank erweitert.
   -- Permanente Kosten für Einheiten und Begäude werden jetzt bei den Berechnungen für die Stadtwerte berücksichtigt.
   -- Kleinigkeiten korrigiert/angepasst/überarbeitet/vereinfacht.
   
   
   
   -- Version 0.00.7910 => 0.00.7950:
   
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
   
   

   -- Version 0.00.7890 => 0.00.7910:
   
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

package ChangelogJuli2021 is

   -- Version 0.00.8020 => 0.00.8040 (31.07.2021):
   
   -- Das Plündern von Verbesserungen und Straßen gibt jetzt eine kleine Menge Geld.
   -- Angefangen die verschiedenen Tugelarten einzubauen.
   -- Sichtweite der Stadt ist jetzt ihre Umgebungsgröße + 1.
   -- Noch mehr Zeit mit UmgebungErreichbarTesten verschwendet ohne zu einem Ergebnis zu kommen.
   -- Mehr Vorbereitungen für Grenzmöglichkeiten erledigt.
   -- Procedure eingebaut um zu prüfen ob eine Spezies noch Einheiten/Städte hat und um sie vollständig zu entfernen.
   -- Kartengenerator angefangen zu überarbeitet.
   -- Angefangen das Diplomatiesystem zu erweitern.
   -- Kommentar und Kleinigkeiten korrigiert/überarbeitet/angepasst/vereinfacht.
   
   
   
   -- Version 0.00.7990 => 0.00.8020 (30.07.2021):
   
   -- Allen Spezies einen richtigen Namen gegeben.
   -- Alle Datenbanken mit Speziesspezifischem Inhalt in einzelne Teile aufgeteilt, welche beim Spielstart in die Gesamtdatenbank geschrieben werden.
   -- Alle anderen Datenbank werden jetzt ebenfalls beim Spielstart beschrieben.
   -- Die Datenbanken werden jetzt alle mit Standardinhalten befüllt, wenn keine Datendateien gefunden werden.
   -- Einen großen Haufen unnötigen Code gelöscht.
   -- Diverse Schleifenprüfungen auf vor die Schleife verschoben, so dass diese Prüfung nicht mehr für jeden Schleifenwert durchlaufen wird.
   -- Einheiten- und Städtelimits eingebaut und alle Schleifen daran angepasst, Limit ist aber noch nicht vom Nutzer festlegbar.
   -- Einheiten- und Städtelimits werden jetzt im Spielstand gespeichert und geladen.
   -- Die Passierbarkeit der Anfangseinheiten jeder Spezies an ihren Lebensraum angepasst, Passierbarkeit Küstenwasser und Kartengrund Erdgestein hinzugefügt.
   -- Die Startplatzierung an die unterschiedlichen Startsiedler und Spezieseigenschaften angepasst.
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
   -- Angefangen den Spezies richtige Namen zu geben.
   -- Kleinigkeiten korrigiert/angepasst/überarbeitet.
   
   
   
   -- Version 0.00.7950 => 0.00.7970 (28.07.2021):
   
   -- Unnötigen Code in den Stadtsystemen gelöscht und diverse Proceduren zusammengefasst.
   -- Die Prüfungen für verschiedene Stadtwerteänderungen in eine eigene Datei/eigene Proceduren ausgelagert.
   -- Verschiedene Abfragen für Werte aus der KartengrundDatenbank oder für Kartenfelder zentralisiert.
   -- Den Spezies verschiedenen Lebewesen zugewiesen.
   -- Array für die Werte von DurchStadtBelegterGrund in zwei Funktionen umgewandelt.
   -- Angefangen die einzelnen Speziesbestandteile der Forschung/Einheiten/Gebaeude/SpeziesDatenbanken in einzelne Dateien auszulagern.
   -- Die Laden- und Speicherfunktionen für die Datenbanken um die SpeziesDatenbank erweitert.
   -- Permanente Kosten für Einheiten und Begäude werden jetzt bei den Berechnungen für die Stadtwerte berücksichtigt.
   -- Kleinigkeiten korrigiert/angepasst/überarbeitet/vereinfacht.
   
   
   
   -- Version 0.00.7910 => 0.00.7950 (27.07.2021):
   
   -- SpeziesDatenbank angelegt um verschiedene Verhaltensweisen für die KI zu ermöglichen.
   -- SpeziesAllgemein angelegt um Werte aus der SpeziesDatenbank abzufragen.
   -- LeerKonstante für SpeziesListeRecord angelegt.
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
   -- Fehlermeldung eingebaut wenn man zweimal die gleiche Spezies belegen will.
   -- Zufällige Speziesauswahl wählt jetzt keine bereits belegte Spezies mehr aus.
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

end ChangelogJuli2021;

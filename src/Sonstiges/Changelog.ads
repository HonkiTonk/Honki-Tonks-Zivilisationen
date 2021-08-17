package Changelog is
   
   -- Version 0.00.8 => 0.00.8 (01.09.2021):
   
   -- 
   -- Kleinigkeiten korrigiert.
   
   
   
   -- Version 0.00.8 => 0.00.8 (31.08.2021):
   
   -- 
   -- Kleinigkeiten korrigiert.
   
   
   
   -- Version 0.00.8 => 0.00.8 (30.08.2021):
   
   -- 
   -- Kleinigkeiten korrigiert.
   
   
   
   -- Version 0.00.8 => 0.00.8 (29.08.2021):
   
   -- 
   -- Kleinigkeiten korrigiert.
   
   
   
   -- Version 0.00.8 => 0.00.8 (28.08.2021):
   
   -- 
   -- Kleinigkeiten korrigiert.
   
   
   
   -- Version 0.00.8 => 0.00.8 (27.08.2021):
   
   -- 
   -- Kleinigkeiten korrigiert.
   
   
   
   -- Version 0.00.8 => 0.00.8 (26.08.2021):
   
   -- 
   -- Kleinigkeiten korrigiert.
   
   
   
   -- Version 0.00.8 => 0.00.8 (25.08.2021):
   
   -- 
   -- Kleinigkeiten korrigiert.
   
   
   
   -- Version 0.00.8 => 0.00.8 (24.08.2021):
   
   -- 
   -- Kleinigkeiten korrigiert.
   
   
   
   -- Version 0.00.8 => 0.00.8 (23.08.2021):
   
   -- 
   -- Kleinigkeiten korrigiert.
   
   
   
   -- Version 0.00.8 => 0.00.8 (22.08.2021):
   
   -- 
   -- Kleinigkeiten korrigiert.
   
   
   
   -- Version 0.00.8 => 0.00.8 (21.08.2021):
   
   -- 
   -- Kleinigkeiten korrigiert.
   
   
   
   -- Version 0.00.8 => 0.00.8 (20.08.2021):
   
   -- 
   -- Kleinigkeiten korrigiert.
   
   
   
   -- Version 0.00.8 => 0.00.8 (19.08.2021):
   
   -- 
   -- Kleinigkeiten korrigiert.
   
   
   
   -- Version 0.00.8380 => 0.00.8 (18.08.2021):
   
   -- 
   -- Kleinigkeiten korrigiert.
   
   
   
   -- Version 0.00.8370 => 0.00.8380 (17.08.2021):
   
   -- Alle lesenden Zugriffe auf Karten.Weltkarte erfolgen jetzt über LeseKarten.
   -- SchreibeKarten erstellt und alle schreibenden Zugriffe auf Karten.Weltkarten darauf umgelegt.
   -- Die Grundänderung von irgendeinem Grund auf Hügel sollte jetzt immer Hügel auf False setzen.
   -- Angefangen alle lesenden Zugriff auf GlobaleVariablen.EinheitenGebaut über LeseEinheitenGebaut umzuleiten.
   -- Contracts und Kleinigkeiten korrigiert/angepasst/hinzugefügt.
   
   
   
   -- Version 0.00.8360 => 0.00.8370 (16.08.2021):
   
   -- Hügel_Mit wird jetzt bei den entsprechenden Feldwerten jetzt berücksichtigt.
   -- Ermittlung der Kampfwerte vereinfacht.
   -- Sicherheitsprüfung für Einheiten eingebaut, welche transportieren können, aber ein Transporterlimit von 0 haben.
   -- Kommentare und Kleinigkeiten korrigiert/angepasst.
   
   
   
   -- Version 0.00.8340 => 0.00.8360 (15.08.2021):
   
   -- Den Aspari_2 Forschungsbaum grafisch größtenteils erstellt.
   -- Die anderen Forschungsbäume grafisch erweitert.
   -- Chaoskartengenerator um Ressourcen und Flüsse erweitert.
   -- Prüfung ob die richtige Umgebung für ein Gebäude vorhanden ist ausgelagert, um sie so später für die KI und bei Verkleinerungen der Stadtumgebung wiederverwerten zu können.
   -- Wenn durch Stadtschrumpfung die Anforderungen für ein Gebäude nicht mehr erfüllt werden, dann wird dieses Gebäude jetzt entfernt.
   -- Der Eisrand und der benötigte Generatorenabstand dazu ist jetzt Kartengrößenabhängig.
   -- Fehler in Goto behoben, welcher in bestimmten Fällen dafür sorgte dass die Karte auf der alten Position blieb.
   -- Kommentare und Kleinigkeiten korrigiert/angepasst.
   
   
   
   -- Version 0.00.8310 => 0.00.8340 (14.08.2021):
   
   -- Beförderungssystem von Einheiten leicht überarbeitet.
   -- Passierbarkeitsprüfung überarbeitet, sollte jetzt auch bei falsch gesetzten Werten in der Kartendatenbank noch korrekt funktionieren und WegVerbesserungen sollten jetzt frühzeitige Übergänge ermöglichen können.
   -- Weitere Kartenfelder für Unterwasser, Unterirdische und Planeteninneres hinzugefügt.
   -- Die neuen Kartenfelder in die grafische Darstellung eingebaut.
   -- Die neuen Kartenfelder in den Kartengenerator eingebaut.
   -- Die Arbeitsreihenfolge des Kartengenerator überarbeitet und optimiert.
   -- Der Kartengenerator erzeugt jetzt Unterwasser/Unterirdische Landschaften bestehend aus Korallen, Wasser, Unterwasserwald, Erde, Erdgestein und Sand.
   -- Der Kartengenerator erzeugt jetzt Planeteninneres aus Lava, Planetenkern und Gestein.
   -- Unterirdische und Lavaflüsse eingebaut.
   -- Flussgenerierung überarbeitet und für die neuen Flussversionen angepasst.
   -- Grafische Anzeige leicht optimiert und für die neuen Kartenfelder und Flüsse angepasst.
   -- Achsenfehler in der Flussgenerierung behoben.
   -- Ladezeiten an die neue Generierung angepasst.
   -- Unnötigen Code gelöscht.
   -- Einfache Ressourcengenerierung für Unterwasser/Unterirdisch eingebaut.
   -- Contracts, Kommentare und Kleinigkeiten korrigiert/angepasst/hinzugefügt/überarbeitet.
   
   
   
   -- Version 0.00.8280 => 0.00.8310 (13.08.2021):
   
   -- Fehler behoben der es einem ermöglichte den Krieg sofort zu erklären ohne die diplomatische Wartezeit abwarten zu müssen.
   -- Ein Kampfsystem für Städte eingebaut.
   -- Verteidigungsberechnung einer Stadt neu gebaut, es berücksichtigt jetzt auch vorhandene Gebäude.
   -- Prüfung eingebaut um zu verhindern dass eine zu hohe Stadtbevölkerung zu einem Out of Range führt.
   -- Das Einheitenkampfsystem neu geschrieben.
   -- Berechnung für den aktuellen Angriffs- und Verteidigungswert von Einheiten neu gebaut und ausgelagert, damit alle Bereiche des Spiels darauf zugreifen können.
   -- Berechnung für den aktuellen Angriffs- und Verteidigungswert auch für Städte eingebaut.
   -- Bei der Berechnung der Kampfwerte wird jetzt ein Hügel unter anderem Grund korrekt mit einbezogen.
   -- Gebäude, Grund, Flüsse, Straßen und Verbesserungen können jetzt neben einem Verteidigungsbonus auch einen Angriffsbonus geben.
   -- Beförderungssystem leicht überarbeitet.
   -- Anzeigen für die neuen Werte eingebaut und alte Anzeigen überarbeitet.
   -- Doppelten/Unnötigen Code gelöscht.
   -- Fehler in der Beschäftigungsanzeige korrigiert, welcher dafür sorgte dass bei keiner Beschäftigung 'Heilt sich' angezeigt wurde.
   -- Verschanzungsbonus bei verschanzten Einheiten und Stadtbonus für Einheiten in einer Stadt für die Verteidigung eingebaut.
   -- Contracts, Kommentare und Kleinigkeiten korrigiert/angepasst/entfernt/vereinheitlicht/hinzugefügt.
   
   
   
   -- Version 0.00.8250 => 0.00.8280 (12.08.2021):
   
   -- Verbesserung so umgebaut dass es jetzt sowohl als Prüfung als auch Festlegung genutzt werden kann.
   -- Fehler behoben durch den man einen Hügel mit Flachland ersetzen konnte.
   -- Unnötigen Code gelöscht.
   -- KI Prüfung ob die Stadtumgebung verbessert werden kann übersichtlicher gestaltet, die neue Version von Verbesserung eingebunden und den Umgebungsbereich auf die Stadtumgebungsgröße erweitert.
   -- Das Bewegungssystem so überarbeitet dass es jetzt möglich ist Einheiten während der Bewegung Befehle zu erteilen.
   -- Alle Verbesserungsprüfungen und -durchführungen durch die KI auf die neue Version von Verbesserung umgeschrieben/angepasst.
   -- Diverse Prüfungen verschoben um doppelten Code zu vermeiden.
   -- Fehler behoben der es unmöglich machte Einheiten auf modernere Versionen zu verbessern.
   -- Fehler behoben der es verhinderte dass man bestimmte Technologien erforschen konnte.
   -- Passierbarkeitsprüfung beim Bauen einer Einheit eingebaut, so dass man jetzt keine Einheiten mehr in Städten bauen kann deren Umgebung für diese Einheit ungeeignet ist.
   -- GebäudeListeRecord um einen Eintrag für benötigten Kartengrund erweitert und eine Prüfung eingebaut um zu testen ob der eventuell benötigte Grund auch vorhanden ist.
   -- Kurze Beschreibungen zu jeder Rasse eingefügt und englische Übersetzung erweitert.
   -- Angefangen die Anfangstechnologien der restlichen Rassen für mich grafisch aufzuarbeiten.
   -- Kartenverbesserungsenum um Schienen und Tunnel erweitert, aber noch nicht ins Spiel eingebaut.
   -- Kartengrundenum um unterirdische und Lavaflüsse erweitert, aber noch nicht ins Spiel eingebaut.
   -- Fehler in der Steuerung belegen korrigiert, welcher verhinderte dass alle Auswahlmöglichkeiten angezeigt wurden und alle Befehle korrekt neu belegt werden konnten.
   -- Kommentare und Kleinigkeiten korrigiert/angepasst/entfernt/überarbeitet.
   
   
   
   -- Version 0.00.8240 => 0.00.8250 (11.08.2021):
   
   -- Angefangen eine Prüfung ob von einer Rasse auf einem bestimmten Feld eine Verbesserung/Weg angelegt werden kann einzubauen.
   -- Unnötigen Code gelöscht und Dinge zusammengefasst.
   -- Fehler behoben der die aktuelle Beschäftigung falsch anzeigte.
   -- Kommentare und Kleinigkeiten korrigiert/angepasst/entfernt.
   
   
   
   -- Version 0.00.8210 => 0.00.8240 (10.08.2021):
   
   -- Menschlichen Forschungsbaum verfeinert.
   -- Menschliche Einheitendatenbank vorerst vervollständigt.
   -- Umgebungsgrößenänderung von Städten an die aktuell vorhandenen Forschungsbäume angepasst.
   -- Grundlegendes System angelegt um später die Änderung der Stadtumgebungsgröße an jede Rasse individuell anzupassen.
   -- Die Stadtumgebungsgrößenänderungen finden jetzt nicht nur statt wenn die benötigten Bevölkerungen erreicht werden, sondern auch wenn die entsprechenden Technologien erforscht werden.
   -- Es ist jetzt als Mensch möglich, die entsprechenden erforschten Technologien vorausgesetzt, Städte auf dem Wasser, Unterwasser, Unterirdisch, im Planeteninneren, in der Luft und im Orbit zu bauen.
   -- Fehler behoben bei dem durch manuelle Arbeiterplatzierung ein Kartenfeld von mehreren Städte bewirtschaftet werden konnte.
   -- Simple englische Übersetzung eingebaut, welche ab jetzt auch beibehalten werden soll.
   -- Menschliche Gebäudedatenbank stark erweitert und fürs Erste als Standard für alle Rassen gesetzt.
   -- Stadtanzeige für die neuen Gebäude erweitert.
   -- Angefangen Verbesserungen an die neuen Techbaum anzupassen.
   -- Kommentare und Kleinigkeiten korrigiert/angepasst/überarbeitet.
   
   
   
   -- Version 0.00.8190 => 0.00.8210 (09.08.2021):
   
   -- Die Techbäume für mich grafisch weiter konstruiert.
   -- Den menschlichen Techbaum vorerst vervollständigt und eingebaut.
   -- Alle Rassen nutzen fürs Erste den menschlichen Techbaum.
   -- Kleinigkeiten korrigiert.
   
   
   
   -- Version 0.00.8170 => 0.00.8190 (08.08.2021):
   
   -- Kleine Hintergrundgeschichten für die jeweiligen Rassen geschrieben, welche ihre Lebensräume enthalten und eine kurze Beschreibung ihrer Eigenschaften/Entwicklungen liefern.
   -- TextDatenbank angelegt.
   -- Angefangen die Techbäume für mich persönlich grafisch aufzuarbeiten.
   -- Kleinigkeiten korrigiert.
   
   
   
   -- Version 0.00.8150 => 0.00.8170 (07.08.2021):
   
   -- Rassenspezifische Verbesserungengewinne und Kartenbewertung eingebaut/erweitert.
   -- Unnötigen Code gelöscht.
   -- Bei Übernahme einer Rasse durch die KI wird jetzt die Kartenbewertung für diese Rasse durchgeführt.
   -- Minimal nötige Kartenwerte für den Stadtbau durch die KI angepasst und als konstantes Array in KIKonstanten eingebaut.
   -- Bewertung der Kartenfelder deutlich beschleunigt.
   -- Optimierungsmöglichkeiten überprüft.
   -- Wenn eine Stadt entfernt wird, wird jetzt geprüft ob es die Hauptstadt war und wenn nötig eine andere Stadt zur Hauptstadt bestimmt.
   -- Fehler behoben der dazu führte dass nach dem Verlust aller Einheiten und Städte eines menschlichen Spielers das Spiel abstürzte.
   -- Diverse interne und Ordnerumbenennungen.
   -- Hüllen für die Datenbankeditoren angelegt.
   -- Hülle für die Überprüfung ob an einer bestimmten Position eine Verbesserung von dieser Rasse angelegt werden kann eingebaut, inklusive einer Übergangslösung bis die Forschungsbäume weiter/fertig/brauchbar sind.
   -- Kommentare und Kleinigkeiten korrigiert/angepasst/überarbeitet.
   
   
   
   -- Version 0.00.8130 => 0.00.8150 (06.08.2021):
   
   -- Die Tastaturbelegung wird jetzt genauso belegt wie die Datenbanken.
   -- Meldungen für Ereignisse bei Städten und Einheiten eingebaut, inklusive einer Taste um zu diesen Einheiten zu springen.
   -- Wenn sich eine sichtbare Einheit einer anderen Rasse in der Nähe befindet und man mit dieser keinen Nichtangriffspak hat, wird jetzt auch eine Meldung gesetzt.
   -- Man startet jetzt mit 100 Geldeinheiten.
   -- Städtebau in der Luft/im Weltraum/im Planeteninnerem getestet.
   -- Angefangen rassenspezifische Kartenbewertungen und Feldergewinne einzubauen.
   -- Kommentare und Kleinigkeiten korrigiert/angepasst.
   
   
   
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

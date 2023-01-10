package ChangelogAugust2021 is

   -- Version 0.00.8550 => 0.00.8550 (31.08.2021):
   
   -- null.
   
   
   
   -- Version 0.00.8530 => 0.00.8550 (30.08.2021):
   
   -- Textanzeige für die permanenten Kosten/Bonis von EInheiten/Gebäude beim Auswählen eines neuen Bauprojektes eingebaut.
   -- Die KI versucht jetzt nicht mehr Städte auf Felder zu bauen, welche die Siedlereinheit gar nicht betreten kann.
   -- Die KI kann jetzt auch Städte auf Wasser bauen.
   -- Unnötigen Code gelöscht.
   -- Fehler behoben der bei den Prüfungen der Siegbedingungen für einen Absturz sorgte.
   -- Wenn sich Einheiten einer Spezies mit der die KI im Krieg ist in der Nähe einer Stadt auftauchen, dann ändert die KI in dieser Stadt jetzt ihr Bauprojekt auf eine möglichst gute Kampfeinheit.
   -- Die KI baut jetzt mehr Kampfeinheiten wenn sie sich im Krieg mit einer anderen Spezies befindet.
   -- Angefangen eine Überprüfung einzubauen mit der die KI ermitteln kann ob sich ein Krieg mit einer andere Spezies lohnt.
   -- Angefangen die Gefahrenprüfungen für KI Einheiten zu überarbeiten/neu zu schreiben.
   -- Angefangen die Berechnung des Bewegungsplans für KI Einheiten zu überarbeiten.
   -- Die Informationsanzeige durch Cheat übersichtlicher und informativer gestaltet.
   -- Diverse Tests durchgeführt um Fehler/Ungenauigkeiten/Verbesserungsmöglichkeiten zu finden.
   -- Contracts, Kommentare und Kleinigkeiten korrigiert/angepasst/entfernt/hinzugefügt.
   
   
   
   -- Version 0.00.8520 => 0.00.8530 (29.08.2021):
   
   -- Die Darstellung/Änderung der globalen Ressourcenwerte werden jetzt direkt angezeigt/berechnet, anstatt erst eine Runde später.
   -- Die Standardbonis die ein Gebäude geben kann zusammengefasst um sie einfacher aufrufbar/einbaubar zu machen.
   -- Die Verbleibende Produktionszeit wird jetzt immer sofort und korrekt angezeigt, anstatt erst eine Runde später.
   -- Kleinigkeiten korrigiert/überarbeitet.
   
   
   
   -- Version 0.00.8510 => 0.00.8520 (28.08.2021):
   
   -- LeseWichtiges überall angeschlossen.
   -- Berechnungen zwischen den Runden in eigene Datei ausgelagert.
   -- Kommentare und Kleinigkeiten korrigiert/angepasst/überarbeitet.
   
   
   
   -- Version 0.00.8500 => 0.00.8510 (27.08.2021):
   
   -- Unnötigen Code gelöscht.
   -- Formatierung des Codes überarbeitet.
   -- SchreibeWichtiges fertiggestellt und angeschlossen.
   -- LeseWichtiges angelegt.
   -- Kleinigkeiten korrigiert/angepasst.
   
   
   
   -- Version 0.00.8480 => 0.00.8500 (26.08.2021):
   
   -- InDerStadtBauen vereinfacht durch Auslagerung der Einheiten/Gebäudeprüfungen.
   -- Die ausgelagerten Einheiten/Gebäudeprüfungen bei den KI Prüfungen für das Bauen von Einheiten und Gebäuden eingebunden.
   -- Einfaches Gebäudebewertungssystem für die KI fertiggestellt, wodurch beim Gebäudebau die Vorteile, permanenten Kosten und der Preis der Gebäude berücksichtigt werden.
   -- Einfaches Einheitbewertungssystem für die KI fertiggestellt, wodurch beim Gebäudebau die permanenten Kosten, der Preis und die bereits vorhandenen Einheiten gleicher Art berücksichtigt werden.
   -- Angefangen EinheitenAllgemein in verschiedene, aufgabenspezifische Dateien zu zerlegen.
   -- Benennungen von Datentypen sinnvoll angepasst und unnötige Typen entfernt, außerdem angefangen die GlobalenDateien zu überarbeiten.
   -- Formatierung des Codes überarbeitet.
   -- Diverse Prüfungen ob eine Forschung möglich ist ausgelagert und in einer Funktion zusammengefasst.
   -- Die neue Forschungsfunktion bei der KI eingebaut.
   -- Unnötigen Code gelöscht.
   -- LeseSpeziesDatenbank angelegt und überall eingebunden.
   -- Kommentare und Kleinigkeiten korrigiert/angepasst/gelöscht/hinzugefügt.
   
   
   
   -- Version 0.00.8470 => 0.00.8480 (25.08.2021):
   
   -- Umgebungsprüfung für den Bau von Einheiten ausgelagert damit sie auch für die KI verwendet werden kann.
   -- Kleine Anpassungen an der Bewertung des nächsten Bauprojektes der KI vorgenommen.
   -- Contracts, Kommentare und Kleinigkeiten korrigiert/angepasst.
   
   
   
   -- Version 0.00.8450 => 0.00.8470 (24.08.2021):
   
   -- Leichte Codeanpassungen um unnötige Mehrfachaufrufe/Berechnungen zu vermeiden.
   -- Diverse Fehler korrigiert die aufgrund der neuen Lese/Schreibefunktionen entstanden sind.
   -- Suchenfunktionen für Einheiten und Städte optimiert.
   -- Optimierungen in der Darstellungsgeschwindigkeit bei maximaler Kartengröße vorgenommen.
   -- Rundungsungenauigkeiten beim Ermitteln der Kampfwerte von Einheiten entfernt.
   -- Weitere Prüfungen eingebaut um Over/Underflow zu verhindern.
   -- Angefangen die Stadtverwaltungs- und Verteidigungsfähigkeiten der KI zu erweitern.
   -- Gebäude/EinheitenID und das Speichern als Bauprojekt überdacht.
   -- Diverse Prüfungen eingebaut um bei falsch gesetzten/berechneten Werte sichere Standardwerte zurückzugeben.
   -- Die KI berücksichtigt beim Bauen von Gebäuden jetzt auch die benötigten Umgebungsvoraussetzungen.
   -- Angefangen eine Bewertung von Einheiten und Gebäuden einzubauen, anhand derer die KI Bauprojekte in ihren Städten auswählt.
   -- Kommentare und Kleinigkeiten korrigiert/angepasst/entfernt/hinzugefügt/überarbeitet.
   
   
   
   -- Version 0.00.8420 => 0.00.8450 (23.08.2021):
   
   -- Lesefunktionen für die Datenbanken fertig erstellt.
   -- Alles Lesefunktionen und Schreibefunktionen für die Datenbanken, EinheitenGebaut und StadtGebaut, bis auf einige Ausnahmen, eingebaut.
   -- Einige Teile des Codes an die neuen Funktionen angepasst.
   -- Diverse jetzt unnötige Prüfungen gelöscht.
   -- Unnötigen Code gelöscht.
   -- Diverse Fehler korrigiert und fehlende Over/Underflowprüfungen eingebaut.
   -- Contracts, Kommentare und Kleinigkeiten korrigiert/angepasst/hinzugefügt/entfernt/überarbeitet.
   
   
   
   -- Version 0.00.8410 => 0.00.8420 (22.08.2021):
   
   -- LeseFunktionen für die Datenbanken weiter erstellt.
   -- Änderungen an Lese/SchreibeEinheitenGebaut vorgenommen und überall wo es aktuell halbwegs sinnvoll ist eingebaut.
   -- Contracts, Kommentare und Kleinigkeiten korrigiert/angepasst/hinzugefügt/entfernt.
   
   
   
   -- Version 0.00.8410 => 0.00.8410 (21.08.2021):
   
   -- null.
   
   
   
   -- Version 0.00.8400 => 0.00.8410 (20.08.2021):
   
   -- LeseEinheitenGebaut und SchreibeEinheitenGebaut wird jetzt fast überall verwendet um die Werte in GebautVariablen.EinheitenGebaut zu Lesen/Schreiben und dabei die entsprechenden Prüfungen durchzuführen.
   -- Kleinigkeiten korrigiert/angepasst.
   
   
   
   -- Version 0.00.8390 => 0.00.8400 (19.08.2021):
   
   -- LeseStadtGebaut und SchreibeStadtGebaut fürs Erste fertiggestellt.
   -- BewegungFloat angelegt.
   -- Contracts und Kleinigkeiten korrigiert/angepasst/hinzugefügt.
   
   
   
   -- Version 0.00.8380 => 0.00.8390 (18.08.2021):
   
   -- LeseEinheitenGebaut und SchreibeEinheitenGebaut fürs Erste fertiggestellt.
   -- Angefangen LeseEinheitenEingebaut überall einzubauen.
   -- Dateien für alle weiteren Lese/Schreibezugriffe angelegt.
   -- Contracts und Kleinigkeiten korrigiert/angepasst/hinzugefügt.
   
   
   
   -- Version 0.00.8370 => 0.00.8380 (17.08.2021):
   
   -- Alle lesenden Zugriffe auf Weltkarte.Karte erfolgen jetzt über LeseWeltkarte.
   -- SchreibeKarten erstellt und alle schreibenden Zugriffe auf Weltkarte.Karten darauf umgelegt.
   -- Die Grundänderung von irgendeinem Grund auf Hügel sollte jetzt immer Hügel auf False setzen.
   -- Angefangen alle lesenden Zugriff auf GebautVariablen.EinheitenGebaut über LeseEinheitenGebaut umzuleiten.
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
   -- Passierbarkeitsprüfung überarbeitet, sollte jetzt auch bei falsch gesetzten Werten in der KartengrundDatenbank noch korrekt funktionieren und WegVerbesserungen sollten jetzt frühzeitige Übergänge ermöglichen können.
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
   -- Kurze Beschreibungen zu jeder Spezies eingefügt und englische Übersetzung erweitert.
   -- Angefangen die Anfangstechnologien der restlichen Spezies für mich grafisch aufzuarbeiten.
   -- Kartenverbesserungsenum um Schienen und Tunnel erweitert, aber noch nicht ins Spiel eingebaut.
   -- Kartengrundenum um unterirdische und Lavaflüsse erweitert, aber noch nicht ins Spiel eingebaut.
   -- Fehler in der Steuerung belegen korrigiert, welcher verhinderte dass alle Auswahlmöglichkeiten angezeigt wurden und alle Befehle korrekt neu belegt werden konnten.
   -- Kommentare und Kleinigkeiten korrigiert/angepasst/entfernt/überarbeitet.
   
   
   
   -- Version 0.00.8240 => 0.00.8250 (11.08.2021):
   
   -- Angefangen eine Prüfung ob von einer Spezies auf einem bestimmten Feld eine Verbesserung/Weg angelegt werden kann einzubauen.
   -- Unnötigen Code gelöscht und Dinge zusammengefasst.
   -- Fehler behoben der die aktuelle Beschäftigung falsch anzeigte.
   -- Kommentare und Kleinigkeiten korrigiert/angepasst/entfernt.
   
   
   
   -- Version 0.00.8210 => 0.00.8240 (10.08.2021):
   
   -- Menschlichen Forschungsbaum verfeinert.
   -- Menschliche Einheitendatenbank vorerst vervollständigt.
   -- Umgebungsgrößenänderung von Städten an die aktuell vorhandenen Forschungsbäume angepasst.
   -- Grundlegendes System angelegt um später die Änderung der Stadtumgebungsgröße an jede Spezies individuell anzupassen.
   -- Die Stadtumgebungsgrößenänderungen finden jetzt nicht nur statt wenn die benötigten Bevölkerungen erreicht werden, sondern auch wenn die entsprechenden Technologien erforscht werden.
   -- Es ist jetzt als Mensch möglich, die entsprechenden erforschten Technologien vorausgesetzt, Städte auf dem Wasser, Unterwasser, Unterirdisch, im Planeteninneren, in der Luft und im Orbit zu bauen.
   -- Fehler behoben bei dem durch manuelle Arbeiterplatzierung ein Kartenfeld von mehreren Städte bewirtschaftet werden konnte.
   -- Simple englische Übersetzung eingebaut, welche ab jetzt auch beibehalten werden soll.
   -- Menschliche Gebäudedatenbank stark erweitert und fürs Erste als Standard für alle Spezies gesetzt.
   -- Stadtanzeige für die neuen Gebäude erweitert.
   -- Angefangen Verbesserungen an die neuen Techbaum anzupassen.
   -- Kommentare und Kleinigkeiten korrigiert/angepasst/überarbeitet.
   
   
   
   -- Version 0.00.8190 => 0.00.8210 (09.08.2021):
   
   -- Die Techbäume für mich grafisch weiter konstruiert.
   -- Den menschlichen Techbaum vorerst vervollständigt und eingebaut.
   -- Alle Spezies nutzen fürs Erste den menschlichen Techbaum.
   -- Kleinigkeiten korrigiert.
   
   
   
   -- Version 0.00.8170 => 0.00.8190 (08.08.2021):
   
   -- Kleine Hintergrundgeschichten für die jeweiligen Spezies geschrieben, welche ihre Lebensräume enthalten und eine kurze Beschreibung ihrer Eigenschaften/Entwicklungen liefern.
   -- TextDatenbank angelegt.
   -- Angefangen die Techbäume für mich persönlich grafisch aufzuarbeiten.
   -- Kleinigkeiten korrigiert.
   
   
   
   -- Version 0.00.8150 => 0.00.8170 (07.08.2021):
   
   -- Speziesspezifische Verbesserungengewinne und Kartenbewertung eingebaut/erweitert.
   -- Unnötigen Code gelöscht.
   -- Bei Übernahme einer Spezies durch die KI wird jetzt die Kartenbewertung für diese Spezies durchgeführt.
   -- Minimal nötige Kartenwerte für den Stadtbau durch die KI angepasst und als konstantes Array in KIKonstanten eingebaut.
   -- Bewertung der Kartenfelder deutlich beschleunigt.
   -- Optimierungsmöglichkeiten überprüft.
   -- Wenn eine Stadt entfernt wird, wird jetzt geprüft ob es die Hauptstadt war und wenn nötig eine andere Stadt zur Hauptstadt bestimmt.
   -- Fehler behoben der dazu führte dass nach dem Verlust aller Einheiten und Städte eines menschlichen Spielers das Spiel abstürzte.
   -- Diverse interne und Ordnerumbenennungen.
   -- Hüllen für die Datenbankeditoren angelegt.
   -- Hülle für die Überprüfung ob an einer bestimmten Position eine Verbesserung von dieser Spezies angelegt werden kann eingebaut, inklusive einer Übergangslösung bis die Forschungsbäume weiter/fertig/brauchbar sind.
   -- Kommentare und Kleinigkeiten korrigiert/angepasst/überarbeitet.
   
   
   
   -- Version 0.00.8130 => 0.00.8150 (06.08.2021):
   
   -- Die Tastaturbelegung wird jetzt genauso belegt wie die Datenbanken.
   -- Meldungen für Ereignisse bei Städten und Einheiten eingebaut, inklusive einer Taste um zu diesen Einheiten zu springen.
   -- Wenn sich eine sichtbare Einheit einer anderen Spezies in der Nähe befindet und man mit dieser keinen Nichtangriffspak hat, wird jetzt auch eine Meldung gesetzt.
   -- Man startet jetzt mit 100 Geldeinheiten.
   -- Städtebau in der Luft/im Weltraum/im Planeteninnerem getestet.
   -- Angefangen Speziesspezifische Kartenbewertungen und Feldergewinne einzubauen.
   -- Kommentare und Kleinigkeiten korrigiert/angepasst.
   
   
   
   -- Version 0.00.8110 => 0.00.8130 (05.08.2021):
   
   -- Menschlichen Forschungsbaum überarbeitet und deutlich erweitert.
   -- Experimente mit richtiger Grafik gemacht.
   -- Kleinigkeiten korrigiert.
   
   
   
   -- Version 0.00.8100 => 0.00.8110 (04.08.2021):
   
   -- Zeit seit letzter Änderung des diplomatischen Zustandes wird jetzt am Ende jeder Runde erhöht (mit Überlaufschutz).
   -- Grenzen für die maximale Sympathie, in Abhängigkeit vom aktuellen Status, eingebaut.
   -- Sympathie wird am Ende jeder Runde für bekannte Spezies um eins bis zum Maximum erhöht.
   -- Einige diplomatischen Zustände rausgeworfen um die unnötige Komplexität zu reduzieren.
   -- Man kann jetzt Geld verlangen.
   -- Prüfungen ob die Änderuing des aktuellen Zustandes möglich ist, in Abhängigkeit von Sympathie und letzter Zustandänderung, eingebaut.
   -- Aktuelle Sympathiewerte werden bei Zustandänderung jetzt angepasst.
   -- Geld schenken/verlangen hat jetzt Auswirkung auf die aktuelle Sympathie.
   -- Speziesspezifische Bewertung von Kartenfeldern/Verbesserungen eingebaut.
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
   -- Sichtbarkeitscheat setzt jetzt auch alle Spezies auf Bekannt.
   -- Es ist jetzt möglich den diplomatischen Zustand zu einer anderen Spezies zu ändern.
   -- Angefangen ein Handelsmenü einzubauen.
   -- Wenn ein menschlicher Spieler das Spiel verlässt und noch weitere Menschen vorhanden sind, wird das Spiel jetzt nicht mehr beendet sonder die Spezies des Spielers auf die KI übertragen.
   -- Eine Möglichkeit eingebaut Einheiten einer anderen Spezies unter bestimmten Bedingungen von seinem eigenen Land zu entfernen.
   -- Fehler behoben der dazu führte dass eine SpielerSpezies auch dann auf die KI gesetzt wurde wenn nur die Runde beendet wurde.
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

end ChangelogAugust2021;

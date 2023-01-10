package ChangelogOktober2022 is

   -- Version 0.04.2685 => 0.04.2785 (31.10.2022):
   
   -- Weiter pragma Pure, Preelaborate und Elaborate_Body eingebaut.
   -- Unnötigen Code gelöscht.
   -- Code zusammengeführt.
   -- Einheitentausch für die KI eingebaut.
   -- Zusätzliche NotAus für die Schleifen der KI eingebaut.
   -- Diagnosesystem eingebaut um einfacher Informationen über bestimmte Werte zu erhalten.
   -- Die KI baut jetzt zu Friedenszeiten weniger Einheiten.
   -- Wenn ein Siedler jetzt keine Verbesserung mehr anlegen kann, dann versucht er eine Stadt bauen zu gehen.
   -- Contracts, Kommentare und Kleinigkeiten korrigiert/angepasst/überarbeitet.
   
   

   -- Version 0.04.2625 => 0.04.2685 (30.10.2022):
   
   -- Weiter pragma Pure, Preelaborate und Elaborate_Body eingebaut.
   -- Eine KIEinheit kann jetzt unter bestimmten Bedingungen einer anderen KIEinheit der gleichen Spezies befehlen sich wegzubewegen.
   -- Mehr Testgrafiken für die Einheiten erstellt und eingebaut.
   -- Ist eine Einheit auf einem Transporter ausgewählt, dann wird jetzt diese Einheit blinken angezeigt anstelle des Transporters.
   -- Conatracts, Kommentare und Kleinigkeiten korrigiert/überarbeitet.
   
   

   -- Version 0.04.2595 => 0.04.2625 (29.10.2022):
   
   -- Angefangen pragma Pure, Preelaborate und Elaborate_Body einzubauen.
   -- Unnötigen Code gelöscht.
   
   

   -- Version 0.04.2575 => 0.04.2595 (28.10.2022):
   
   -- Mit pragma Pure, Preelaborate und Elaborate_Body herumexperimentiert.
   
   

   -- Version 0.04.2440 => 0.04.2575 (27.10.2022):
   
   -- Die Kartenfelder in einen notwendigen Basisgrund und einen optionalen Zusatzgrund aufgeteilt.
   -- Alles an die neue Aufteilung der Kartenfelder angepasst.
   -- Berechnungen der Wirtschaft- und Kampfewerte eines Kartenfeldes überarbeitet, es berücksichtigt jetzt beide Grundarten.
   -- Unnötigen Code gelöscht.
   -- Code zusammengeführt.
   -- Interne Benennung überarbeitet.
   -- Grafikleistung verbessert.
   -- Kartenanzeige überarbeitet.
   -- Stadtanzeige überarbeitet.
   -- Testgrafiken zu GitHub hinzugefügt.
   -- Einige Texte und den Zugriff darauf neu aufgeteilt und erweitert.
   -- Contracts, Kommentare und Kleinigkeiten korrigiert/angepasst/überarbeitet/optimiert.
   
   

   -- Version 0.04.2440 => 0.04.2440 (26.10.2022):
   
   -- null.
   
   

   -- Version 0.04.2350 => 0.04.2440 (25.10.2022):
   
   -- Merkwürde Unterscheideung beim Schreiben einiger Einheitenwerte durch einen Boolean ersetzt.
   -- Einige Datentypen angepasst um Einheitenwerte einfacher anpassen zu können.
   -- Unnötigen Code gelöscht.
   -- Datentypen überarbeitet.
   -- Debugsystem überarbeitet.
   -- Die KI baut jetzt keine Gebäude mehr die eine zu niedrige Bewertung haben.
   -- Die KI baut jetzt keine veralteten Einheiten mehr.
   -- Contracts, Kommentare und Kleinigkeiten korrigiert/angepasst/überarbeitet.
   
   

   -- Version 0.04.2310 => 0.04.2350 (24.10.2022):
   
   -- Versucht Teile des Codes auf SPARK zu verbessern und dabei erfolgreich gescheitert?
   -- Unnötigen Code gelöscht.
   -- Contracts, Kommentare und Kleinigkeiten korrigiert/überarbeitet.
   
   

   -- Version 0.04.2200 => 0.04.2310 (23.10.2022):
   
   -- Fehler korrigiert der bei sehr großen Karten und der Kartenart Pangäa zu abstürzen führte.
   -- Unnötigen Code gelöscht.
   -- Mehr auf das Zehnerbewertungssystem umgebaut.
   -- Kampfsysteme überarbeitet.
   -- Die KI greift jetzt wieder mit Kampfeinheiten an.
   -- Code zusammengeführt.
   -- Diverse Zahlen durch Konstante ersetzt.
   -- Interne Benennung überarbeitet.
   -- Textformatierung überarbeitet.
   -- Contracts, Kommentare und Kleinigkeiten korrigiert/überarbeitet/optimiert.
   
   

   -- Version 0.04.2110 => 0.04.2200 (22.10.2022):
   
   -- GNAT von 12.2.0-5 auf GNAT 12.2.0-7 aktualisiert.
   -- Bewertungssystem der Kartenfelder für die KI entfernt.
   -- Unnnötigen Code gelöscht.
   -- Arbeisspeicherverbrauch um rund 75 MB reduziert.
   -- System zu Bewertung eines Feld für den Städtebau überarbeitet.
   -- Datentypen besser aufgeteilt.
   -- Sprachen und dynamische gpr Datei an die letzten Änderungen angepasst.
   -- Contracts, Kommentare und Kleinigkeiten korrigiert/überarbeitet.
   
   

   -- Version 0.04.2000 => 0.04.2110 (21.10.2022):
   
   -- Die KI bewegt jetzt Einheiten aus dem Weg, wenn die Einheit nichts zu tun hat und auf einem Zielfeld einer anderen Einheit steht.
   -- Diverse Zahlen durch Konstante ersetzt.
   -- Die KIBerechnung welche Einheit eine Stadt bauen soll überarbeitet.
   -- Die KI versucht beim Erkunden der Karte nicht mehr die Einheit auf ein unpassierbares Feld zu schicken, wenn das Feld aufgedeckt wurde.
   -- Die KI versucht jetzt nicht mehr Einheiten auf unpassierbare Felder die sie sehen kann zu schicken.
   -- Die KI erkundet jetzt alle Kartenebenen.
   -- Kartenfelderbewertung überarbeitet.
   -- Positionsbestimmung für eine neue Stadt der KI überarbeitet.
   -- Windowsversion vollständig an die letzten Struktur- und Namensänderungen angepasst.
   -- Contracts, Kommenatre und Kleinigkeiten korrigiert/angepasst/überarbeitet.
   
   

   -- Version 0.04.1880 => 0.04.2000 (20.10.2022):
   
   -- Interne Struktur überarbeitet.
   -- Externe Struktur überarbeitet.
   -- Wenn eine Einheit über das Sichtfeld hinaus bewegt wird, dann wird jetzt die Kartenansicht entsprechend mitverschoben.
   -- Texturen überarbeitet.
   -- Wenn eine Einheit jetzt an die Position der Befehlsfelder geschoben wird, werden die Befehlsfelder nach links verschoben.
   -- Wenn man sich im unteren rechten Teil der Karte befindet, werden die Befehlsfelder nach links verschoben.
   -- Unnötigen Code gelöscht.
   -- Diverse Zahlen durch Konstante ersetzt.
   -- KartenDatentypen aufgeteilt.
   -- Zusätzliche Fehlermeldungen und Prüfungen eingebaut.
   -- Contracts, Kommentare und Kleinigkeiten korrigiert/überarbeitet/angepasst.
   
   

   -- Version 0.04.1750 => 0.04.1880 (19.10.2022):
   
   -- Interne Struktur überarbeitet.
   -- Externe Struktur überarbeitet.
   -- Namen und Anzeige überarbeitet.
   -- GitHub-Repository überarbeitet.
   -- Intro überarbeitet.
   -- Ende überarbeitet.
   -- Fehler in der Zeilenumbruchsberechnung korrigiert, welcher zu einem Endlosloop führte.
   -- Neue Texturen erstellt.
   -- Alte Texturen überarbeitet.
   -- Neue Gebäudetextur erstellt.
   -- Neue Beispielbilder erstellt.
   -- Contracts, Kommentare und Kleinigkeiten korrigiert/überarbeitet.
   
   

   -- Version 0.04.1655 => 0.04.1750 (18.10.2022):
   
   -- Neue Texturen erstellt.
   -- Alte Texturen überarbeitet.
   -- Ressourcen werden jetzt über den Flüssen angezeigt, statt wie bisher darunter.
   -- Vollständigen Satz an Ressourcentexturen erstellt.
   -- Fehler korrigiert der die Anzeige des Endbildes verhinderte.
   -- Eigenes Bild für die Planetensprengung durch den Einsatz einer PZB erstellt.
   -- Neue Beispielbilder erstellt.
   -- Stadtnamen werden jetzt Schwarz angezeigt, wenn sie sich im Himmel befinden.
   -- Kommentare und Kleinigkeiten korrigiert/angepasst.
   
   

   -- Version 0.04.1555 => 0.04.1655 (17.10.2022):
   
   -- Lizenz von Apache 2.0 zu GPL 3.0 geändert.
   -- Bewegungsbonus um Tunnel erweitert und es gibt jetzt keinen Bonus mehr für Lavaflüsse.
   -- Befehlsknopfpositionen an die vergangenen Änderungen angepasst.
   -- Diverse Zahlen durch Konstante ersetzt.
   -- Fehler korrigiert, welche bei sehr schnellem Scrollen dafür sorgte dass die Ebene nicht korrekt gewechselt wurde.
   -- Neue Texturen erstellt.
   -- Alte Texturen überarbeitet.
   -- Vollständigen Satz an Verbesserungentexturen erstellt.
   -- Kommentare und Kleinigkeiten korrigiert/überarbeitet/angepasst.
   
   

   -- Version 0.04.1445 => 0.04.1555 (16.10.2022):
   
   -- Fehler korrigiert der es ermöglichte Einheiten auf ein Feld zu ziehen, welches für die Einheit nicht passierbar war.
   -- Fehler korrigiert mit dem es möglich war Einheiten in Städten zu bauen die nicht die richtige Umgebung hatten.
   -- Fehler korrigiert der dafür sorgte dass beim Spielstart manchmal die Karte nicht korrekt aufgedeckt oder die Kamera falsch positioniert wurde.
   -- Fehler korrigiert der dafür sorgte dass erst bei Rundenende eine besiegte Spezies auf Leer gesetzt wurde.
   -- Diverse Zahlen durch Konstante ersetzt.
   -- Code zusammengeführt.
   -- Teile des Codes neu aufgeteilt um die Kompilierzeit zu reduzieren.
   -- Gebäudedatenbank überarbeitet, so dass die aktuelle Ebene ebenfalls als Voraussetzung für ein Gebäude dienen kann.
   -- Prüfung ob ein Gebäude baubar ist überarbeitet und an die neue Datenbank angepasst.
   -- Contracts, Kommentare und Kleinigkeiten korrigiert/überarbeitet/angepasst.
   
   

   -- Version 0.04.1355 => 0.04.1445 (15.10.2022):
   
   -- Neue Texturen erstellt.
   -- Alte Texturen überarbeitet.
   -- Vollständigen Satz an Tunneltexturen erstellt.
   -- Neue Stadttexturen erstellt.
   -- Fehler korrigiert der es ermöglichte auf unzulässigen Feldern eine Straße zu bauen.
   -- Fehler korrigiert welcher dazu führte das unter der Erde eine Straße/Schiene anstelle eines Tunnels gebaut wurde.
   -- Fehler korrigiert der dazu führte das eine unterirdische Stadt bei ihrem Bau eine Straße statt einem Tunnel anlegte.
   -- Contract, Kommentare und Kleinigkeiten korrigiert/angepasst.
   
   

   -- Version 0.04.1300 => 0.04.1355 (14.10.2022):
   
   -- Neue Texturen erstellt.
   -- Alte Texturen überarbeitet.
   -- Vollständigen Satz an Schienentexturen erstellt.
   -- Fehler korrigiert der beim Bau einer Stadt dazu führte das ein besserer Weg als eine Straße durch eine Straße ersetzt wurde.
   -- Kleinigkeiten korrigiert.
   
   

   -- Version 0.04.1300 => 0.04.1300 (13.10.2022):
   
   -- null.
   
   

   -- Version 0.04.1235 => 0.04.1300 (12.10.2022):
   
   -- Neue Texturen erstellt.
   -- Alte Texturen überarbeitet.
   -- Vollständigen Satz an Wegetexturen erstellt.
   -- Neue Schienentexturen erstellt.
   -- Auch beim Speichern durch Listenauswahl wird jetzt gefragt ob ein vorhandener Spielstand überschrieben werden soll.
   -- Kommentare und Kleinigkeiten korrigiert.
   
   

   -- Version 0.04.1200 => 0.04.1235 (11.10.2022):
   
   -- Neue Texturen erstellt.
   -- Alte Texturen überarbeitet.
   -- Kleinigkeiten korrigiert.
   
   

   -- Version 0.04.1125 => 0.04.1200 (10.10.2022):
   
   -- Kartenkoordinatenberechnungssystem sollte jetzt immer für alle Arten von Kartenübergängen funktionieren.
   -- Es werden jetzt auch bei extremeren Kartenformeinstellungen keine schwarzen Ränder mehr angezeigt.
   -- Es ist jetzt auch bei extremeren Kartenformeinstellungen nicht mehr möglich aus der Karte herauszuscrollen.
   -- Position der Befehlsknöpfe angepasst damit Scrollen nach unten rechts wieder möglich ist.
   -- Texturen für die Kartenformanzeige erstellt.
   -- Bei Auswahl der Kartenformen wird jetzt eine Grafik angezeigt die erklärt was die aktuell ausgewählte Einstellung macht.
   -- Kommentare und Kleinigkeiten korrigiert/überarbeitet.
   
   

   -- Version 0.04.1125 => 0.04.1125 (09.10.2022):
   
   -- null
   
   

   -- Version 0.04.1100 => 0.04.1125 (08.10.2022):
   
   -- Neue Texturen erstellt.
   -- Kommentare und Kleinigkeiten korrigiert.
   
   

   -- Version 0.04.1065 => 0.04.1100 (07.10.2022):
   
   -- Weiter daran gearbeitet die Kartenkoordinatenberechnungen für alle Kartenformen anzupassen.
   -- Selbst bei merkwürdigen Kartenformen und sehr kleinen Karten stürzt das Spiel jetzt nicht mehr ab.
   -- Kommentare und Kleinigkeiten korrigiert/aufgeteilt.
   
   

   -- Version 0.04.0975 => 0.04.1065 (06.10.2022):
   
   -- Abbrechen/Abwählen kann jetzt auch neu belegt werden, von ein paar Ausnahmen abgesehen.
   -- Die Tastenbelegung für die Stadt ist jetzt Nutzereinstellbar.
   -- Stadtbefehle können jetzt wieder über Tasteneingaben durchgeführt werden.
   -- Diverse allgemeine und Speziesspezifische Anpassungen an den Passierbarkeitprüfungen für Einheiten vorgenommen.
   -- Es wird jetzt für den gesamten Bereich den eine Stadt belegt geprüft ob eine Einheit dort platziert werden kann und nicht nur für die direkte Umgebung.
   -- Die Ekropa können jetzt Schienen über das Wasser bauen.
   -- Angefangen die Kartenkoordinatenberechnungen für alle Kartenformen anzupassen.
   -- Contracts, Kommentare und Kleinigkeiten korrigiert/angepasst/überarbeitet.
   
   

   -- Version 0.04.0875 => 0.04.0975 (05.10.2022):
   
   -- Fehler im neuen Eingabesystem korrigiert, welcher dazu führte das Auswählen permanent aktiv war.
   -- Unnötigen Code gelöscht.
   -- Code zusammengeführt.
   -- Logik- und Grafiktask noch besser voneinander getrennt.
   -- Es ist jetzt nicht mehr möglich teilweise aus der Karte rauszuscrollen, wenn man die Tastatur zum scrollen verwendet.
   -- Neues Steuerungsmenü gebaut, was mehrere Kategorien zulässt und mit der neuen Steuerungsaufteilung funktioniert.
   -- Tastenbelegung durch den Nutzer an die neue Steuerungsaufteilung angepasst.
   -- Wenn die Sichtweite größer ist als die Kartengröße, dann wird die Karte jetzt, unter Berücksichtigung der Kartenarteinstellungen, mittig zentriert.
   -- Contracts, Kommentare und Kleinigkeiten korrigiert/angepasst/überarbeitet.
   
   

   -- Version 0.04.0750 => 0.04.0875 (04.10.2022):
   
   -- GNAT auf Version Debian 12.2.0-5 aktualisiert.
   -- Transporter werden jetzt nicht mehr automatisch entladen wenn man sie auf eine Stadt bewegt.
   -- Man kann jetzt über einen Befehlsknopf alle Arten von Transportern entladen.
   -- Angefangen die Tastenbelegung in eine Allgemeines und eine Einheiten Belegung umzubauen.
   -- Einheitenbefehle haben jetzt eine eigene Tastenbelegung und können nur noch mit ausgewählter Einheit durchgeführt werden.
   -- Allgemeine Befehle haben jetzt eine eigene Tastenbelegung.
   -- Es ist jetzt wieder möglich mit der Tastatur die Karte zu scrollen, wenn keine Einheit ausgewählt ist.
   -- Unnötigen Code gelöscht.
   -- Code zusammengeführt.
   -- Vereinfachte Tasteneingabe eingebaut.
   -- Contracts, Kommentare und Kleinigkeiten korrigiert/überarbeitet/angepasst/optimiert.
   
   

   -- Version 0.04.0670 => 0.04.0750 (03.10.2022):
   
   -- Noch mehr Tests und Einstellungen durchgeführt um eine vollständig plattformunabhängige Version zu bekommen, aber der scheiß funktioniert einfach nicht so wie ich das haben will.
   -- Diverse Prüfungen eingebaut um Abstürze zu verhindern.
   -- Passierbarkeitssystem überarbeitet, Passierbarkeit wird jetzt immer korrekt auf Basis des Grunds, vorhandener Stadt und vorhandenem Weg geprüft.
   -- Fehler korrigiert, welcher das Einlesen einiger Standarddatenbanken verhinderte.
   -- Fehler korrigiert, welcher es ermöglichte Einheiten den Platz tauschen zu lassen, auch wenn der Grund der einen Einheit von der anderen Einheit gar nicht betretbar war.
   -- Angefangen das automatische Ausladen wenn ein beladener Transporter sich auf eine Stadt bewegt durch eine Befehl auszutauschen welcher den Transporter automatisch vollständig entlädt.
   -- Contracts, Kommentare und Kleinigkeiten korrigiert/überarbeitet/angepasst.
   
   

   -- Version 0.04.0595 => 0.04.0670 (02.10.2022):
   
   -- Diverse Spieletest unter Linux und Windows durchgeführt.
   -- Die Linux- und Windowsversion besser aufgeteilt.
   -- Weiteres virtuelles System mit Debian Bullseye aufgesetzt um Bibliotheken mit älteren Versionen kompilieren zu können.
   -- Satisch gelinkte Versionen aller Bibliotheken auf Basis der Entwicklungsdateien aus Debian Bullseye erstellt und getestet.
   -- Mehrfaches, vollständiges Backup erstellt.
   -- Kommentare und Kleinigkeiten korrigiert.
   
   

   -- Version 0.04.0550 => 0.04.0595 (01.10.2022):
   
   -- Die Bewegungskostenberechnung für Einheiten überarbeitet.
   -- Die VerbesserungenDatenbank überarbeitet.
   -- Unnötigen Code gelöscht.
   -- Contracts, Kommentare und Kleinigkeiten korrigiert.

end ChangelogOktober2022;

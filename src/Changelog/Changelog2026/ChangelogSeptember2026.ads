package ChangelogSeptember2026 is
   pragma Pure;

   -- Version 0.06.6100 => 0.06. (30.09.2026):
   
   -- 
   -- Kleinigkeiten korrigiert.
   
   

   -- Version 0.06.6045 => 0.06.6100 (29.09.2026):
   
   -- Texturen für Steppe, Savanne und Arktis hinzugefügt und Texturen für Eis überarbeitet.
   -- Diagnosesystem erweitert.
   -- Weiter am neuen Rohstoffsystem gearbeitet.
   -- Angefangen die Anzeige der Rohstoffe zu überarbeiten.
   -- Kommentare und Kleinigkeiten korrigiert/angepasst.
   
   

   -- Version 0.06.5980 => 0.06.6045 (28.09.2026):
   
   -- Angefangen den Basisgrund um Steppe, Savanne und Arktisch zu erweitern.
   -- Weiter am Zusatzgrund Riffe gearbeitet.
   -- Flachland in Grasland umbenannt.
   -- Texturen an die Änderungen angepasst.
   -- Texte an die Änderungen angepasst.
   -- Kommentare und Kleinigkeiten korrigiert/angepasst.
   
   

   -- Version 0.06.5910 => 0.06.5980 (27.09.2026):
   
   -- RückgabeDatentypen zusammengekürzt.
   -- Code zusammengeführt.
   -- Unnötigen Code gelöscht.
   -- RohstoffeDatentypen erweitert, denn wenn schon übertreiben dann auch richtig.
   -- Angefangen Riffe als Zusatzgrund einzubauen.
   -- Contracts, Kommentare und Kleinigkeiten korrigiert/angepasst/überarbeitet.
   
   

   -- Version 0.06.5830 => 0.06.5910 (26.09.2026):
   
   -- Die minimale Auflösung von 640x480 auf 1x1 geändert, für den Fall dass jemand eine Briefmarke spielen will.
   -- Bei Änderung der Fensterauflösung durch manuelles Ziehen wird die Auflösung jetzt auch gespeichert und beim nächsten Spielstart geladen.
   -- Neben normalem Fenstermodus und Vollbild ist es jetzt auch möglich Rahmenloses Fenster einzustellen.
   -- Unnötigen Code gelöscht.
   -- Diverse Werte durch besser benannte Konstanten ersetzt.
   -- Debugmenü überarbeitet.
   -- Contracts, Kommentare und Kleinigkeiten korrigiert/angepasst/überarbeitet.
   
   

   -- Version 0.06.5760 => 0.06.5830 (25.09.2026):
   
   -- Fehler korrigiert welcher dazu führte dass die Stadtkarte falsch angezeigt wurde.
   -- Die Gebäudegrafiken werden in der Stadtkarte jetzt korrekt skaliert.
   -- Die Berechnung der Texturenfeldergröße neugeschrieben.
   -- Texturen an die neue Berechnung der einzelnen Texturenfelder angepasst.
   -- Es werden jetzt nur noch die Schaltfläche für die Einheitenbefehle angezeigt wenn eine Einheit ausgewählt ist und nicht auch die Schaltfläche für allgemeine Optionen.
   -- Contracts, Kommentare und Kleinigkeiten korrigiert/angepasst/überarbeitet.
   
   

   -- Version 0.06.5705 => 0.06.5760 (24.09.2026):
   
   -- Die Berechnung der Texturenfelder größtenteils umgeschrieben.
   -- Texturen größtenteils an die neue Berechnung der einzelnen Texturenfelder angepasst.
   -- Fehler korrigiert der bei der Einstellung der Kartenform zu Programmstopps führte.
   -- Die Karte wird bei einem Programmstopp jetzt nicht mehr gespeichert, wenn noch keine Runde läuft.
   -- Kommentare und Kleinigkeiten korrigiert/angepasst.
   
   

   -- Version 0.06.5650 => 0.06.5705 (23.09.2026):
   
   -- Weiter an den neuen Rohstoffgeneratoren gearbeitet.
   -- Angefangen die Berechnung der Texturenfelder umzuschreiben, so dass ich dort keine Konstanten mehr sondern Bruchteile der Gesamtmenge nutze.
   -- Basisgrundtexturen an die neue Texturenfelderberechnung angepasst.
   -- Unnützen Code gelöscht.
   -- Kommentare und Kleinigkeiten korrigiert/angepasst.
   
   

   -- Version 0.06.5600 => 0.06.5650 (22.09.2026):
   
   -- Weiter an den neuen Rohstoffgeneratoren gearbeitet.
   -- Verbliebene Variablen im Ladezeitensystem nach private geschoben und Schreibefunktionen entsprechend erweitert.
   -- Interne Benennung ud Ordnerstruktur überarbeitet.
   -- Contracts, Kommentare und Kleinigkeiten korrigiert/angepasst/überarbeitet.
   
   

   -- Version 0.06.5520 => 0.06.5600 (21.09.2026):
   
   -- Das Einlesen der Texte neu aufgeteilt und erweitert.
   -- Rohstoffnamen in eine eigene Datei gepackt.
   -- Angefangen die Rohstofftexte zu erweitern.
   -- Weiter an den neuen Rohstoffgeneratoren gearbeitet.
   -- Speichersystem an das neue Rohstoffsystem angepasst.
   -- Basis- und Zusatzgrund und Flüsse werden jetzt rudimentär beim Generieren von Rohstoffen berücksichtigt.
   -- Kommentare und Kleinigkeiten korrigiert/angepasst/überarbeitet/erweitert.
   
   

   -- Version 0.06.5445 => 0.06.5520 (20.09.2026):
   
   -- Umwandlungssystem testweise um Records erweitert, aktuell nur KartenfeldVorhanden nach KartenfeldNatural.
   -- Weiter an den neuen Rohstoffgeneratoren gearbeitet.
   -- Anpassungen an der Reihenfolge des Basisgrundes vorgenommen.
   -- Texte und Texturen an die neuen Reihenfolge des Basisgrundes angepasst.
   -- Interne Benennung überarbeitet.
   -- Contracts, Kommentare und Kleinigkeiten korrigiert/angepasst/überarbeitet/erweitert.
   
   

   -- Version 0.06.5385 => 0.06.5445 (19.09.2026):
   
   -- Spielstandsystem an das neue Rohstoffsystem angepasst.
   -- Rohstoffeinstellungen vorübergehend deaktiviert.
   -- Angefangen die Textanzeige der Rohstoffe an das neue System anzupassen.
   -- Angefangen den Rohstoffgeneratoren neu zu schreiben.
   -- Contracts, Kommentare und Kleinigkeiten korrigiert/angepasst.
   
   

   -- Version 0.06.5325 => 0.06.5385 (18.09.2026):
   
   -- Die Lade/Speicheranzeige an die neuen Ebeneneinstellungen angepasst.
   -- Angefangen den Kartengenerator an das neue Rohstoffsystem anzupassen.
   -- Rohstoffe sollten jetzt auch an den Polen generiert werden.
   -- Contracst, Kommentare und Kleinigkeiten korrigiert/angepasst.
   -- Neue Version veröffentlicht.
   
   

   -- Version 0.06.5290 => 0.06.5325 (17.09.2026):
   
   -- GNAT 14.4.0 auf GNAT 16.2.0 aktualisiert.
   -- Unifont 17.0.05 auf Unifont 18.0.01 aktualisiert.
   -- Kleinigkeiten korrigiert.
   
   

   -- Version 0.06.5205 => 0.06.5290 (16.09.2026):
   
   -- KartengeneratorVariablenLogik mit Lese/Schreibefunktionen/prozeduren versehen.
   -- Übergangslösung für die Kreierung der Unterfläche eingebaut.
   -- Änderung am Spielstandsystem vorgenommen, der Planetenkern wird jetzt wieder mit gespeichert damit ich später die Möglichkeit habe verschiedene Kerne zu generieren.
   -- Fehler korrigiert der dazu führte das eine Unterfläche generiert wurde auch wenn diese deaktiviert ist.
   -- Angefangen das neue Rohstoff- und Verbesserungensystem zu schreiben und zu integrieren.
   -- Interne Benennung überarbeitet.
   -- Contracts, Komentare und Kleinigkeiten korrigiert/angepasst/überarbeitet/erweitert.
   
   

   -- Version 0.06.5170 => 0.06.5205 (15.09.2026):
   
   -- README um einen Hinweis dass ich keine KI verwende erweitert und mein KeineKI Logo hinzugefügt.
   -- Angefangen KartengeneratorVariablenLogik mit Lese/Schreibefunktionen/prozeduren zu versehen und auf protected zu setzen.
   -- Kommentare und Kleinigkeiten korrigiert/angepasst.
   
   

   -- Version 0.06.5045 => 0.06.5170 (14.09.2026):
   
   -- Angefangen das Rohstoffekonzept tiefgreifend zu ändern und neu zu bauen.
   -- Interne Benennung überarbeitet.
   -- Angefangen die Rohstoffe pro Feld auf vier zu erhöhen.
   -- Fehler korrigiert der zu einem Programmstopp führen konnte wenn man eine Zufällige Anzahl an Ebenen ausgewählt hat.
   -- Fehler korrigiert der es ermöglichte Spezien auszuwählen die auf nicht vorhandenen Ebenen starten.
   -- Fehler korrigiert der bei der Zufallsauswahl Spezien auswählte die auf nicht vorhandenen Ebenen starten.
   -- Zusatzprüfung eingebaut die sicherstellen sollte das ein Spiel nur noch mit Spezien startet, für die die nötigen Ebenen vorhanden sind.
   -- Vorübergehend die Generierung der Unterfläche deaktiviert wenn es keine Oberfläche gibt, das führt zu Programmstopps.
   -- Spezies die nicht ausgewählt werden können, werden jetzt auch nicht mehr im Speziesauswahlmenü angezeigt.
   -- SpieleinstellungenKartenLogik in mehrere Dateien aufgeteilt um mehr Übersichtlichekit und Lesbarkeit zu haben.
   -- Contracts, Kommentare und Kleinigkeiten korrigiert/angepasst/überarbeitet/erweitert.
   
   

   -- Version 0.06.4975 => 0.06.5045 (13.09.2026):
   
   -- Karteneinstellungen umsortiert.
   -- Alten Code entfernt der keinen nutzen mehr hatte aber noch Probleme verursachte.
   -- Interne Benennung überarbeitet.
   -- Vereinfachte Varianten des Kartenkoordinatenberechnungssystems eingebaut.
   -- Fehler korrigiert der bei bestimmten Karteneinstellungen dazu führte dass die Stadtnamen nicht angezeigt wurden.
   -- Contracts, Kommentare und Kleinigkeiten korrigiert/angepasst.
   
   

   -- Version 0.06.4920 => 0.06.4975 (12.09.2026):
   
   -- Kartenrohstoffe, Kartenflüsse und Karteneffekte jeweils in eigene Dateien aufgeteilt.
   -- Kartenbasis- und Kartenzusatzgrund jeweils in eigene Dateien aufgeteilt.
   -- Kartenverbesserungen und Kartenwege in eigene Dateien aufgeteilt.
   -- Angefangen die Rohstoffeliste neu zu schreiben und deutlich zu erweitern.
   -- Kommentare und Kleinigkeiten korrigiert/überarbeitet.
   
   

   -- Version 0.06.4840 => 0.06.4920 (11.09.2026):
   
   -- GeheZu an die neuen Ebeneneinstellungen angepasst.
   -- Kartengenerator an die neuen Ebeneneinstellungen angepasst.
   -- Funktion zum ermitteln der vorhandenen Kartenebenen eingebaut.
   -- Kartenpositionsberechnungen an die neuen Ebeneneinstellungen angepasst.
   -- Alles? an die neuen Ebeneneinstellungen angepasst.
   -- Contracts, Kommentare und Kleinigkeiten korrigiert/angepasst/überarbeitet.
   -- Neue Version veröffentlicht.
   
   

   -- Version 0.06.4790 => 0.06.4840 (10.09.2026):
   
   -- Funktion eingebaut um einzelne Wörter oder Textbereiche aus einer Zeile herauszusuchen.
   -- Funktion zum Einstellen der Ebenen fertig gestellt.
   -- Angefangen alles an die neue Ebeneneinstellung anzupassen.
   -- Contracts, Kommentare und Kleinigkeiten korrigiert/überarbeitet.
   
   

   -- Version 0.06.4745 => 0.06.4790 (09.09.2026):
   
   -- Kartengröße testweiße auf 1.100x1.100 erhöht und eine neue Kartengrößeauswahlmöglichkeit eingebaut.
   -- Zufallsgenerator für die Kartenebenen eingebaut.
   -- Weiter am neuen Ebenensystem gebaut.
   -- Contracts, Kommentare und Kleinigkeiten korrigiert.
   
   

   -- Version 0.06.4710 => 0.06.4745 (08.09.2026):
   
   -- Englische Übersetzung an die letzten Änderungen angepasst.
   -- Interne Benennung angepasst.
   -- Kleinigkeiten korrigiert/angepasst.
   
   

   -- Version 0.06.4660 => 0.06.4710 (07.09.2026):
   
   -- Zeicheneingabesystem überarbeitet.
   -- Es ist jetzt möglich Rohstoffe Überall oder Nirgends erscheinen zu lassen.
   -- Angefangen ein System einzubauen um die vorhandenen Ebenen einstellen zu können.
   -- Contacts, Kommentare und Kleinigkeiten korrigiert/überarbeitet.
   
   

   -- Version 0.06.4625 => 0.06.4660 (06.09.2026):
   
   -- Spieleentwicklungsbibliothek auf Version 0.01.2450 aktualisiert.
   -- Packen.sh überarbeitet.
   -- Kleinigkeiten korrigiert.
   
   

   -- Version 0.06.4590 => 0.06.4625 (05.09.2026):
   
   -- Funktion eingebaut mit der man sein Dezimaltrennzeichen selbst bestimmen kann.
   -- Funktion eingebaut mit der man nur ein einzelnes, beliebiges Zeichen eingeben kann.
   -- Contracts, Kommentare und Kleinigkeiten korrigiert.
   
   

   -- Version 0.06.4520 => 0.06.4590 (04.09.2026):
   
   -- Weiter mit der A/C/SFML 3.0 herumgebastelt.
   -- gpr Dateien überarbeitet damit sie übersichtlicher und besser an verschiedene A/C/SFML Versionen angepasst sind.
   -- Benennung und Ordnerstruktur angepasst um eine bessere Unterscheidung zwischen den SFML Versionen zu haben.
   -- Versionsnummer um die SFML Version erweitert.
   -- Contracts und Kleinigkeiten korrigiert/überarbeitet/angepasst.
   -- Neue Version veröffentlicht.
   
   

   -- Version 0.06.4495 => 0.06.4520 (03.09.2026):
   
   -- Angefangen eine Version für die A/C/SFML 3.0 einzubauen.
   -- Kleinigkeiten korrigiert.
   
   

   -- Version 0.06.4470 => 0.06.4495 (02.09.2026):
   
   -- GNAT 14.4.0-1 auf Version 14.4.0-2 aktualisiert.
   -- Kleinigkeiten korrigiert.
   
   

   -- Version 0.06.4410 => 0.06.4470 (01.09.2026):
   
   -- Das neue Ladezeitanzeigesysteme fertiggestellt.
   -- Interne Benennung überarbeitet.
   -- Code zusammengefasst.
   -- Angefangen eine Einstellungsmöglichkeit für das Dezimaltrennsymbol einzubauen.
   -- Contracts, Kommentare und Kleinigkeiten korrigiert/überarbeitet.

end ChangelogSeptember2026;

package ChangelogSeptember2026 is
   pragma Pure;

   -- Version 0.06. => 0.06. (30.09.2026):
   
   -- 
   -- Kleinigkeiten korrigiert.
   
   

   -- Version 0.06. => 0.06. (29.09.2026):
   
   -- 
   -- Kleinigkeiten korrigiert.
   
   

   -- Version 0.06. => 0.06. (28.09.2026):
   
   -- 
   -- Kleinigkeiten korrigiert.
   
   

   -- Version 0.06. => 0.06. (27.09.2026):
   
   -- 
   -- Kleinigkeiten korrigiert.
   
   

   -- Version 0.06. => 0.06. (26.09.2026):
   
   -- 
   -- Kleinigkeiten korrigiert.
   
   

   -- Version 0.06. => 0.06. (25.09.2026):
   
   -- 
   -- Kleinigkeiten korrigiert.
   
   

   -- Version 0.06. => 0.06. (24.09.2026):
   
   -- 
   -- Kleinigkeiten korrigiert.
   
   

   -- Version 0.06. => 0.06. (23.09.2026):
   
   -- 
   -- Kleinigkeiten korrigiert.
   
   

   -- Version 0.06. => 0.06. (22.09.2026):
   
   -- 
   -- Kleinigkeiten korrigiert.
   
   

   -- Version 0.06. => 0.06. (21.09.2026):
   
   -- 
   -- Kleinigkeiten korrigiert.
   
   

   -- Version 0.06. => 0.06. (20.09.2026):
   
   -- 
   -- Kleinigkeiten korrigiert.
   
   

   -- Version 0.06.5385 => 0.06. (19.09.2026):
   
   -- 
   -- Kleinigkeiten korrigiert.
   
   

   -- Version 0.06.5325 => 0.06.5385 (18.09.2026):
   
   -- Die Lade/Speicheranzeige an die neuen Ebeneneinstellungen angepasst.
   -- Angefangen den Kartengenerator an das neue Rohstoffsystem anzupassen.
   -- Rohstoffe sollten jetzt auch an den Polen generiert werden.
   -- Neue Version veröffentlicht.
   -- Contracst, Kommentare und Kleinigkeiten korrigiert/angepasst.
   
   

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
   -- Neue Version veröffentlicht.
   -- Contracts, Kommentare und Kleinigkeiten korrigiert/angepasst/überarbeitet.
   
   

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
   -- Neue Version veröffentlicht.
   -- Contracts und Kleinigkeiten korrigiert/überarbeitet/angepasst.
   
   

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

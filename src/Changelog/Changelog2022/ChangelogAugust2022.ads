package ChangelogAugust2022 is

   -- Version 0.03.7800 => 0.03.7935 (31.08.2022):
   
   -- Fehler behoben der bei Ladebildschirmen zu fehlerhafter Skalierung führte.
   -- Speziesspezifische Standardstadtnamen werden jetzt beim Bauen einer Stadt vorgeschlagen.
   -- Einige Spielmeldungen eingebaut.
   -- Unnötigen Code gelöscht.
   -- Durchsichtige Hintergründe eingebaut.
   -- Hintergründe und Textpositionierung überarbeitet.
   -- Neue Beispielbilder erstellt.
   -- Schriftgröße für bessere Skalierung angepasst.
   -- Speicherverbrauch und Spielstandgröße deutlich reduziert.
   -- Felderwertung angefangen zu überarbeiten.
   -- Contracts, Kommentare und Kleinigkeiten korrigiert/überarbeitet/angepasst/optimiert.
   
   

   -- Version 0.03.7745 => 0.03.7800 (30.08.2022):
   
   -- Neues Beispielbild erstellt.
   -- Einige Verbrauchstests durchgeführt.
   -- Interne Struktur überarbeitet.
   -- Meldesystem als SFML- un Viewversion eingebaut.
   -- Contracts, Kommentare und Kleinigkeiten korrigiert.
   
   

   -- Version 0.03.7600 => 0.03.7745 (29.08.2022):
   
   -- EinheitSuchen so geändert dass die Verschachtelung von Transportern jetzt berücksichtigt wird.
   -- Man kann jetzt auch durch das Oberflächenwasser leicht den Meeresgrund erkennen.
   -- Optimierungen vorgenommen.
   -- Angefangen die Standardbibliothek nicht mehr mit use zu nutzen.
   -- Interne Struktur überarbeitet.
   -- Änderungen an den Spieltexten vorgenommen.
   -- Textdateien neu aufgeteilt
   -- Das Texteinlesesystem an die neue Textdateienaufteilung anzupassen.
   -- Jede Spezies hat jetzt ihre eigenen Textdateien für NameBeschreibung, Städtenamen, Forschungen, Einheiten und Gebäude.
   -- Alle Textaccesse an das neue Speziestextsystem angepasst.
   -- Unnötigen/Veralteten Code gelöscht.
   -- Code zusammengeführt.
   -- Contracts, Kommentare und Kleinigkeiten korrigiert/überarbeitet/angepasst/optimiert.
   
   

   -- Version 0.03.7510 => 0.03.7600 (28.08.2022):
   
   -- Städte im Himmel/Orbit legen beim Bau jetzt keine Straße mehr an und von der Stadt angelegte Straßen werden jetzt korrekt mit regulären Straßen verbunden.
   -- Alle Verzeichnissnamen in konstante Strings ausgelagert.
   -- Das Platzieren und Entfernen von Arbeitern auf Stadtfeldern an das neue Viewsystem angepasst.
   -- Unnötigen Code gelöscht.
   -- Der Himmelsgrund ist jetzt leicht durchsichtig und ermöglicht es einem die Umgebung darunter zu erkennen.
   -- Interne Struktur überarbeitet.
   -- Neues Beispielbild erstellt.
   -- Contracts, Kommentare und Kleinigkeiten korrigiert/überarbeitet.
   
   

   -- Version 0.03.7400 => 0.03.7510 (27.08.2022):
   
   -- Fontdatei gegen eine andere Version ausgetauscht und entsprechende Lizensierung hinzugefügt.
   -- gpr Datei für dynamische Linkung hinzugefügt.
   -- Einige Beispielbilder hinzugefügt und ein wenig Werbung gemacht.
   -- Mauszeigerpositionierung und Kartenberechnungen überarbeitet.
   -- Berechnung der aktuellen Zeigerposition optimiert.
   -- Es wird jetzt auf der Weltkarte an den Rändern kein schwarzer Rahmen mehr angezeigt.
   -- Stadtfenster in Viewsystem eingebaut.
   -- Fehler behoben der dafür sorgte dass die Bildplatzierung nicht auf den eigenen Starteinheiten war.
   -- Angefangen die Verzeichnisnamen in konstante Strings auszulagern.
   -- Contracts, Kommentare und Kleinigkeiten korrigiert/überarbeitet/angepasst.
   
   

   -- Version 0.03.7200 => 0.03.7400 (26.08.2022):
   
   -- Einheitenlisten überarbeitet.
   -- Das Diplomatiemenü als SFML Version eingebaut.
   -- Eigene Datentypen für das Diplomatiesystem angelegt und entsprechend angepasst.
   -- Unnötigen Code gelöscht.
   -- Interne Struktur überarbeitet.
   -- Menüsysteme leicht überarbeitet.
   -- Versehentlich die Performance optimiert.
   -- Das alte Diplomatiesystem wieder eingebaut und modernisiert.
   -- Das alte Handelssystem wieder eingebaut, aktuell funktioniert nur Karten tauschen.
   -- Es ist jetzt vom Start an möglich den diplomatischen Zustand zu ändern.
   -- Contracts, Kommentare und Kleinigkeiten korrigiert/überarbeitet/angepasst/optimiert.
   
   

   -- Version 0.03.7000 => 0.03.7200 (25.08.2022):
   
   -- Das Steuerungsmenü in das neue Viewsystem eingebaut.
   -- Tastenbelegung ist jetzt wieder frei wählbar.
   -- Menüsystem überarbeitet, Maustaste rechts ist jetzt (fast) immer zurück.
   -- Neue Grafiken erstellt.
   -- Alles Menüs basieren jetzt auf Views und skalieren halbwegs brauchbar.
   -- Neue Hügel- und Gebirgegrafiken erstellt.
   -- Doppelten Code zusammengefasst.
   -- Unnötigen Code gelöscht.
   -- Teile der zu Überarbeitenliste angefangen abzuarbeiten.
   -- Kartenpoldicke kann jetzt zufällig bestimmt werden.
   -- Fehler im Kartengenerator behoben, welcher dafür sorgte das bei kleinen Kartengrößen fast kein Land gesetzt wurde.
   -- Contracts, Kommentare und Kleinigkeiten korrigiert/überarbeitet/angepasst/optimiert.
   
   

   -- Version 0.03.1785 => 0.03.7000 (24.08.2022):
   
   -- Versionsnummerberechnung erneut angepasst.
   -- Angefangen das Steuerungsmenü in das neue Viewsystem einzubauen.
   -- Unnötigen Code gelöscht.
   -- Terminalcode vollständig entfernt.
   -- Code zusammengefasst.
   -- GeheZu wieder eingebaut.
   -- Interne Struktur überarbeitet.
   -- Möglichkeit zur Doppelbelegung entfernt.
   -- Contracts, Kommentare und Kleinigkeiten korrigiert/überarbeitet/angepasst/optimiert.
   
   

   -- Version 0.03.1680 => 0.03.1785 (23.08.2022):
   
   -- Debian GNAT 12.1.0-8 auf Debian GNAT 12.2.0-1 aktualisiert.
   -- Fehler im Menüsystem korrigiert, welche dafür sorgten dass man inkorrekterweise im Hauptmenü landete.
   -- Unnötige Code gelöscht.
   -- Code zusammengefasst.
   -- Speziesmenü in das neue Viewsystem eingebaut.
   -- Einige Programmteile optimiert.
   -- Kartenformmenü in das neue Viewsystem eingebaut.
   -- Ladezeitenanzeige in das neue Viewsystem eingebaut.
   -- Fehler behoben der die Zahleneingabe mit dem NumPad verhinderte.
   -- Contracts, Kommentare und Kleinigkeiten korrigiert/überarbeitet/angepasst/verbessert/erweitert.
   
   

   -- Version 0.03.1595 => 0.03.1680 (22.08.2022):
   
   -- Fehler im Viewsystem behoben der zu fehlerhaften Anzeigen und Skalierungen führte.
   -- Weiter am neuen Menüsystem gebaut.
   -- Text-, Zahlen- und JaNeineingabe überarbeitet.
   -- Karten- und Seitenleistenskalierung erfolgt jetzt durch die Viewskalierung.
   -- Unnötigen Code gelöscht.
   -- Weltkartenseitenleiste in verschiedene Views aufgeteilt.
   -- Verschiedene Fehler in den Seitenleisten- und Eingabenviews korrigiert.
   -- Contracts, Kommentare und Kleinigkeiten korrigiert/überarbeitet/angepasst/erweitert.
   
   

   -- Version 0.03.1580 => 0.03.1595 (21.08.2022):
   
   -- Weiter am neuen Menüsystem gebaut.
   -- Kommentare und Kleinigkeiten korrigiert.
   
   

   -- Version 0.03.1540 => 0.03.1580 (20.08.2022):
   
   -- Text- und Zahleneingabe in das Viewsystem eingebaut.
   -- Einheit/Transporter/Stadtauswahl in das Viewsystem eingebaut.
   -- Einige fehlerhafte Darstellungen aufgrund des neuen Viewsystems korrigiert.
   -- Kommentare und Kleinigkeiten korrigiert/überarbeitet/angepasst.
   
   

   -- Version 0.03.1455 => 0.03.1540 (19.08.2022):
   
   -- Baumenü in das Viewsystem eingebaut.
   -- Forschungsmenü überarbeitet.
   -- Neues Baumenü fertiggestellt.
   -- Code zusammengefasst.
   -- Unnötigen Code gelöscht.
   -- Fehler behoben der verhinderte das unterirdische Einheiten sich auf Gestein bewegen konnten.
   -- Interne Strukturen überarbeitet.
   -- Contracts, Kommentare und Kleinigkeiten korrigiert/angepasst/überarbeitet/entfernt.
   
   

   -- Version 0.03.1380 => 0.03.1455 (18.08.2022):
   
   -- Externe Verzeichnisstruktur überarbeitet.
   -- Sprachauswahl überarbeitet und an neues Viewsystem angepasst.
   -- Es ist jetzt wieder möglich mit dem Mausrad durch die Ebenen zu scrollen.
   -- Viewsystem generell überarbeitet.
   -- Forschungsmenü in das Viewsystem eingebaut.
   -- Neues Forschungsmenü fertiggestellt.
   -- Contracts, Kommentare und Kleinigkeiten korrigiert/angepasst/überarbeitet/optimiert.
   
   

   -- Version 0.03.1315 => 0.03.1380 (17.08.2022):
   
   -- Erfolgreich statische Versionen der C/SFML kompiliert und eingebunden.
   -- Verbessertes Menüsystem funktioniert jetzt korrekt.
   -- Anzeige des verbesserten Menüsystem funktioniert jetzt in den Standardmenüs fehlerfrei.
   -- Zusatzanzeige der kartengröße funktioniert jetzt fehlerfrei.
   -- Fehler behoben der zur Anzeige eines falschen Hintergrunds führte.
   -- Sehr Unnötigen Code gelöscht.
   -- Kommentare und Kleinigkeiten korrigiert/angepasst.
   
   

   -- Version 0.03.1300 => 0.03.1315 (16.08.2022):
   
   -- Einen weiteren Tag damit verbracht statische Versionen der C/SFML zu kompilieren und einzubinden.
   -- Kleinigkeiten korrigiert.
   
   

   -- Version 0.03.1285 => 0.03.1300 (15.08.2022):
   
   -- Versucht das Spiel mit statische C/SFML Versionen zum Kompilieren zu bringen.
   -- Kleinigkeiten korrigiert.
   
   

   -- Version 0.03.1260 => 0.03.1285 (14.08.2022):
   
   -- Textaccesse und Positionspeicherung vereinfacht.
   -- Menüsystem kaputt gemacht.
   -- Kommentare und Kleinigkeiten korrigiert/angepasst.
   
   

   -- Version 0.03.1260 => 0.03.1260 (13.08.2022):
   
   -- null.
   
   

   -- Version 0.03.1245 => 0.03.1260 (12.08.2022):
   
   -- Weiter am neuen Viewanzeigesystem gearbeitet.
   -- Kommentare und Kleinigkeiten korrigiert.
   
   

   -- Version 0.03.1220 => 0.03.1245 (11.08.2022):
   
   -- Angefangen Zahleneingabe auf View umzubauen.
   -- Fehler korrigiert der bei niedrigen Auflösung dafür sorgte dass die Auswahlpositionen nicht mit den Textpositionen übereinstimmten.
   -- Kommentare und Kleinigkeiten korrigiert/angepasst.
   
   

   -- Version 0.03.1140 => 0.03.1220 (10.08.2022):
   
   -- Weiter an der Textskalierung in den Menüs gearbeitet.
   -- Debian GNAT auf Version 12.1.0-8 aktualisiert.
   -- ASFML aktualisiert.
   -- Einige Tests hinsichtlich der Aufteilung von Kartenfeldern wie Flussfelder und dem sich daraus ergebenden zusätzlichen Speicherverbrauch.
   -- Weltraum-, Wolken- und Hügeltexturen überarbeitet.
   -- Cheateinheiten können jetzt nur noch gebaut werden wenn Cheats aktiv sind.
   -- Zoomfunktion eingebaut.
   -- Kommentare und Kleinigkeiten korrigiert/angepasst/überarbeitet.
   
   

   -- Version 0.03.1090 => 0.03.1140 (09.08.2022):
   
   -- ASFML auf Version 2.5.3 aktualisiert.
   -- Weiter an der Textskalierung in den Menüs gearbeitet.
   -- An der Anzeige der Karte herumgebastelt.
   -- Fehlerhafte Textkoordinaten näher geprüft.
   -- Kommentare und Kleinigkeiten korrigiert/überarbeitet/angepasst.
   
   

   -- Version 0.03.1045 => 0.03.1090 (08.08.2022):
   
   -- ASFML auf Version eca5fc779c6656b91279c730e27c684aa5b3838e aktualisiert.
   -- Code übersichtlicher aufgeteilt.
   -- Eingabesystem überarbeitet.
   -- Weiter an der Textskalierung in den Menüs gearbeitet.
   -- Kommentare und Kleinigkeiten korrigiert/überarbeitet.
   
   

   -- Version 0.03.1030 => 0.03.1045 (07.08.2022):
   
   -- Weiter an der Textskalierung in den Menüs gearbeitet.
   -- Kommentare und Kleinigkeiten korrigiert.
   
   

   -- Version 0.03.1010 => 0.03.1030 (06.08.2022):
   
   -- Angefangen Textskalierung, durch Views, in den Menüs einzubauen.
   -- Contracts, Kommentare und Kleinigkeiten korrigiert/angepasst.
   
   

   -- Version 0.03.0985 => 0.03.1010 (05.08.2022):
   
   -- Neue Seitenleistenskalierung auch in die Stadtkarte eingebaut.
   -- Angefangen eine SFML Version der Spielmeldungsanzeige einzubauen.
   -- Kommentare und Kleinigkeiten korrigiert/angepasst.
   
   

   -- Version 0.03.0870 => 0.03.0985 (04.08.2022):
   
   -- Änderungen rückgängig gemacht.
   -- Mehr Warnungen eingebaut.
   -- Unnötigen Code gelöscht.
   -- Code zusammengefasst.
   -- Weiter an der Textanzeige/skalierung gearbeitet.
   -- Seitenleistenskalierung auf der Weltkare sollte jetzt immer die richtige Höhe haben.
   -- Fehler behoben der Verhinderte das ein Schiff sich in eine Stadt bewegen konnte.
   -- Es ist jetzt möglich kleine Transporter in größere Transporter zu laden.
   -- Halbwegs brauchbare Lösung für die Darstellung und Skalierung der Seitenleiste auf der Weltkarte eingebaut.
   -- Warn- und Fehlermeldungen gekürzt.
   -- Contracts, Kommentare und Kleinigkeiten korrigiert/überarbeitet/angepasst/modifiziert.
   
   

   -- Version 0.03.0850 => 0.03.0870 (03.08.2022):
   
   -- Weiter an der Textanzeige/skalierung durch Views gearbeitet.
   -- Contracts, Kommentare und Kleinigkeiten korrigiert/überarbeitet.
   
   

   -- Version 0.03.0850 => 0.03.0850 (02.08.2022):
   
   -- null.
   
   

   -- Version 0.03.0850 => 0.03.0850 (01.08.2022):
   
   -- null.

end ChangelogAugust2022;

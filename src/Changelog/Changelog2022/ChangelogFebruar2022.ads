package ChangelogFebruar2022 is

   -- Version 0.01.0050 => 0.01.0050 (28.02.2022):
   
   -- null.
   
   

   -- Version 0.01.0050 => 0.01.0050 (27.02.2022):
   
   -- null.
   
   

   -- Version 0.01.0045 => 0.01.0050 (26.02.2022):
   
   -- Kartenkonstanten vollständig aufgeteilt, angelegt und angefangen sie entsprechend einzubauen.
   -- Kommentare und Kleinigkeiten korrigiert.
   
   

   -- Version 0.01.0040 => 0.01.0045 (25.02.2022):
   
   -- Konstanten für Kartengrund und Kartenverbesserung angelegt und angefangen einzubauen.
   -- Kommentare, Contracts und Kleinigkeiten korrigiert/angepasst.
   
   

   -- Version 0.01.0040 => 0.01.0040 (24.02.2022):
   
   -- null.
   
   

   -- Version 0.01.0040 => 0.01.0040 (23.02.2022):
   
   -- null.
   
   

   -- Version 0.01.0030 => 0.01.0040 (22.02.2022):
   
   -- Von Debian GNAT 11.2 auf Debian GNAT 12-20220222-1 gewechselt.
   -- Warnmeldungen wegen dem Verwenden von () anstelle von [] in Arrays vorübergehend deaktiviert.
   -- Einlesen der Texturen überarbeitet und für Hintergründe, Einheiten und Gebäude eingebaut.
   -- Angefangen bessere Texturen für Verbesserungen, Einheiten, Hintergründe und Gebäude zu erstellen.
   -- Kommentare und Kleinigkeiten korrigiert/angepasst/überarbeitet.
   
   

   -- Version 0.01.0020 => 0.01.0030 (21.02.2022):
   
   -- Bessere Kartenfeldertexturen erstellt.
   -- Contracts, Kommentare und Kleinigkeiten korrigiert/hinzugefügt/angepasst.
   
   

   -- Version 0.01.0005 => 0.01.0020 (20.02.2022):
   
   -- Fehlermeldung- und Stoppsystem deutlich verbessert, vor allem beim Auftreten eines Standardfehlers von Ada.
   -- Diverse Fehlerprüfungen in die Contracts ausgelagert.
   -- Die Kartengrafiken werden jetzt immer und in der richtigen Größe dargestellt, auch wenn die Texturen in unterschiedlichen Größen vorliegen.
   -- Bessere Flussgrafiken erstellt.
   -- Contracts, Kommentare und Kleinigkeiten korrigiert/überarbeitet.
   
   

   -- Version 0.01.0005 => 0.01.0005 (19.02.2022):
   
   -- null.
   
   

   -- Version 0.01.0000 => 0.01.0005 (18.02.2022):
   
   -- Codestruktur zur Anzeige der Stadtgrafik verbessert.
   -- An den Fehlermeldungen bei einem unerwarteten Programmstopp gearbeitet.
   -- Kleinigkeiten korrigiert.
   
   

   -- Version 0.01.0000 => 0.01.0000 (17.02.2022):
   
   -- null.
   
   

   -- Version 0.01.0000 => 0.01.0000 (16.02.2022):
   
   -- null.
   
   

   -- Version 0.00.9991 => 0.01.0000 (15.02.2022):
   
   -- Sämtliche Texturen in das Spiel eingebaut.
   -- Internet Struktur zur Berechnung und Anzeige von Texturen überarbeitet.
   -- Contracts, Kommentare und Kleinigkeiten korrigiert/angepasst/überarbeitet.
   
   

   -- Version 0.00.9990 => 0.00.9991 (14.02.2022):
   
   -- gprbuild von 2018-6 auf 2021.0.0.0778b109-5 aktualisiert.
   
   

   -- Version 0.00.9975 => 0.00.9990 (13.02.2022):
   
   -- Einige Vergleiche mit KartenDatentypen auf Vergleiche mit KartenKonstanten umgeschrieben.
   -- Die Überarbeitung der Benennungen bis auf Kleinigkeiten abgeschlossen.
   -- Testtexturen für Verbesserungen erstellt und eingebaut.
   -- Testtexturen für Einheiten und Gebäude erstellt und eingebaut.
   -- Weitere Warnmeldungen eingebaut.
   -- Contracts, Kommentare und Kleinigkeiten korrigiert/überarbeitet.
   
   

   -- Version 0.00.9970 => 0.00.9975 (12.02.2022):
   
   -- Verzeichnisserzeugung überarbeitet und an die neuen Texturverzeichnisse angepasst.
   -- Weiter die Benennungen überarbeitet.
   -- Kommentare und Kleinigkeiten korrigiert.
   
   

   -- Version 0.00.9960 => 0.00.9970 (11.02.2022):
   
   -- Testtexturen für die Ressourcen erstellt und eingebunden.
   -- Hüllen für das Einlesen, Speichern und Darstellen der restlichen Texturen angelegt.
   -- Angefangen bestimmte Benennungen zur Unterscheidung der aktuellen Koordinatenposition, der aktuellen Grafikposition und der aktuellen Arrayposition einzuführen.
   -- Contracts, Kommentare und Kleinigkeiten korrigiert/überarbeitet.
   
   

   -- Version 0.00.9940 => 0.00.9960 (10.02.2022):
   
   -- Einige fehlende Prüfungen auf eine gültige Kartenposition eingefügt.
   -- Fehler in den Post Conditions der Positionsberechnung korrigiert, der zu Stopps beim Generieren von Karten führte.
   -- Neue Textur für Flachland erstellt.
   -- Warnmeldungen für Fehler die fehlende Grafikdateien hinzugefügt, welche auf das Fehlen von nicht notwendigen Dateien hinweisen aber das Programm nicht stoppen.
   -- Einlesen von Kartenfeldertexturen erweitert, so dass alle vorhandenen Texturen eingelesen werden und die fehlenden ignoriert werden.
   -- Einlesen von Kartenfeldertexturen ermöglicht jetzt einfache, externe Modifikationen wie die Textdateien.
   -- Erste Texturen für alle vorhandenen Kartenfelder erstellt.
   -- Leerdateien für alle Ressourcen- und Sonstigekartenfelder angelegt.
   -- Contracts, Kommentare und Kleinigkeiten korrigiert/angepasst/überarbeitet.
   
   

   -- Version 0.00.9925 => 0.00.9940 (09.02.2022):
   
   -- Berechnungen der Kartenpositionen zu modifiziert dass eine ungültige EAchsenPosition nicht mehr zu einem gültigen Rückgabewert führt und umgekehrt.
   -- Kartenformen- und berechnungen in Normal und Abstrakt eingeteilt.
   -- Neue Kartenformen- und berechnungen eingebaut.
   -- Tugel, Tugel gedreht und Tugel extrem sollten jetzt 'korrekt' funktionieren.
   -- Angefangen ein universelleres Kartenformensystem einzubauen, was bei weniger Programmierarbeit mehr Einstellmöglichkeiten für den Spieler bieten sollte.
   -- Fehler in der Positionsberechnung gesucht und gefunden.
   -- Kommentare und Kleinigkeiten korrigiert/überarbeitet/angepasst.
   
   

   -- Version 0.00.9915 => 0.00.9925 (08.02.2022):
   
   -- Fehler in den Berechnungen der Kartenpositionen korrigiert, welcher durch die Trennung von Logik und Grafik entstanden ist.
   -- Einige Textateien umbenannt.
   -- Kommentare und Kleinigkeiten korrigiert/angepasst.
   
   

   -- Version 0.00.9910 => 0.00.9915 (07.02.2022):
   
   -- Fehler in der Berechnung der Texturengröße korrigiert.
   -- Fehler in der Berechnung der neuen Kartenposition gefunden und Lösung entwickelt.
   -- Kommentare und Kleinigkeiten korrigiert.
   
   

   -- Version 0.00.9895 => 0.00.9910 (06.02.2022):
   
   -- Einlesesystem für Texturen so geändert dass bei nicht vorhandenen Texturen das Programm nicht mehr stoppt, sonder später einfach nur einfarbige Felder anzeigt.
   -- Fehlersuche im Bewegungssystem der Einheiten.
   -- Fehler behoben der dazu führte das die Einheit direkt zwei Felder bewegt wurde anstatt nur eins.
   -- Fehler behoben der dazu führte das eine Einheit ohne Bewegungspunkte nicht gleich abgewählt wurde.
   -- Fehler im Berechnungssystem der neuen Kartenposition gefunden und über seine Lösung nachgedacht.
   -- Einfaches Berechnungssystem für die Größe von Kartenfeldertexturen, sowohl für die Weltkarte als auch für die Stadtkarte, eingebaut.
   -- Stadthintergrund lädt jetzt die Texture des Kartenfeldes auf dem die Stadt steht.
   -- Wenn die Texture nicht geladen werden konnte, dann wird weiterhin einfach nur ein einfarbiges Feld dargestellt.
   -- Kommentare und Kleinigkeiten korrigiert/angepasst/überarbeitet.
   
   

   -- Version 0.00.9890 => 0.00.9895 (05.02.2022):
   
   -- Angefangen ein System für die Anzeige von Kartenfeldertexturen einzubauen.
   -- Kleinigkeiten korrigiert.
   
   

   -- Version 0.00.9885 => 0.00.9890 (04.02.2022):
   
   -- Talbidahr/Tesorahn starten jetzt wieder korrekt Unterirdisch/Unterwasser.
   -- Es ist jetzt möglich in der SFML Version durch die Maussteuerung die Einheiten auf eine andere Ebene zu bewegen, wenn diese Ebene für die Einheit pasierbar ist.
   -- Hüllen für die Berechnung von Korruption und Zufriedenheit eingebaut.
   -- Angefangen die Bewegungs- und Positionsberechnungen alle um die EAchse zu erweitern.
   -- Bescheuerten Spielenamen eingebaut.
   -- Kommentare und Kleinigkeiten korrigiert/angepasst.
   
   

   -- Version 0.00.9885 => 0.00.9885 (03.02.2022):
   
   -- null.
   
   

   -- Version 0.00.9870 => 0.00.9885 (02.02.2022):
   
   -- Vorerst für alle stabileren Teile von SystemDatentypen auch MenueKonstanten angelegt.
   -- Grundgerüst für Stadtzufriedenheit eingebaut.
   -- Namensgebung verbessert.
   -- Contracts, Kommentare und Kleinigkeiten korrigiert/überarbeitet/verbessert.
   
   

   -- Version 0.00.9860 => 0.00.9870 (01.02.2022):
   
   -- Mehr Konstanten angelegt, eingebaut und dabei hoffentlich nichts kaputt gemacht.
   -- Musik- und Soundsystem verbessert.
   -- Interne Struktur leicht überarbeitet.
   -- Kommentare und Kleinigkeiten korrigiert/angepasst.

end ChangelogFebruar2022;

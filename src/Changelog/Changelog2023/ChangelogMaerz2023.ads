package ChangelogVorlage is
   
   -- Version 0.04.8790 => 0.04.8790 (31.03.2023):
   
   -- null.
   
   

   -- Version 0.04.8790 => 0.04.8790 (30.03.2023):
   
   -- null.
   
   

   -- Version 0.04.8790 => 0.04.8790 (29.03.2023):
   
   -- null.
   
   

   -- Version 0.04.8790 => 0.04.8790 (28.03.2023):
   
   -- null.
   
   

   -- Version 0.04.8790 => 0.04.8790 (27.03.2023):
   
   -- null.
   
   

   -- Version 0.04.8740 => 0.04.8790 (26.03.2023):
   
   -- Fehler korrigiert, welcher es ermöglichte Einheiten über beliebige Entfernungen in Transporter zu laden.
   -- Menschliche Bewegungsplanung in kleinere Teile aufgeteilt und überarbeitet.
   -- Fehler korrigiert, welcher untern Umständen zu einem Programmstopp führen konnte wenn man die Bewegung auf ein von einer anderen Spezies belegten Feld abbrach.
   -- Contracts, Kommentare und Kleinigkeiten korrigiert/angepasst.
   
   

   -- Version 0.04.8680 => 0.04.8740 (25.03.2023):
   
   -- Zusätzliche Spielmeldungen für das Verbessern von Einheiten hinzugefügt.
   -- Fehler korrigiert der bei Transporter nicht alle Laderäume durchging.
   -- Angefangen zusätzliche Nullprüfungen für Teiler einzubauen.
   -- Unnötigen Code gelöscht.
   -- Contracts, Komemntare und Kleinigkeiten korrigiert/angepasst.
   
   

   -- Version 0.04.8645 => 0.04.8680 (24.03.2023):
   
   -- Einheiten in Transporter können jetzt nicht mehr verbessert werden, wenn die verbesserte Variante zu groß für den Transporter ist.
   -- Transporter können jetzt nicht mehr verbessert werden, wenn die neue Ladekapazität kleiner ist als die aktuelle Ladungsmenge.
   -- Contracts, Kommentare und Kleinigkeiten korrigiert.
   
   

   -- Version 0.04.8645 => 0.04.8645 (23.03.2023):
   
   -- null.
   
   

   -- Version 0.04.8610 => 0.04.8645 (22.03.2023):
   
   -- Landflächenkartengenerator überarbeitet.
   -- Fehler korrigiert der dazu führte dass die Position der ausgewählten Einheit nicht immer auf den anderen Kartenebenen angezeigt wurde.
   -- Kommentare und Kleinigkeiten korrigiert.
   
   

   -- Version 0.04.8525 => 0.04.8610 (21.03.2023):
   
   -- Am Landflächenkartengenerator verzweifelt.
   -- LeseStadtGebaut soweit möglich an den Anfang des Grafiktasks geschoben und die Werte nur noch weitergegeben, um so Fehler bei Änderungen durch den Logiktask zu verhindern.
   -- Fehler korrigiert, der dazu führen konnte dass die Stadtnamenanzeige auf der Weltkarte sich nicht mehr an der Stadt befand.
   -- LeseEinheitGebaut soweit möglich an den Anfang des Grafiktasks geschoben und die Werte nur noch weitergegeben, um so Fehler bei Änderungen durch den Logiktask zu verhindern.
   -- Der Landflächenkartengenerator erzeugt jetzt Karten bei denen die Landmassen weniger rechteckig sind.
   -- Der Landflächenkartengenerator erzeugt jetzt deutlich hübschere Karten.
   -- Contracts, Kommentare und Kleinigkeiten korrigiert/angepasst/überarbeitet/erweitert.
   
   

   -- Version 0.04.8500 => 0.04.8525 (20.03.2023):
   
   -- Landflächenkartengenerator überarbeitet.
   -- Kommentare und Kleinigkeiten korrigiert.
   
   

   -- Version 0.04.8500 => 0.04.8500 (19.03.2023):
   
   -- null.
   
   

   -- Version 0.04.8465 => 0.04.8500 (18.03.2023):
   
   -- Landflächenkartengenerator überarbeitet.
   -- Zufallsgeneratoren angepasst.
   -- Contracts, Kommentare und Kleinigkeiten korrigiert.
   
   

   -- Version 0.04.8465 => 0.04.8465 (17.03.2023):
   
   -- null.
   
   

   -- Version 0.04.8465 => 0.04.8465 (16.03.2023):
   
   -- null.
   
   

   -- Version 0.04.8465 => 0.04.8465 (15.03.2023):
   
   -- null.
   
   

   -- Version 0.04.8415 => 0.04.8465 (14.03.2023):
   
   -- Mausauswahl bearbeitet.
   -- Diverse Zahlen in benannte Konstante geändert.
   -- Alle einzeiligen Lesefunktionen/Schreibeprozeduren mit 'pragma Inline' versehen.
   -- Contracts, Kommentare und Kleinigkeiten korrigiert/angepasst.
   
   

   -- Version 0.04.8415 => 0.04.8415 (13.03.2023):
   
   -- null.
   
   

   -- Version 0.04.8415 => 0.04.8415 (12.03.2023):
   
   -- null.
   
   

   -- Version 0.04.8415 => 0.04.8415 (11.03.2023):
   
   -- null.
   
   

   -- Version 0.04.8390 => 0.04.8415 (10.03.2023):
   
   -- Fehler korrigiert der bei zu kleiner Fenstergröße zu einem Programmstopp führen konnte.
   -- Kommentare und Kleinigkeiten korrigiert.
   
   

   -- Version 0.04.8390 => 0.04.8390 (09.03.2023):
   
   -- null.
   
   

   -- Version 0.04.8390 => 0.04.8390 (08.03.2023):
   
   -- null.
   
   

   -- Version 0.04.8310 => 0.04.8390 (07.03.2023):
   
   -- Die Grafik übergibt jetzt mehr Daten an die Unterbereiche anstelle sie an den entsprechenden Orten erst zu berechnen.
   -- Diverse Anpassungen vorgenommen dass die Datenübergabe überall funktioniert/verwendet werden kann.
   -- Code vereinfacht.
   -- Fehler korrigiert der dazu führen konnte dass das Fenster bei Änderungen nicht sofort neu skaliert wurde oder beim Schließen nicht sofort geschlossen wurde.
   -- Zugriff auf den falschen Access bei den Ladezeiten korrigiert.
   -- Diverse Mehrfachnutzung von Textaccesse entfernt.
   -- Contracts, Kommentare und Kleinigkeiten korrigiert/überarbeitet/angepasst.
   
   

   -- Version 0.04.8310 => 0.04.8310 (06.03.2023):
   
   -- null.
   
   

   -- Version 0.04.8250 => 0.04.8310 (05.03.2023):
   
   -- Testweite einige 'pragma Inline' eingebaut.
   -- Mehr relevante Berechnungen für die Grafik an den Grafikanfang verschoben.
   -- Die Grafik übergibt jetzt mehr Daten an die Unterbereiche anstelle sie an den entsprechenden Orten erst zu berechnen.
   -- Diverse Anpassungen vorgenommen dass die Datenübergabe überall funktioniert/verwendet werden kann.
   -- Contracts, Kommentare und Kleinigkeiten korrigiert/überarbeitet.
   
   

   -- Version 0.04.8250 => 0.04.8250 (04.03.2023):
   
   -- null.
   
   

   -- Version 0.04.8200 => 0.04.8250 (03.03.2023):
   
   -- Zugriffsdateien für die Toneinstellungen eingebaut.
   -- Toneinstellungen werden jetzt genau wie alle anderen Einstellungen geschrieben/eingelesen.
   -- Angefangen die Ermittlung von relevaten Einheiten/Stadtwerten am Anfang der Grafikberechnungen durchzuführen, damit spätere Änderungen durch den Logiktask weniger/keine Probleme erzeugen.
   -- Contracs, Kommentare und Kleinigkeiten korrigiert/angepasst/erweitert.
   
   

   -- Version 0.04.8190 => 0.04.8200 (02.03.2023):
   
   -- Neues Release erstellt.
   
   

   -- Version 0.04.8190 => 0.04.8190 (01.03.2023):
   
   -- null.

end ChangelogVorlage;

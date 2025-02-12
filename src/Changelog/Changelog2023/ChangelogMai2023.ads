package ChangelogMai2023 is
   pragma Pure;
   
   -- Version 0.05.1530 => 0.05.1555 (31.05.2023):
   
   -- Interne Struktur und Benennung überarbeitet.
   -- Kommentare und Kleinigkeiten korrigiert.
   
   

   -- Version 0.05.1465 => 0.05.1530 (30.05.2023):
   
   -- Weiter am neuen Kartenfelderproduktionssystem gearbeitet.
   -- Unnötigen Code gelöscht.
   -- Bonusberechnung für den Kampf überarbeitet.
   -- Das neue Kartenfeldproduktionssystem erst einmal auf alle Produktionsarten verallgemeinert.
   -- Angefangen Meldungen einzubauen, wenn das Schreiben von Dateien nicht erfolgreich verlief.
   -- Kommentare und Kleinigkeiten korrigiert/angepasst.
   
   

   -- Version 0.05.1430 => 0.05.1465 (29.05.2023):
   
   -- MeldungssystemHTSEB überarbeitet und um Zeitangabe erweitert.
   -- Exceptions überarbeitet, so dass die Grund für die Exceptions ebenfall gespeichert/angezeigt wird.
   -- Kleinigkeiten korrigiert/angepasst.
   
   

   -- Version 0.05.1355 => 0.05.1430 (28.05.2023):
   
   -- Weiter am neuen Kartenfelderproduktionssystem gearbeitet.
   -- Nahrungsproduktionsbonus durch Wege überarbeitet.
   -- Nahrungsproduktionsbonus durch Flüsse überarbeitet.
   -- EffekteDatenbank angelegt.
   -- Zusätzliche Exceptions und Fehlermeldungen hinzugefügt.
   -- Sollten Verzeichnisse und Dateien nicht oder nicht vollständig geschrieben werden können, dann wird der Schreibeprozess abgebrochen und nicht mehr das Spiel gestoppt.
   -- Kommentare und Kleinigkeiten korrigiert/erweitert.
   
   

   -- Version 0.05.1290 => 0.05.1355 (27.05.2023):
   
   -- Weiter am neuen Kartenfelderproduktionssystem gearbeitet.
   -- Unnötigen Code gelöscht.
   -- Nahrungsproduktionsbonus durch Ressourcen überarbeitet.
   -- Nahrungsproduktionsbonus durch Verbesserungen überarbeitet.
   -- Code besser aufgeteilt.
   -- Kommentare und Kleinigkeiten korrigiert/angepasst.
   
   

   -- Version 0.05.1290 => 0.05.1290 (26.05.2023):
   
   -- null.
   
   

   -- Version 0.05.1290 => 0.05.1290 (25.05.2023):
   
   -- null.
   
   

   -- Version 0.05.1255 => 0.05.1290 (24.05.2023):
   
   -- Discordserverlink hinzugefügt.
   -- Weiter am neuen Kartenfelderproduktionssystem gearbeitet.
   -- Kommetare und Kleinigkeiten korrigiert.
   
   

   -- Version 0.05.1215 => 0.05.1255 (23.05.2023):
   
   -- Soweit möglich überall TextArrays.AllgemeinesTextArray eingebaut.
   -- Angefangen die Festlegung der Kartenfelderproduktionswerte zu überarbeitet.
   -- Kommentare und Kleinigkeiten korrigiert/angepasst/überarbeitet.
   
   

   -- Version 0.05.1105 => 0.05.1215 (22.05.2023):
   
   -- Potentielle Fehler im Einheiten- und Stadtsortiersystem entfernt.
   -- Maximale Zoomstufe auf 15 erhöht und den Scrollbereich wieder erhöht.
   -- Dateien werden nach der Korrektheitsprüfung nicht mehr geschlossen und neu geöffnet, sondern der Index wird zurück auf eins gesetzt.
   -- Wenn des Spiel korrekt beenden wird, dann werden jetzt diverse Einstellungen (beispielsweise der aktuelle Autospeichernwert) geschrieben.
   -- Alles Schriftgrößen um 12 Punkte erhöht.
   -- Wenn bei neuem Spiel gar keine Spezies belegt wurde, dann wird jetzt automatisch eine Spezies für den Menschen und eine für die KI belegt.
   -- Schleifen berücksichtigen jetzt dass die Einheiten/Städte sortiert sind.
   -- KI Berechnungen deutlich beschleunigt.
   -- Textabstände und Positionen leicht angepasst um die Sichtbarkeit zu erhöhen.
   -- Kommentare und Kleinigkeiten korrigiert/angepasst/überarbeitet.
   
   

   -- Version 0.05.0960 => 0.05.1105 (21.05.2023):
   
   -- Weiter am neuen Speichersystem gearbeitet.
   -- Maximale Dateigröße der Speicherdateien auf unter 25 MB reduziert.
   -- Die Cursorinformationen werden jetzt nur noch bei menschlichen Spielern gespeichert.
   -- Weitere exceptions eingebaut.
   -- Den Arbeitsspeicherverbrauch um rund 70 MB reduziert.
   -- Städte werden jetzt sortiert, wenn eine Stadt entfernt wird.
   -- Es werden jetzt nur noch Städte gespeichert die auch existieren.
   -- Das Debugmenü kann in Veröffentlichungsversionen jetzt wieder aufgerufen werden.
   -- Globales TextArray angelegt.
   -- Einheiten werden jetzt sortiert, wenn eine Einheit entfernt wird.
   -- Es werden jetzt nur noch Einheiten gespeichert die auch existieren.
   -- Neues Speichersystem fertig gestellt.
   -- Contracts, Kommentare und Kleinigkeiten korrigiert/angepasst/überarbeitet/erweitert.
   
   

   -- Version 0.05.0915 => 0.05.0960 (20.05.2023):
   
   -- Weiter am neuen Speichersystem gearbeitet.
   -- Maximale Dateigröße der Speicherdateien auf unter 50 MB reduziert.
   -- Das Speichersystem sollte jetzt wieder fehlerfrei funktionieren.
   -- Contracts, Kommentare und Kleinigkeiten korrigiert.
   
   

   -- Version 0.05.0880 => 0.05.0915 (19.05.2023):
   
   -- Weiter am neuen Speichersystem gearbeitet.
   -- Angefangen bitweises Speichern einzubauen.
   -- Kleinigkeiten korrigiert/angepasst.
   
   

   -- Version 0.05.0805 => 0.05.0880 (18.05.2023):
   
   -- Fehlerhafte Textanzeige von Kartenfelder in allen Sprachen korrigiert.
   -- Weiter am neuen Speichersystem gearbeitet.
   -- Kartenspeicherung überarbeitet.
   -- Speichern und Laden sollte jetzt wieder fehlerfrei funktionieren.
   -- Diagnosesystem überarbeitet.
   -- Contracts, Kommentare und Kleinigkeiten korrigiert/erweitert/angepasst/entfernt.
   
   

   -- Version 0.05.0755 => 0.05.0805 (17.05.2023):
   
   -- Fehlerhafte Textanzeige von Kartenfelder korrigiert.
   -- Fehlerhafte Anzeige von Kartenfelder korrigiert.
   -- Weiter am neuen Speichersystem gearbeitet.
   -- Contracts, Kommentare und Kleinigkeiten korrigiert/angepasst.
   
   

   -- Version 0.05.0695 => 0.05.0755 (16.05.2023):
   
   -- Das Speichersystem überarbeitet.
   -- Dateigröße der Spielstanddateien reduziert.
   -- Angefangen das Ladesystem an die neue Version des Speichersystem angepasst.
   -- Das Spielstandsystem erfolgreich kaputt gemacht.
   -- Contracts, Kommentare und Kleinigkeiten korrigiert/angepasst.
   
   

   -- Version 0.05.0695 => 0.05.0695 (15.05.2023):
   
   -- null.
   
   

   -- Version 0.05.0680 => 0.05.0695 (14.05.2023):
   
   -- Kommentare und Kleinigkeiten korrigiert.
   
   

   -- Version 0.05.0630 => 0.05.0680 (13.05.2023):
   
   -- Es ist jetzt möglich nutzerdefinierte Fontdateien zu verwenden.
   -- Die nutzerdefinierte Fontdatei wird jetzt bereits bei der Sprachenauswahl verwendet.
   -- Interne Festlegung der Schriftart überarbeitet.
   -- Contracts, Kommentare und Kleinigkeiten korrigiert/erweitert.
   
   

   -- Version 0.05.0630 => 0.05.0630 (12.05.2023):
   
   -- null.
   
   

   -- Version 0.05.0620 => 0.05.0630 (11.05.2023):
   
   -- Weiter mit verschiedenen Fonts experimentiert.
   
   

   -- Version 0.05.0620 => 0.05.0620 (10.05.2023):
   
   -- null.
   
   

   -- Version 0.05.0570 => 0.05.0620 (09.05.2023):
   
   -- Betriebssystem- und Entwicklung/Veröffentlichungprüfungen in verschiedene Dateien ausgelagert.
   -- Das Debugmenü ist jetzt nicht mehr aufrufbar im Veröffentlichungsstatus.
   -- Debugmenü überarbeitet.
   -- Contracts, Kommentare und Kleinigkeiten korrigiert/angepasst.
   
   

   -- Version 0.05.0510 => 0.05.0570 (08.05.2023):
   
   -- Eingabe von Spielstandnamen überarbeitet, es sollte jetzt nicht mehr möglich sein ungültige Namen unter Windows einzugeben.
   -- Es sollte jetzt nicht mehr möglich sein ungültige Spielstandnamen unter Linux einzugeben.
   -- Neu gebaute Einheiten werden jetzt nur noch auf Felder platziert, welche zur bauenden Stadt gehören.
   -- Neu gebaute Schiffe werden jetzt nur noch in der Stadt platziert, wenn direkt ein Seefeld angrenzt.
   -- Contracts, Kommentare und Kleinigkeiten korrigiert/angepasst.
   
   

   -- Version 0.05.0510 => 0.05.0510 (07.05.2023):
   
   -- null.
   
   

   -- Version 0.05.0510 => 0.05.0510 (06.05.2023):
   
   -- null.
   
   

   -- Version 0.05.0430 => 0.05.0510 (05.05.2023):
   
   -- Anpassungen an den Speicherorten der Nutzereinstellungen vorgenommen.
   -- Namensprüfungen für Spielstände in einen Linux- und einen Windowsbereich aufgeteilt.
   -- Zusätzliche Prüfungen für Spielstandnamen eingebaut.
   -- Neue Font eingebaut um auch asiatische Schriftzeichen korrekt anzeigen zu können.
   -- Zusätzliche Prüfungen für die Sprachenordner eingebaut, damit es unter Windows zu keinen Problemen mehr kommt.
   -- Neue Version veröffentlicht.
   -- Contracs, Kommentare und Kleinigkeiten korrigiert/angepasst.
   
   

   -- Version 0.05.0430 => 0.05.0430 (04.05.2023):
   
   -- null.
   
   

   -- Version 0.05.0410 => 0.05.0430 (03.05.2023):
   
   -- Datei/Ordnernamen mit Sonderzeichen unter Windows wird wohl erst einmal nichts werden.
   
   

   -- Version 0.05.0390 => 0.05.0410 (02.05.2023):
   
   -- Weiter versucht das Einlesen von Dateien/Ordner mit Sonderzeichen unter Windows korrekt zum Laufen zu bringen.
   
   

   -- Version 0.05.0370 => 0.05.0390 (01.05.2023):
   
   -- Sprachenordner können unter Linux jetzt auch Sonderzeichen enthalten.

end ChangelogMai2023;

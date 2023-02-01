package ChangelogVorlage is
   
   -- Version 0.04.7075 => 0.04.7120 (31.01.2023):
   
   -- Fehler korrigiert welcher es ermöglichte die Karte zu zoomen während man in einer Stadt war.
   -- Anzeigesystem der Stadtumgebung überarbeitet.
   -- Angefangen das Arbeiterplatzierungssystem zu überarbeiten.
   -- Contracts, Kommentare und Kleinigkeiten korrigiert.
   
   

   -- Version 0.04.6960 => 0.04.7075 (30.01.2023):
   
   -- Forschungsbäume nummeriert und zu GitHub hinzugefügt.
   -- Einheitenbäume erweitert um Einheiten zu haben mit denen die Feldeffekte getestet werden können.
   -- Zusätzliche Testgrafiken für Einheiten angelegt und eingebaut.
   -- Feldeffekte können jetzt durch Siedler entfernt werden.
   -- Farbfehler im Steuerungsmenü korrigiert und die Festlegung der Textparameter in eine Schleife gepackt.
   -- Die Entfernung von Feldeffekte ist jetzt rudimentär von den Technologien abhängig.
   -- Diverse Zahlen durch benannte Konstanten ersetzt.
   -- Code besser aufgeteilt.
   -- Textarrays leicht verbessert.
   -- Contracts, Kommentare und Kleinigkeiten korrigiert/entfernt/angepasst/überarbeitet.
   
   

   -- Version 0.04.6860 => 0.04.6960 (29.01.2023):
   
   -- Formatierung leicht überarbeitet.
   -- Zusatzgrund wird Unterwasser jetzt auch auf Küstengrund platziert.
   -- Die Geschwindigkeit der Meinungsverbesserungen ist jetzt vom Schwierigkeitsgrad abhängig.
   -- Wenn Effektwaffen eingesetzt werden und der Effekt sich auf die Gebiete oder Einheiten anderer Spezies auswirkt, dann führt das zu einer sofortigen Kriegserklärung.
   -- Einsatz von PZB führt jetzt immer zu einer sofortigen Kriegserklärung.
   -- Die Effekthöhe wird jetzt Ebenen- und Effektabhängig ermittelt und ist nicht mehr fest vorgegeben.
   -- Effektausweitung berücksichtigt jetzt rudimentär den vorhandenen Basisgrund.
   -- Angefangen Einmalwaffen in die vorhandenen Einheitenbäume einzubauen.
   -- Kommentare und Kleinigkeiten korrigiert/überarbeitet/angepasst/erweitert.
   
   

   -- Version 0.04.6805 => 0.04.6860 (28.01.2023):
   
   -- Fehler korrigiert, welcher dazu führte das bei Texten mit der Höhe oder Länge von 0.00 keine Stadt/Einheitenauswahl möglich war.
   -- Feldeffekte haben jetzt Auswirkung auf die Produktion einer Stadt.
   -- Feldeffekte die durch Kämpfe und dem Einsatz von Einmalwaffen erzeugt werden haben jetzt eine negative Auswirkung auf die Meinung der anderen Spezien.
   -- Contracts, Kommentare und Kleinigkeiten korrigiert/angepasst/überarbeitet/zusammengefasst.
   
   

   -- Version 0.04.6770 => 0.04.6805 (27.01.2023):
   
   -- Texte für Feldeffekte hinzugefügt.
   -- Feldeffekte haben jetzt eine Auswirkung auf die Regeneration der Lebens- und Bewegungspunkte von Einheiten.
   -- Kleinigkeiten korrigiert.
   
   

   -- Version 0.04.6700 => 0.04.6770 (26.01.2023):
   
   -- WeltkarteZeichnen vollständig aufgeteilt.
   -- Fehler korrigiert, welcher zu eine Stopp führen konnte wenn man eine bewachte Stadt mit einer Einmalwaffe angriff.
   -- Fehler korrigiert, der bei gültigen Fenstereinstellungen zu einem Stopp führte.
   -- 'delay until' wieder auf 'delay' umgestellt, da sonst die Tasks nicht mehr korrekt abgebrochen werden.
   -- Angefangen die Seitenleiste für Feldeffekte zu erweitern.
   -- Kommentare und Kleinigkeiten korrigiert/angepasst/überarbeitet.
   
   

   -- Version 0.04.6700 => 0.04.6700 (25.01.2023):
   
   -- null.
   
   

   -- Version 0.04.6640 => 0.04.6700 (24.01.2023):
   
   -- Fehler korrigiert der bei der Feldproduktuionsanzeige zur falschen Positionierung/Skalierung des Textes führte.
   -- Chemische Verschmutzung folgt jetzt den Flussverläufen.
   -- Neue Testgrafiken für die Effekte erstellt.
   -- WeltkarteZeichnen angefangen aufzuteilen.
   -- Contracts, Kommentare und Kleinigkeiten korrigiert/aufgeteilt.
   
   

   -- Version 0.04.6640 => 0.04.6640 (23.01.2023):
   
   -- null.
   
   

   -- Version 0.04.6560 => 0.04.6640 (22.01.2023):
   
   -- Effektberechnungen erweitert.
   -- Effektgrafiken erstellt.
   -- Anpassungen vorgenommen damit alles mit dem neuen Effektsystem noch funktioniert.
   -- Effektanzeige für die Weltkarte eingebaut.
   -- Effektanzeige für die Stadtumgebung eingebaut.
   -- Es können jetzt verschiedene Arten von Einmalwaffen existieren, welche nach einmaliger Verwenndung verbraucht werden und Zusatzeffekte für Kartenfelder erzeugen.
   -- Contracts, Kommentare und Kleinigkeiten korrigiert/angepasst/überarbeitet.
   
   

   -- Version 0.04.6510 => 0.04.6560 (21.01.2023):
   
   -- Einheitendatenbank an das neue Zusatzeffektsystem angepasst.
   -- Effektberechnungen für das Kampfsystem angefangen einzubauen.
   -- PZBSystem angefangen zu überarbeiten.
   -- Contracts, Kommentare und Kleinigkeiten korrigiert/überarbeitet.
   
   

   -- Version 0.04.6450 => 0.04.6510 (20.01.2023):
   
   -- Beim Starten eine neuen Spiels/Laden eines Spielstandes wird jetzt der Bewegungsplan auch auf Standardwerte gesetzt.
   -- Weiter am Effektsystem für Kartenfelder/Einheiten gearbeitet.
   -- Angefangen das Aufgabensystem um einen Bereich für die Effektbehebung zu erweitern.
   -- Neue Beispielbilder erstellt.
   -- Contracts, Kommentare und Kleinigkeiten korrigiert/angepasst/überarbeitet.
   
   

   -- Version 0.04.6345 => 0.04.6450 (19.01.2023):
   
   -- Bei der Auswahl zwischen Stadt/Einheit und Transporter/Ladung werden zu lange Namen jetzt skaliert.
   -- Festlegen der Farbe in das das Textaccessverwaltungssystem integriert.
   -- Das Textaccessverwaltungssystem überall eingebaut.
   -- Diagnosesystem erweitert.
   -- Textskalierung vereinfacht und verbessert.
   -- 'delay' durch 'delay until' ersetzt.
   -- Lokale Pragmas erweitert.
   -- Ermittlung der Kampfwerte von Einheiten angepasst, damit es bei gleichzeitigem Zugriff durch Logik und Grafik keine Probleme mehr gibt.
   -- Contracts, Kommentare und Kleinigkeiten korrigiert/angepasst/überarbeitet/zusammengefasst.
   
   

   -- Version 0.04.6345 => 0.04.6345 (18.01.2023):
   
   -- null.
   
   

   -- Version 0.04.6300 => 0.04.6345 (17.01.2023):
   
   -- Textberechnungen verwenden jetzt locale Bounds anstelle von globale Bounds.
   -- Fehler korrigiert der bei leeren Stadtnamen zu einem Programmstopp führte.
   -- Fehler korrigiert welcher bei Texteingaben das Bestätigen noch an den Text anhängte.
   -- Kommentare und Kleinigkeiten korrigiert/angepasst.
   
   

   -- Version 0.04.6300 => 0.04.6300 (16.01.2023):
   
   -- null.
   
   

   -- Version 0.04.6300 => 0.04.6300 (15.01.2023):
   
   -- null.
   
   

   -- Version 0.04.6240 => 0.04.6300 (14.01.2023):
   
   -- Weiter am Textaccessverwaltungssystem gearbeitet.
   -- Angefangen das Textaccessverwaltungssystem überall zu verwenden.
   -- Unnötigen Code gelöscht.
   -- Stadtanzeige überarbeitet.
   -- Contracts, Kommentare und Kleinigkeiten korrigiert/überarbeitet.
   
   

   -- Version 0.04.6190 => 0.04.6240 (13.01.2023):
   
   -- Anpassungen an der Darstellung/Skalierung der Seitenleiste vorgenommen.
   -- Stadtnamen auf der Weltkarte werden jetzt besser skaliert.
   -- Angefangen ein System zum besseren Einstellen von Textaccessen zu bauen.
   -- Contracts, Kommentare und Kleinigkeiten korrigiert/angepasst/überarbeitet.
   
   

   -- Version 0.04.6100 => 0.04.6190 (12.01.2023):
   
   -- Anzeige der Stadt/Einheitennamen im Auswahlmenü angepasst, so dass lange Stadtnamen nicht mehr die Skalierung schreddert.
   -- Beim Verkaufen eines Gebäudes werden jetzt genauere Informationen zum Gebäude angezeigt.
   -- Diverse Konstanten eingebaut/umgebaut.
   -- Es ist jetzt möglich die Heimatstadt einer Einheit ganz zu entfernen.
   -- Einheiten die über keine Heimatstadt verfügen bekommen jetzt einen Malus auf ihre Verteidigung und ihren Angriff.
   -- Fehler korrigiert welche bei der Ja/Nein Abfrage das falsche Wort anzeigte.
   -- Es werden jetzt immer die aktuellen Kampfwerte einer Einheit angezeigt.
   -- Contracts, Kommentare und Kleinigkeiten korrigiert/angepasst/überarbeitet.
   
   

   -- Version 0.04.6080 => 0.04.6100 (11.01.2023):
   
   -- Fehlermeldungen angepasst.
   
   

   -- Version 0.04.6080 => 0.04.6080 (10.01.2023):
   
   -- null.
   
   

   -- Version 0.04.6040 => 0.04.6080 (09.01.2023):
   
   -- Verschiedene Bibliotheken aktualisiert.
   -- Zahlreiche Variablen/Verzeichnisse/Dateien umbenannt.
   -- Unnötige Dateien gelöscht.
   
   

   -- Version 0.04.6040 => 0.04.6040 (08.01.2023):
   
   -- null.
   
   

   -- Version 0.04.6005 => 0.04.6040 (07.01.2023):
   
   -- Gebäude werden jetzt in der neuen Stadtkarte angezeigt.
   -- Variable Größendarstellung für Sprites eingebaut.
   -- Contracts, Kommentare und Kleinigkeiten korrigiert.
   
   

   -- Version 0.04.5960 => 0.04.6005 (06.01.2023):
   
   -- Belegte Stadtfelder zeigen jetzt die jeweilige Produktion an.
   -- Veraltete Texte und dazugehörige Konstanten entfernt.
   -- Anzeige verschiedener Stadttexte überarbeitet.
   -- Kommentare und Kleinigkeiten korrigiert/angepasst.
   
   

   -- Version 0.04.5960 => 0.04.5960 (05.01.2023):
   
   -- null.
   
   

   -- Version 0.04.5950 => 0.04.5960 (04.01.2023):
   
   -- Mit GNAT 13 herumexperimentiert.
   
   

   -- Version 0.04.5940 => 0.04.5950 (03.01.2023):
   
   -- Debian GNAT 12.2.0-12 auf Debian GNAT 12.2.0-13 aktualisiert.
   
   

   -- Version 0.04.5930 => 0.04.5940 (02.01.2023):
   
   -- Debian GNAT 12.2.0-11 auf Debian GNAT 12.2.0-12 aktualisiert.
   
   

   -- Version 0.04.5925 => 0.04.5930 (01.01.2023):
   
   -- Kleinigkeiten korrigiert.

end ChangelogVorlage;

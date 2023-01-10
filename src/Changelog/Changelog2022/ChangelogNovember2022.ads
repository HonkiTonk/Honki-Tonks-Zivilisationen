package ChangelogNovember2022 is

   -- Version 0.04.4940 => 0.04.5060 (30.11.2022):
   
   -- KI überarbeitet.
   -- Die Wegfindung sollte jetzt wieder korrekt funktionieren.
   -- Wegfindung optimiert.
   -- Das Bewegen von Einheiten über mehrere Felder sollte jetzt fehlerfrei funktionieren.
   -- Unnötigen Code gelöscht.
   -- Bewegungssystem für menschliche Spielen angefangen großflächig zu überarbeiten.
   -- Einheiten in Transporter laden funktioniert korrekt mit dem neuen Bewegungssystem.
   -- Eigene Einheiten die Plätze tauschen zu lassen funktioniert jetzt mit dem neuen Bewegungssystem.
   -- Es ist jetzt möglich Einheiten über Felder mit eigenen Einheiten zu bewegen ohne sie zu tauschen.
   -- Code zusammengeführt.
   -- Contracts, Kommentare und Kleinigkeiten korrigiert/überarbeitet/angepasst.
   
   

   -- Version 0.04.4830 => 0.04.4940 (29.11.2022):
   
   -- Anpassungen an den gpr Dateien vorgenommen.
   -- KI überarbeitet.
   -- Fehler in der Wegfindung der KI korrigiert, welcher dazu führen konnte dass die KI den längeren Weg nahm statt den Kürzeren.
   -- Eine Stadt kann jetzt nur noch Grund belegen wenn dieser Grund mit dem eigenen Reich verbunden ist.
   -- Fehler korrigiert der zu einem Überlauf führen konnte wenn die KI feindliche Städte zum Angreifen suchte.
   -- Die KI sollte jetzt problemfrei mit allen Arten von Kartenübergängen klar kommen.
   -- Fehler korrigiert der dafür sorgte dass die Bewegungsplanberechnung falsche Felder als das Ziel erkannte.
   -- Es ist jetzt möglich eine Einheit über mehrere Felder auf einmal zu bewegen.
   -- Wegfindung überarbeitet.
   -- Contracts, Kommentare und Kleinigkeiten korrigiert/angepasst/überarbeitet.
   
   

   -- Version 0.04.4695 => 0.04.4830 (28.11.2022):
   
   -- Code zusammengeführt.
   -- Das Erweitern und Verkleinern der Stadtumgebung zusammengeführt.
   -- Code gelöscht.
   -- GPRBuild/GPRProject auf Version 23.0.0.1 aktualisiert.
   -- Berechnung der Stadtumgebung und der automatischen Stadtfeldbewirtschaftung überarbeitet.
   -- Fehler korrigiert der verhinderte dass ein Weiterspielen nach dem Besiegen aller Feinde möglich war.
   -- Kleine grafische Anpassungen vorgenommen.
   -- Bewegungsplanvereinfachung für die KI optimiert.
   -- Einen Fehler korrigiert der der KI ermöglichte auf ein Feld zu ziehen ohne die benötigten Bewegungspunkte dafür zu haben.
   -- KI überarbeitet.
   -- Die KI ist jetzt in der Lage das Erkunden abzubrechen um eine Einheit zu verbessern.
   -- Contracts, Kommentare und Kleinigkeiten korrigiert/überarbeitet/angepasst/erweitert.
   
   

   -- Version 0.04.4655 => 0.04.4695 (27.11.2022):
   
   -- Hat man eine Einheit ausgewählt und befindet sich auf einer anderen Ebene als diese, dann wird das Einheitenfeld mit einem Rahmen markiert.
   -- Beim Entfernen einer Stadt wird jetzt geprüft ob Städte in der Nähe dieses Gebiet belegen können.
   -- Contracts, Kommentare und Kleinigkeiten korrigiert/überarbeitet.
   
   

   -- Version 0.04.4585 => 0.04.4655 (26.11.2022):
   
   -- Den Zugriff auf die KIVariablen durch ein Lese- und Schreibesystem eingeschränkt.
   -- KI überarbeitet.
   -- Im Krieg versucht die KI im Bedrohungsfall mit ihren Siedler zu fliehen oder sie zu befestigen.
   -- Die KI prüft nur noch im Krieg ob sie mit einer Einheit angreifen soll.
   -- Die KI setzt eine PZB nur noch ein wenn sie keine Städte und keine Siedler mehr hat.
   -- Contracts, Kommentare und Kleinigkeiten korrigiert/überarbeitet.
   
   

   -- Version 0.04.4505 => 0.04.4585 (25.11.2022):
   
   -- Kleine Anpassungen für Alire vorgenommen.
   -- Datentypen aufgeteilt.
   -- KI überarbeitet.
   -- Unnötigen Code gelöscht.
   -- Einige Fehler korrigiert die auftraten wenn der aktive menschliche Spieler besiegt wurde, die Grafik aber noch auf diese Spielerinformationen Zugriff.
   -- Die KI bricht jetzt bestimmte Aufgaben ab wenn sie sich im Krieg befindet und eine feindliche Angriffseinheit zu Nahe ist.
   -- Contracts, Kommentare und Kleinigkeiten korrigiert/überarbeitet.
   
   

   -- Version 0.04.4380 => 0.04.4505 (24.11.2022):
   
   -- Das Ladesystem prüft jetzt erst ob ein Spielstand alle benötigten Daten enthält bevor er geladen wird.
   -- Es wird jetzt eine Meldung angezeigt wenn ein Spielstand nicht geladen werden kann.
   -- Hügel- und Gebirge_Enums erweitert damit es möglich ist sie über mehrere Felder zu ziehen wie den Zusatzgrund.
   -- Neue Grafiken für die zusätzlichen Basisgründe erstellt.
   -- Kartengenerator an die ganzen Änderungen angepasst.
   -- Basisgrundplatzierungssystem fertiggestellt, es ist jetzt möglich Hügel und Gebirge über mehrere Felder zu ziehen.
   -- Code vereinfacht.
   -- Die Änderung der Ressourcenmenge hat jetzt wieder einen Einfluss auf die vorhandenen Ressourcen.
   -- Neue Beispielbilder erstellt.
   -- KI überarbeitet.
   -- Contracts, Kommentare und Kleinigkeiten korrigiert/überarbeitet/angepasst/entfernt.
   
   

   -- Version 0.04.4245 => 0.04.4380 (23.11.2022):
   
   -- Alire Version hinzugefügt.
   -- Einige Anpassungen an der internen und externen Struktur vorgenommen damit es keine Probleme mit der Alire Version gibt.
   -- Platzierungssystem für den Zusatzgrund fertiggestellt, es ist jetzt möglich Wälder/Dschungel/Sumpf/usw. über mehrere Felder zu ziehen.
   -- Neue Grafiken für die verschiedenen Zusatzgrundarten erstellt.
   -- Beim Entfernen von Wegen werden die angrenzenden Wege jetzt entsprechend angepasst.
   -- Fehler korrigiert der dazu führte das man Roden/Trockenlegen auf einem Feld vornehmen konnte auf dem es nichts zum Roden/Trockenlegen gab.
   -- Beim Entfernen von Zusatzgrund wird die Umgebung jetzt entsprechend angepasst.
   -- Überall wo es sinnvoll erschien 'Succ in den Enumbereich eingebaut.
   -- Hülle des Basisgrundplatzierungssystem erweitert.
   -- Angefangen das Ladesystem zu erweitern, damit es beim Laden eines fehlerhaften oder veralteten Spielstandes nicht mehr zu einem Absturz führt.
   -- Man wird nach dem Speichern nicht mehr sofort aus dem Speichermenü geworfen.
   -- Contracts, Kommentare und Kleinigkeiten korrigiert/überarbeitet/angepasst/hinzugefügt.
   
   

   -- Version 0.04.4140 => 0.04.4245 (22.11.2022):
   
   -- Alle Zugriffe auf die SpielVariablen erfolgen jetzt durch das Lese- und Schreibesystem.
   -- Alle Zugriffe auf die Steuerungsdatenbank erfolgt jetzt über ein Lese- und Schreibesystem.
   -- Angefangen 'Succ bei den Enumbereichen einzubauen.
   -- Den Zusatzgrund erweitert, so dass es jetzt möglich ist verschiedene Stücke des Grundes zu haben ähnlich den Fluss- und Wegearten.
   -- Den Kartengenerator an die Zusatzgrundänderungen angepast.
   -- Angefangen eine Platzierungssystem für die verschiedenen Arten von Zusatzgrund einzubauen, ähnlich dem Fluss- oder Wegeplatzierungssystem.
   -- Hülle für das Basisgrundplatzierungssystem angelegt.
   -- Den Kartenfelderordner für die Texturen in Basisgrund und Zusatzgrund aufgeteilt.
   -- Contracts, Kommentare und Kleinigkeiten korrigiert/angepasst/überarbeitet/verbessert.
   
   

   -- Version 0.04.4035 => 0.04.4140 (21.11.2022):
   
   -- Weiter daran gearbeitet den Zugriff auf die SpielVariablen nur noch durch Lese- und Schreibesystem zu erlauben.
   -- Fehler im Diplomatiesystem korrigiert der dazu führte das eine nicht belegte Spezies berücksichtigt wurde.
   -- Unnötigen Code gelöscht.
   -- Zusätzliche Überlaufprüfungen eingebaut.
   -- Zusätzliche Sicherheitsprüfungen eingebaut.
   -- Interne Sturktur überarbeitet.
   -- Teile des Debugsystems und des Fehlermeldungssystems miteinander verschmolzen.
   -- Doppelten Code zusammengeführt.
   -- Contracts, Kommentare und Kleinigkeiten korrigiert/angepasst/überarbeitet/entfernt.
   
   

   -- Version 0.04.3935 => 0.04.4035 (20.11.2022):
   
   -- Schreibe- und Lesesystem für die Weltkarte auf die Karteneinstellungen erweitert.
   -- Sämtliche Zugriffe auf die Weltkarte und ihre Einstellungen erfolgen jetzt über das dazugehörige Lese- und Schreibesystem.
   -- Wenn man mit den Bewegungstasten eine Einheit aus dem Bild bewegt wird jetzt das Bild korrekt mitgescrollt.
   -- Die Menge an Kartenfelder die die KI in ihren Berechnungen nutzt ist jetzt abhängig vom Schwierigkeitsgrad.
   -- KI überarbeitet.
   -- Angefangen den Zugriff auf die SpielVariablen nur noch durch Lese- und Schreibesystem zu erlauben.
   -- Generische Überlaufprüfung angelegt und angefangen einzubauen.
   -- Fehler korrigiert der dazu führte dass die Anzahl der eingesetzten PZB beim Start eines weiteren Spieles nicht zurückgesetzt wurde.
   -- Contracts, Kommentare und Kleinigkeiten korrigiert/überarbeitet/angepasst.
   
   

   -- Version 0.04.3895 => 0.04.3935 (19.11.2022):
   
   -- Schreibe- und Lesesystem für die Weltkarte auf die Karteneinstellungen erweitert.
   -- Interne Struktur überarbeitet.
   -- Contracts, Kommentare und Kleinigkeiten korrigiert/überarbeitet.
   
   

   -- Version 0.04.3815 => 0.04.3895 (18.11.2022):
   
   -- Anpassungen an den gpr Dateien vorgenommen.
   -- Zusätzliche Sicherheitsprüfungen eingebaut.
   -- Diverse Zahlen in Konstante umgewandelt.
   -- Fehler- und Warnsystem erweitert.
   -- Fehler- und Warnsystem zusammengeführt.
   -- Fehler korrigiert der beim Tauschen von Einheiten durch die KI zu einem Absturz führte.
   -- Contarcts, Kommentare und Kleinigkeiten korrigiert/überarbeitet.
   
   

   -- Version 0.04.3640 => 0.04.3815 (17.11.2022):
   
   -- Anpassungen an den gpr Dateien vorgenommen.
   -- Dateien zum Kompilieren einer Windowsversion zu GitHub hinzugefügt.
   -- Alle Dateien sollten jetzt wirklich soweit möglich Pure, Preelaborate oder Elaborate_Body enthalten.
   -- Teile des Codes überarbeitet damit nirgendwo mehr im Kreis gelinkt wird.
   -- Einheitenbewegungssystem überarbeitet.
   -- Unnötigen Code gelöscht.
   -- Die notwendigen Bewegungspunkte und Bonusbewegungspunkte für ein Feld/Weg werden jetzt in den Kartengrund- und Wegedatenbanken gespeichert.
   -- Die notwendigen Bewegungspunkte um ein Feld zu betreten können jetzt Speziesspezifisch eingestellt werden.
   -- Zusätzliche Sicherheitsprüfungen eingebaut.
   -- Fehler korrigiert der dazu führte dass die KI versuchte mit sehr vielen Einheiten eine Stadt zu bewachen.
   -- Fehler korrigiert der es der KI erlaubte Einheiten zu bewegen die keine Bewegungspunkte mehr hatten.
   -- KI überarbeitet
   -- Bewegungsplanberechnung der KI überarbeitet.
   -- Die KI ist jetzt besser darin unnötige Einheitenzüge zum Ziel zu vermeiden.
   -- Die KI ist jetzt in der Lage nebeneinander liegende Einheiten die Plätze tauschen zu lassen.
   -- Contracts, Kommentare und Kleinigkeiten korrigiert/angepasst/überarbeitet/erweitert.
   
   

   -- Version 0.04.3605 => 0.04.3640 (16.11.2022):
   
   -- Einige vergessene Dateien um pragma Pure, Preelaborate oder Elaborate_Body erweitert.
   -- Einige vergessene Einbindungen auf private gesetzt.
   -- Kommenatare und Kleinigkeiten korrigiert.
   
   

   -- Version 0.04.3520 => 0.04.3605 (15.11.2022):
   
   -- Anpassungen an den gpr Dateien vorgenommen.
   -- Alle Dateien sollten jetzt soweit möglich Pure, Preelaborate oder Elaborate_Body enthalten.
   -- Teile des Codes überarbeitet damit nicht mehr im Kreis gelinkt wird.
   -- Datenbanken können jetzt wieder einzeln geschrieben werden.
   -- Datenbanken bearbeitet.
   -- Die KI ist jetzt in der Lage die Einheiten zu verbessern welche ihre Städte schützt.
   -- KI überarbeitet.
   -- Kommentare und Kleinigkeiten korrigiert/überarbeitet.
   
   

   -- Version 0.04.3460 => 0.04.3520 (14.11.2022):
   
   -- KI überarbeitet.
   -- Die KI Berechnungen für den Standort einer neuen Stadt um einen Zufallsfaktor erweitert.
   -- Bevor die KI jetzt eine Stadt baut prüft sie erneut ob immer noch ausreichend Platz vorhanden ist.
   -- Das Erkunden durch die KI um einen Zufallsfaktor erweitert.
   -- Contracts, Kommentare und Kleinigkeiten korrigiert/angepasst/überarbeitet.
   
   

   -- Version 0.04.3410 => 0.04.3460 (13.11.2022):
   
   -- Die Sichtbarkeit von vielen Programmteilen reduziert durch das Ersetzen von 'use' durch 'use type'.
   -- Die Sichtbarkeit von einigen Programmteilen reduziert durch das Verschieben nach private.
   -- Unnötigen Code gelöscht.
   -- Contarcs, Kommentare und Kleinigkeiten korrigiert/angepasst.
   
   

   -- Version 0.04.3390 => 0.04.3410 (12.11.2022):
   
   -- Kleinigkeiten korrigiert.
   
   

   -- Version 0.04.3320 => 0.04.3390 (11.11.2022):
   
   -- KI überarbeitet.
   -- Bewegungsplanberechnung der KI überarbeitet.
   -- Angefangen die Berechnungen der KI weniger vorhersagbar zu gestalten.
   -- Die KI ist jetzt besser in der Lage einen Weg zu Berechnen, wenn beliebige Übergängsarten für die Achsen eingestellt sind.
   -- Aufgabenprüfung der KI überarbeitet.
   -- Kommentare und Kleinigkeiten korrigiert/überarbeitet/angepasst.
   
   

   -- Version 0.04.3220 => 0.04.3320 (10.11.2022):
   
   -- Fehler behoben durch den die Ekropa Schiffe über Schienen bewegen konnten.
   -- Versionsnummerberechnung angepasst.
   -- pragma Warnings (Off, "*array aggregate*"); in eine Datei ausgelagert.
   -- Unnötigen Code gelöscht.
   -- KI überarbeitet.
   -- Bewegungsplanberechnung der KI überarbeitet.
   -- Die KI ist jetzt besser in der Lage einen Weg zu Berechnen, wenn normale Übergänge für die XAchse oder YAchse eingestellt sind.
   -- Fehler korrigiert der dazu führte dass die KI unnötig viele Einheiten verwendete um eine einzelne Aufgabe durchzuführen.
   -- Contracts, Kommentare und Kleinigkeiten korrigiert/überarbeitet/angepasst.
   
   

   -- Version 0.04.3130 => 0.04.3220 (09.11.2022):
   
   -- Hochwertiges Holz als Ressource hinzugefügt.
   -- KI überarbeitet.
   -- Berechnungssystem für das Anlegen von Verbesserungen durch die KI überarbeitet.
   -- KI entfernt jetzt keinen Wald mehr wenn sich auf diesem hochwertiges Holz befindet.
   -- Das Eentfernen eines Waldes/Dschungels entfernt jetzt auch hochwertiges Holz.
   -- Bewegungsplanberechnung der KI überarbeitet.
   -- Fehler korrigiert der es erlaubte mehr als das Maximum an Ressourcen in einer Stadt zu haben und dadurch zu einem Absturz führte.
   -- Contracts, Kommentare und Kleinigkeiten korrigiert/überarbeitet/angepasst.
   
   

   -- Version 0.04.3130 => 0.04.3130 (08.11.2022):
   
   -- null.
   
   

   -- Version 0.04.3130 => 0.04.3130 (07.11.2022):
   
   -- null.
   
   

   -- Version 0.04.3130 => 0.04.3130 (06.11.2022):
   
   -- null.
   
   

   -- Version 0.04.3040 => 0.04.3130 (05.11.2022):
   
   -- Angriff- und Verteidigungswerte überarbeitet, so dass die Kartenfelder jetzt besser Bonus und Malus geben können.
   -- Kampfsystem überarbeitet.
   -- Der Einsatz einer PZB wird jetzt auch korrekt erkannt wenn sie gegen eine Stadt eingesetzt wird.
   -- Theoretische Endloskampfsituation entfernt.
   -- Mehr OO in Form von tagged Records entfernt.
   -- Seitenleiste überarbeitet.
   -- Speicherverbrauch um rund 65 MB reduziert.
   -- Contracts, Kommentare und Kleinigkeiten korrigiert/angepasst/zusammengefasst.
   
   

   -- Version 0.04.2960 => 0.04.3040 (04.11.2022):
   
   -- Versionsnummerberechnung angepasst.
   -- GNAT von 12.2.0-7 auf GNAT 12.2.0-9 aktualisiert.
   -- Berechnung von Bonuswerte im Kampf überarbeitet.
   -- Fehler korrigiert der dazu führte das Einheiten weniger als einen Lebenspunkt haben konnten.
   -- Unnötigen Code gelöscht.
   -- Seitenleiste überarbeitet.
   -- Contracts, Kommentare und Kleinigkeiten korrigiert/überarbeitet.
   
   

   -- Version 0.04.2785 => 0.04.2960 (03.11.2022):
   
   -- Weiter an der KI gearbeitet.
   -- SPARK_Mode (On/Off) entfernt, wird vermutlich niemals gebraucht werden.
   -- Neue Version der Siedleraufgabenplanung für die KI gebaut.
   -- Unnötigen Code gelöscht.
   -- Code zusammengeführt.
   -- Neue Version der Nahkämpferaufgabenplanung für die KI gebaut.
   -- Die KI kann jetzt in Kriegen eine PZB einsetzen.
   -- Die KI baut jetzt Städte in anderen Ebenen.
   -- Fehler behoben der die vorhandenen Einheiten falsch zählte und so unter bestimmten Bedingungen einen Absturz erzeugen konnte.
   -- Interne Struktur überarbeitet.
   -- Contracts, Kommentare und Kleinigkeiten korrigiert/angepasst/überarbeitet/erweitert.
   
   

   -- Version 0.04.2785 => 0.04.2785 (02.11.2022):
   
   -- null.
   
   

   -- Version 0.04.2785 => 0.04.2785 (01.11.2022):
   
   -- null.

end ChangelogNovember2022;

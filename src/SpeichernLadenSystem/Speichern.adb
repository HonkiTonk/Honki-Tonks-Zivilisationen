pragma SPARK_Mode (On);

with Ada.Strings.UTF_Encoding.Wide_Wide_Strings, Ada.Directories, Ada.Calendar;
use Ada.Strings.UTF_Encoding.Wide_Wide_Strings, Ada.Directories, Ada.Calendar;

with GlobaleVariablen, GlobaleRecords;

with Karten, Eingabe, Auswahl, Ladezeiten, Informationen;

package body Speichern is

   procedure SpeichernNeu
     (AutospeichernExtern : in Boolean)
   is begin      

      case
        AutospeichernExtern
      is
         when False =>
            SpielstandName := Eingabe.SpielstandName;

            -- Anzeige der vorhandenen Spielstände einbauen
            if
              Exists (Name => "Spielstand/" & Encode (Item => To_Wide_Wide_String (Source => SpielstandName))) = True
            then
               case
                 Auswahl.AuswahlJaNein (FrageZeileExtern => 18)
               is
                  when -3 =>
                     null;
                     
                  when others =>
                     return;
               end case;

            else
               null;
            end if;

         when True =>                        
            SpielstandName := To_Unbounded_Wide_Wide_String (Source => "Autospeichern" & AutospeichernWert'Wide_Wide_Image);
            if
              GlobaleVariablen.NutzerEinstellungen.AnzahlAutosave = 1
            then
               null;

            elsif
              AutospeichernWert <= GlobaleVariablen.NutzerEinstellungen.AnzahlAutosave - 1
            then
               AutospeichernWert := AutospeichernWert + 1;
                  
            else               
               AutospeichernWert := 1;
            end if;
      end case;

      Ladezeiten.EinzelneZeiten (3, GlobaleDatentypen.Anfangswert) := Clock;
      
      Create (File => DateiSpeichernNeu,
              Mode => Out_File,
              Name => "Spielstand/" & Encode (Item => (To_Wide_Wide_String (Source => SpielstandName))));

      -- Versionsnummer speichern
      Wide_Wide_String'Write (Stream (File => DateiSpeichernNeu), 
                              Informationen.Versionsnummer);
      -- Versionsnummer speichern
      
      
      
      -- Rundenanzahl und Grenze speichern
      Positive'Write (Stream (File => DateiSpeichernNeu),
                      GlobaleVariablen.RundenAnzahl);
      
      Natural'Write (Stream (File => DateiSpeichernNeu),
                     GlobaleVariablen.Rundengrenze);
      -- Rundenanzahl und Grenze speichern
      
      

      -- Spieler am Zug speichern
      GlobaleDatentypen.Rassen_Enum'Write (Stream (File => DateiSpeichernNeu),
                                           GlobaleVariablen.RasseAmZugNachLaden);
      -- Spieler am Zug speichern
      
      
      
      -- Schwierigkeitsgrad speichern
      GlobaleDatentypen.Schwierigkeitsgrad_Verwendet_Enum'Write (Stream (File => DateiSpeichernNeu),
                                                                 GlobaleVariablen.Schwierigkeitsgrad);
      -- Schwierigkeitsgrad speichern
      
      
      
      -- Gewonnen laden
      Boolean'Write (Stream (File => DateiSpeichernNeu),
                     GlobaleVariablen.Gewonnen);
      -- Gewonnen laden
      
      

      -- Schleife zum Speichern der Karte
      GlobaleDatentypen.Kartentemperatur_Verwendet_Enum'Write (Stream (File => DateiSpeichernNeu),
                                                               Karten.Kartentemperatur);
      
      GlobaleDatentypen.Kartenform_Verwendet_Enum'Write (Stream (File => DateiSpeichernNeu),
                                                         Karten.Kartenform);
      
      GlobaleDatentypen.Kartengröße_Verwendet_Enum'Write (Stream (File => DateiSpeichernNeu),
                                                            Karten.Kartengröße);
      
      case
        Karten.Kartengröße
      is
         when GlobaleDatentypen.Karte_Nutzer =>
            Karten.KartengrößenRecord'Write (Stream (File => DateiSpeichernNeu),
                                               Karten.Kartengrößen (GlobaleDatentypen.Karte_Nutzer));
            
         when others =>
            null;
      end case;

      EAchseBisBodenSchleife:
      for EAchseSchleifenwert in Karten.WeltkarteArray'First (1) .. 0 loop
         YAchseBisBodenSchleife:
         for YAchseSchleifenwert in Karten.WeltkarteArray'First (2) .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße loop
            XAchseBisBodenSchleife:
            for XAchseSchleifenwert in Karten.WeltkarteArray'First (3) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße loop

               GlobaleRecords.KartenRecord'Write (Stream (File => DateiSpeichernNeu),
                                                  Karten.Weltkarte (EAchseSchleifenwert, YAchseSchleifenwert, XAchseSchleifenwert));
               
            end loop XAchseBisBodenSchleife;
         end loop YAchseBisBodenSchleife;
      end loop EAchseBisBodenSchleife;
      
      EAchseBisWeltraumSchleife:
      for EAchseSchleifenwert in 1 .. Karten.WeltkarteArray'Last (1) loop
         YAchseBisWeltraumSchleife:
         for YAchseSchleifenwert in Karten.WeltkarteArray'First (2) .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße loop
            XAchseBisWeltraumSchleife:
            for XAchseSchleifenwert in Karten.WeltkarteArray'First (3) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße loop

               GlobaleDatentypen.SichtbarkeitArray'Write (Stream (File => DateiSpeichernNeu),
                                                          Karten.Weltkarte (EAchseSchleifenwert, YAchseSchleifenwert, XAchseSchleifenwert).Sichtbar);
               GlobaleDatentypen.Karten_Verbesserung_Enum'Write (Stream (File => DateiSpeichernNeu),
                                                                 Karten.Weltkarte (EAchseSchleifenwert, YAchseSchleifenwert, XAchseSchleifenwert).VerbesserungStraße);
               GlobaleDatentypen.Karten_Verbesserung_Enum'Write (Stream (File => DateiSpeichernNeu),
                                                                 Karten.Weltkarte (EAchseSchleifenwert, YAchseSchleifenwert, XAchseSchleifenwert).VerbesserungGebiet);
               GlobaleDatentypen.BelegterGrund'Write (Stream (File => DateiSpeichernNeu),
                                                      Karten.Weltkarte (EAchseSchleifenwert, YAchseSchleifenwert, XAchseSchleifenwert).DurchStadtBelegterGrund);
               GlobaleDatentypen.GesamtproduktionStadt'Write (Stream (File => DateiSpeichernNeu),
                                                              Karten.Weltkarte (EAchseSchleifenwert, YAchseSchleifenwert, XAchseSchleifenwert).Felderwertung);
               
            end loop XAchseBisWeltraumSchleife;
         end loop YAchseBisWeltraumSchleife;
      end loop EAchseBisWeltraumSchleife;
      -- Schleife zum Speichern der Karte



      -- Rassen und Rassengrenzen speichern
      GlobaleDatentypen.RassenImSpielArray'Write (Stream (File => DateiSpeichernNeu),
                                                  GlobaleVariablen.RassenImSpiel);
      
      GrenzenRassenSchleife:
      for GrenzenRassenSchleifenwert in GlobaleDatentypen.Rassen_Verwendet_Enum'Range loop
         
         GlobaleRecords.GrenzenRecord'Write (Stream (File => DateiSpeichernNeu),
                                             GlobaleVariablen.Grenzen (GrenzenRassenSchleifenwert));
         
      end loop GrenzenRassenSchleife;
      -- Rassen und Rassengrenzen speichern



      -- Schleife zum Speichern der Einheiten
      EinheitenRassenSchleife:
      for RasseEinheitenSchleifenwert in GlobaleVariablen.EinheitenGebautArray'Range (1) loop

         case
           GlobaleVariablen.RassenImSpiel (RasseEinheitenSchleifenwert)
         is
            when GlobaleDatentypen.Leer =>
               null;
               
            when others =>
               EinheitenSchleife:
               for EinheitNummerSchleifenwert in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (RasseEinheitenSchleifenwert).Einheitengrenze loop
                  
                  GlobaleRecords.EinheitenGebautRecord'Write (Stream (File => DateiSpeichernNeu),
                                                              GlobaleVariablen.EinheitenGebaut (RasseEinheitenSchleifenwert, EinheitNummerSchleifenwert));
            
               end loop EinheitenSchleife;
         end case;
         
      end loop EinheitenRassenSchleife;
      -- Schleife zum Speichern der Einheiten



      -- Schleife zum Speichern der Städte
      StadtRassenSchleife:
      for RasseStadtSchleifenwert in GlobaleVariablen.EinheitenGebautArray'Range (1) loop
         
         case
           GlobaleVariablen.RassenImSpiel (RasseStadtSchleifenwert)
         is
            when GlobaleDatentypen.Leer =>
               null;

            when others =>
               StadtSchleife:
               for StadtNummerSchleifenwert in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (RasseStadtSchleifenwert).Städtegrenze loop
                  
                  GlobaleRecords.EinheitenGebautRecord'Write (Stream (File => DateiSpeichernNeu),
                                                              GlobaleVariablen.EinheitenGebaut (RasseStadtSchleifenwert, StadtNummerSchleifenwert));
            
               end loop StadtSchleife;
         end case;
         
      end loop StadtRassenSchleife;
      -- Schleife zum Speichern der Städte



      -- Schleife zum Speichern von Wichtiges
      WichtigesSchleife:
      for RasseWichtigesSchleifenwert in GlobaleVariablen.WichtigesArray'Range loop
         
         case
           GlobaleVariablen.RassenImSpiel (RasseWichtigesSchleifenwert)
         is
            when GlobaleDatentypen.Leer =>
               null;
               
            when others =>
               GlobaleRecords.WichtigesRecord'Write (Stream (File => DateiSpeichernNeu),
                                                     GlobaleVariablen.Wichtiges (RasseWichtigesSchleifenwert));
         end case;
         
      end loop WichtigesSchleife;
      -- Schleife zum Speichern von Wichtiges



      -- Schleife zum Speichern von Diplomatie
      DiplomatieSchleifeAußen:
      for RasseDiplomatieEinsSchleifenwert in GlobaleVariablen.DiplomatieArray'Range (1) loop
         
         case
           GlobaleVariablen.RassenImSpiel (RasseDiplomatieEinsSchleifenwert)
         is
            when GlobaleDatentypen.Leer =>
               null;

            when others =>               
               DiplomatieSchleifeInnen:
               for RasseDiplomatieZweiSchleifenwert in GlobaleVariablen.DiplomatieArray'Range (2) loop

                  case
                    GlobaleVariablen.RassenImSpiel (RasseDiplomatieZweiSchleifenwert)
                  is
                     when GlobaleDatentypen.Leer =>
                        null;
                     
                     when others =>
                        GlobaleDatentypen.Status_Untereinander_Enum'Write (Stream (File => DateiSpeichernNeu),
                                                                           GlobaleVariablen.Diplomatie (RasseDiplomatieEinsSchleifenwert, RasseDiplomatieZweiSchleifenwert));
                  end case;

               end loop DiplomatieSchleifeInnen;
         end case;
               
      end loop DiplomatieSchleifeAußen;
      -- Schleife zum Speichern von Diplomatie



      -- Schleife zum Speichern der Cursorpositionen
      CursorSchleife:
      for RasseCursorSchleifenwert in GlobaleVariablen.CursorImSpielArray'Range loop
         
         case
           GlobaleVariablen.RassenImSpiel (RasseCursorSchleifenwert)
         is
            when GlobaleDatentypen.Leer =>
               null;
               
            when others =>
               GlobaleRecords.CursorRecord'Write (Stream (File => DateiSpeichernNeu),
                                                  GlobaleVariablen.CursorImSpiel (RasseCursorSchleifenwert));
         end case;
         
      end loop CursorSchleife;
      -- Schleife zum Speichern der Cursorpositionen
      
      Close (File => DateiSpeichernNeu);
         
      Ladezeiten.EinzelneZeiten (3, GlobaleDatentypen.Endwert) := Clock;
      Ladezeiten.AnzeigeEinzelneZeit (WelcheZeitExtern => 3);
   
   end SpeichernNeu;
   
   

   procedure AutoSpeichern
   is begin
      
      case
        GlobaleVariablen.RundenAnzahl mod GlobaleVariablen.NutzerEinstellungen.RundenBisAutosave
      is
         when 0 =>
            SpeichernNeu (AutospeichernExtern => True);
         
         when others =>
            null;
      end case;
      
   end AutoSpeichern;

end Speichern;

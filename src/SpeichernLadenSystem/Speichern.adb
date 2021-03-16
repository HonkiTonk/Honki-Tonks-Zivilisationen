pragma SPARK_Mode (On);

with Ada.Strings.UTF_Encoding.Wide_Wide_Strings, Ada.Directories, Ada.Calendar;
use Ada.Strings.UTF_Encoding.Wide_Wide_Strings, Ada.Directories, Ada.Calendar;

with GlobaleVariablen, GlobaleRecords;

with Karten, Eingabe, Auswahl, Ladezeiten, Informationen;

package body Speichern is

   procedure SpeichernNeu (AutospeichernExtern : in Boolean) is
   begin      

      case AutospeichernExtern is
         when False =>
            SpielstandName := Eingabe.SpielstandName;

            case Exists (Name => "Spielstand/" & Encode (Item => To_Wide_Wide_String (Source => SpielstandName))) is -- Anzeige der vorhandenen Spielstände einbauen
               when True =>
                  Wahl := Auswahl.AuswahlJaNein (FrageZeileExtern => 18);
                  case Wahl is
                     when -3 =>
                        null;
                     
                     when others =>
                        return;
                  end case;

               when False =>
                  null;
            end case;

         when True =>                        
            SpielstandName := To_Unbounded_Wide_Wide_String (Source => "Autospeichern" & AutospeichernWert'Wide_Wide_Image);
            if GlobaleVariablen.AnzahlAutosave = 1 then
               null;

            elsif AutospeichernWert <= GlobaleVariablen.AnzahlAutosave - 1 then
               AutospeichernWert := AutospeichernWert + 1;
                  
            else               
               AutospeichernWert := 1;
            end if;
      end case;

      Ladezeiten.Speicherzeiten (1, 1) := Clock;
      
      Create (File => DateiSpeichernNeu,
              Mode => Out_File,
              Name => "Spielstand/" & Encode (Item => (To_Wide_Wide_String (Source => SpielstandName))));

      -- Versionsnummer speichern
      Wide_Wide_String'Write (Stream (File => DateiSpeichernNeu), 
                              Informationen.Versionsnummer);

      -- Rundenanzahl und Rundenanzahl bis zum Autospeichern speichern
      Positive'Write (Stream (File => DateiSpeichernNeu),
                      GlobaleVariablen.RundenAnzahl);
      Natural'Write (Stream (File => DateiSpeichernNeu), -- Das hier später in eine Config schieben
                     GlobaleVariablen.RundenBisAutosave);

      -- Spieler am Zug speichern
      GlobaleDatentypen.RassenMitNullwert'Write (Stream (File => DateiSpeichernNeu),
                                                 GlobaleVariablen.RasseAmZugNachLaden);

      -- Schleife zum Speichern der Karte
      Positive'Write (Stream (File => DateiSpeichernNeu),
                      Karten.Kartengröße);

      EAchseSchleife:
      for EAchse in Karten.WeltkarteArray'Range (1) loop
         YAchseSchleife:
         for YAchse in Karten.WeltkarteArray'First (2) .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße loop
            XAchseSchleife:
            for XAchse in Karten.WeltkarteArray'First (3) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße loop

               GlobaleRecords.KartenRecord'Write (Stream (File => DateiSpeichernNeu),
                                                  Karten.Weltkarte (EAchse, YAchse, XAchse));
               
            end loop XAchseSchleife;
         end loop YAchseSchleife;
      end loop EAchseSchleife;
      -- Schleife zum Speichern der Karte



      -- Rassen im Spiel speichern
      GlobaleDatentypen.RassenImSpielArray'Write (Stream (File => DateiSpeichernNeu),
                                                  GlobaleVariablen.RassenImSpiel);
      -- Rassen im Spiel speichern



      -- Schleife zum Speichern der Einheiten
      EinheitenRassenSchleife:
      for Rasse in GlobaleVariablen.EinheitenGebautArray'Range (1) loop

         case GlobaleVariablen.RassenImSpiel (Rasse) is
            when 0 =>
               null;
               
            when others =>
               EinheitenSchleife:
               for EinheitNummer in GlobaleVariablen.EinheitenGebautArray'Range (2) loop
                  
                  GlobaleRecords.EinheitenGebautRecord'Write (Stream (File => DateiSpeichernNeu),
                                                              GlobaleVariablen.EinheitenGebaut (Rasse, EinheitNummer));
            
               end loop EinheitenSchleife;
         end case;
         
      end loop EinheitenRassenSchleife;
      -- Schleife zum Speichern der Einheiten



      -- Schleife zum Speichern der Städte
      StadtRassenSchleife:
      for Rasse in GlobaleVariablen.EinheitenGebautArray'Range (1) loop
         
         case GlobaleVariablen.RassenImSpiel (Rasse) is
            when 0 =>
               null;

            when others =>
               StadtSchleife:
               for StadtNummer in GlobaleVariablen.EinheitenGebautArray'Range (2) loop
                  
                  GlobaleRecords.EinheitenGebautRecord'Write (Stream (File => DateiSpeichernNeu),
                                                              GlobaleVariablen.EinheitenGebaut (Rasse, StadtNummer));
            
               end loop StadtSchleife;
         end case;
         
      end loop StadtRassenSchleife;
      -- Schleife zum Speichern der Städte



      -- Schleife zum Speichern von Wichtiges
      WichtigesSchleife:
      for Rasse in GlobaleVariablen.WichtigesArray'Range loop
         
         case GlobaleVariablen.RassenImSpiel (Rasse) is
            when 0 =>
               null;
               
            when others =>
               GlobaleRecords.WichtigesRecord'Write (Stream (File => DateiSpeichernNeu),
                                                     GlobaleVariablen.Wichtiges (Rasse));
         end case;
         
      end loop WichtigesSchleife;
      -- Schleife zum Speichern von Wichtiges



      -- Schleife zum Speichern von Diplomatie
      DiplomatieSchleifeAußen:
      for Rasse in GlobaleVariablen.DiplomatieArray'Range (1) loop
         
         case GlobaleVariablen.RassenImSpiel (Rasse) is
            when 0 =>
               null;

            when others =>               
               DiplomatieSchleifeInnen:
               for RassenIntern in GlobaleVariablen.DiplomatieArray'Range (2) loop

                  case GlobaleVariablen.RassenImSpiel (RassenIntern) is
                     when 0 =>
                        null;
                     
                     when others =>
                        GlobaleVariablen.StatusUntereinander'Write (Stream (File => DateiSpeichernNeu),
                                                                    GlobaleVariablen.Diplomatie (Rasse, RassenIntern));
                  end case;

               end loop DiplomatieSchleifeInnen;
         end case;
               
      end loop DiplomatieSchleifeAußen;
      -- Schleife zum Speichern von Diplomatie



      -- Schleife zum Speichern der Cursorpositionen
      CursorSchleife:
      for Rasse in GlobaleVariablen.CursorImSpielArray'Range loop
         
         case GlobaleVariablen.RassenImSpiel (Rasse) is
            when 0 =>
               null;
               
            when others =>
               GlobaleRecords.CursorRecord'Write (Stream (File => DateiSpeichernNeu),
                                                  GlobaleVariablen.CursorImSpiel (Rasse));
         end case;
         
      end loop CursorSchleife;
      -- Schleife zum Speichern der Cursorpositionen
      
      Close (File => DateiSpeichernNeu);
         
      Ladezeiten.Speicherzeiten (2, 1) := Clock;
      Ladezeiten.Speichern (WelcheZeitExtern => 1);
   
   end SpeichernNeu;
   
   

   procedure AutoSpeichern is
   begin
      
      case GlobaleVariablen.RundenAnzahl mod GlobaleVariablen.RundenBisAutosave is
         when 0 =>
            SpeichernNeu (AutospeichernExtern => True);
         
         when others =>
            null;
      end case;
      
   end AutoSpeichern;

end Speichern;

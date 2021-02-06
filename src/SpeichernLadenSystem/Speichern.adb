pragma SPARK_Mode (On);

with Ada.Strings.UTF_Encoding.Wide_Wide_Strings, Ada.Directories, Ada.Calendar;
use Ada.Strings.UTF_Encoding.Wide_Wide_Strings, Ada.Directories, Ada.Calendar;

with Karten, GlobaleVariablen, Eingabe, Auswahl, Ladezeiten, GlobaleRecords, Informationen;

package body Speichern is

   procedure SpeichernNeu (Autospeichern : Boolean) is
   begin      

      case Autospeichern is
         when False =>
            SpielstandName := Eingabe.SpielstandName;

            case Exists (Name => "Dateien/Spielstand/" & Encode (Item => To_Wide_Wide_String (Source => SpielstandName))) is -- Anzeige der vorhandenen Spielstände einbauen
               when True =>
                  Wahl := Auswahl.AuswahlNeu (AuswahlOderAnzeige => True,
                                              FrageDatei         => 10,
                                              FrageZeile         => 18,
                                              TextDatei          => 5,
                                              ErsteZeile         => 10,
                                              LetzteZeile        => 11);
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
            case AutospeichernWert is
               when 1 .. 100 =>
                  null;
                  
               when others =>                  
                  AutospeichernWert := 1;
            end case;            
            SpielstandName := To_Unbounded_Wide_Wide_String (Source => "Autospeichern" & AutoSpeichernWert'Wide_Wide_Image);
      end case;

      Ladezeiten.Speicherzeiten (1, 1) := Clock;
      
      Create (File => DateiSpeichernNeu,
              Mode => Out_File,
              Name => "Dateien/Spielstand/" & Encode (Item => (To_Wide_Wide_String (Source => SpielstandName))));

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
      for EAchse in Karten.Karten'Range (1) loop
         YAchseSchleife:
         for YAchse in Karten.Karten'First (2) .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße loop
            XAchseSchleife:
            for XAchse in Karten.Karten'First (3) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße loop

               GlobaleRecords.KartenRecord'Write (Stream (File => DateiSpeichernNeu),
                                                  Karten.Karten (EAchse, YAchse, XAchse));
               
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
      for Rasse in GlobaleVariablen.EinheitenGebaut'Range (1) loop

         case GlobaleVariablen.RassenImSpiel (Rasse) is
            when 0 =>
               null;
               
            when others =>
               EinheitenSchleife:
               for EinheitNummer in GlobaleVariablen.EinheitenGebaut'Range (2) loop
                  
                  GlobaleRecords.EinheitenGebautRecord'Write (Stream (File => DateiSpeichernNeu),
                                                              GlobaleVariablen.EinheitenGebaut (Rasse, EinheitNummer));
            
               end loop EinheitenSchleife;
         end case;
         
      end loop EinheitenRassenSchleife;
      -- Schleife zum Speichern der Einheiten



      -- Schleife zum Speichern der Städte
      StadtRassenSchleife:
      for Rasse in GlobaleVariablen.EinheitenGebaut'Range (1) loop
         
         case GlobaleVariablen.RassenImSpiel (Rasse) is
            when 0 =>
               null;

            when others =>
               StadtSchleife:
               for StadtNummer in GlobaleVariablen.EinheitenGebaut'Range (2) loop
                  
                  GlobaleRecords.EinheitenGebautRecord'Write (Stream (File => DateiSpeichernNeu),
                                                              GlobaleVariablen.EinheitenGebaut (Rasse, StadtNummer));
            
               end loop StadtSchleife;
         end case;
         
      end loop StadtRassenSchleife;
      -- Schleife zum Speichern der Städte



      -- Schleife zum Speichern von Wichtiges
      WichtigesSchleife:
      for Rasse in GlobaleVariablen.Wichtiges'Range loop
         
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
      for Rasse in GlobaleVariablen.Diplomatie'Range (1) loop
         
         case GlobaleVariablen.RassenImSpiel (Rasse) is
            when 0 =>
               null;

            when others =>               
               DiplomatieSchleifeInnen:
               for Rassen in GlobaleVariablen.Diplomatie'Range (2) loop

                  case GlobaleVariablen.RassenImSpiel (Rassen) is
                     when 0 =>
                        null;
                     
                     when others =>
                        Integer'Write (Stream (File => DateiSpeichernNeu),
                                       GlobaleVariablen.Diplomatie (Rasse, Rassen));
                  end case;

               end loop DiplomatieSchleifeInnen;
         end case;
               
      end loop DiplomatieSchleifeAußen;
      -- Schleife zum Speichern von Diplomatie



      -- Schleife zum Speichern der Cursorpositionen
      CursorSchleife:
      for Rasse in GlobaleVariablen.CursorImSpiel'Range loop
         
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
      Ladezeiten.Speichern (WelcheZeit => 1);
   
   end SpeichernNeu;
   
   

   procedure AutoSpeichern is
   begin
      
      case GlobaleVariablen.RundenAnzahl mod GlobaleVariablen.RundenBisAutosave is
         when 0 =>
            SpeichernNeu (AutoSpeichern => True);
         
         when others =>
            null;
      end case;
      
   end AutoSpeichern;

end Speichern;

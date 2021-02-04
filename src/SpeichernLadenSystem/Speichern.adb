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

      Wide_Wide_String'Write (Stream (File => DateiSpeichernNeu),
                              Informationen.Versionsnummer);

      -- Schleife zum Speichern der Karte
      Integer'Write (Stream (File => DateiSpeichernNeu),
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



      -- Schleife zum Speichern der Einheiten
      EinheitenRassenSchleife:
      for Rasse in GlobaleVariablen.EinheitenGebaut'Range (1) loop
         EinheitenSchleife:
         for EinheitNummer in GlobaleVariablen.EinheitenGebaut'Range (2) loop
            
           -- case GlobaleVariablen.EinheitenGebaut (Rasse, EinheitNummer).ID is
              -- when 0 =>
              --    null;
                  
              -- when others =>
                  GlobaleRecords.EinheitenGebautRecord'Write (Stream (File => DateiSpeichernNeu),
                                                              GlobaleVariablen.EinheitenGebaut (Rasse, EinheitNummer));
          --  end case;
            
         end loop EinheitenSchleife;
      end loop EinheitenRassenSchleife;
      -- Schleife zum Speichern der Einheiten



      -- Schleife zum Speichern der Städte
      StadtRassenSchleife:
      for Rasse in GlobaleVariablen.EinheitenGebaut'Range (1) loop
         StadtSchleife:
         for StadtNummer in GlobaleVariablen.EinheitenGebaut'Range (2) loop
            
          --  case GlobaleVariablen.EinheitenGebaut (Rasse, StadtNummer).ID is
           --    when 0 =>
            --      null;
                  
             --  when others =>
                  GlobaleRecords.EinheitenGebautRecord'Write (Stream (File => DateiSpeichernNeu),
                                                              GlobaleVariablen.EinheitenGebaut (Rasse, StadtNummer));
          --  end case;
            
         end loop StadtSchleife;
      end loop StadtRassenSchleife;
      -- Schleife zum Speichern der Städte

      Close (File => DateiSpeichernNeu);
         
      Ladezeiten.Speicherzeiten (2, 1) := Clock;
      Ladezeiten.Speichern (WelcheZeit => 1);
   
   end SpeichernNeu;
   
   

   procedure AutoSpeichern is
   begin
      
      if GlobaleVariablen.RundenAnzahl mod GlobaleVariablen.RundenBisAutosave = 0 then      
         SpeichernNeu (AutoSpeichern => True);
         
      else
         null;
      end if;
      
   end AutoSpeichern;

end Speichern;

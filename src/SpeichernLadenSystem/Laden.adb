with Ada.Strings.UTF_Encoding.Wide_Wide_Strings, Ada.Directories, Ada.Calendar;
use Ada.Strings.UTF_Encoding.Wide_Wide_Strings, Ada.Directories, Ada.Calendar;

with Karten, GlobaleVariablen, Eingabe, Auswahl, Ladezeiten, GlobaleRecords;

package body Laden is

   procedure LadenNeu is
   begin
      
      Ladezeiten.LadenLadezeiten (1, 1) := Clock;

      Open (File => DateiLadenNeu,
            Mode => In_File,
            Name => "Dateien/Spielstand/" & Encode (Item => ("Test")));

      -- Schleife zum Laden der Karte
      EAchseSchleife:
      for EAchse in Karten.Karten'Range (1) loop
         YAchseSchleife:
         for YAchse in Karten.Karten'Range (2) loop
            XAchseSchleife:
            for XAchse in Karten.Karten'Range (3) loop

              -- case Karten.Karten (EAchse, YAchse, XAchse).Grund is
                 -- when -2 =>
                   --  exit YAchseSchleife;
                     
                 -- when -1 =>
                    -- exit XAchseSchleife;

                  --when 0 =>
                    -- exit XAchseSchleife;
                     
                  --when others =>
               GlobaleRecords.KartenRecord'Read (Stream (File => DateiLadenNeu),
                                                 Karten.Karten (EAchse, YAchse, XAchse)); -- Einfach ein (1 ..1, 1 .. 1, 1 .. 1) großes Array mit diesem Datentype anlegen und entsprechen prüfen was der Wert ist?
               --end case;
               
            end loop XAchseSchleife;
         end loop YAchseSchleife;
      end loop EAchseSchleife;
      -- Schleife zum Laden der Karte



      -- Schleife zum Laden der Einheiten
      EinheitenRassenSchleife:
      for Rasse in GlobaleVariablen.EinheitenGebaut'Range (1) loop
         EinheitenSchleife:
         for EinheitNummer in GlobaleVariablen.EinheitenGebaut'Range (2) loop
            
            --case GlobaleVariablen.EinheitenGebaut (Rasse, EinheitNummer).ID is
             --  when 0 =>
               --   null;
                  
               --when others =>
                  GlobaleRecords.EinheitenGebautRecord'Read (Stream (File => DateiLadenNeu),
                                                              GlobaleVariablen.EinheitenGebaut (Rasse, EinheitNummer));
            --end case;
            
         end loop EinheitenSchleife;
      end loop EinheitenRassenSchleife;
      -- Schleife zum Laden der Einheiten



      -- Schleife zum Laden der Städte
      StadtRassenSchleife:
      for Rasse in GlobaleVariablen.EinheitenGebaut'Range (1) loop
         StadtSchleife:
         for StadtNummer in GlobaleVariablen.EinheitenGebaut'Range (2) loop
            
            --case GlobaleVariablen.EinheitenGebaut (Rasse, StadtNummer).ID is
               --when 0 =>
                 -- null;
                  
               --when others =>
                  GlobaleRecords.EinheitenGebautRecord'Read (Stream (File => DateiLadenNeu),
                                                             GlobaleVariablen.EinheitenGebaut (Rasse, StadtNummer));
            --end case;
            
         end loop StadtSchleife;
      end loop StadtRassenSchleife;
      -- Schleife zum Laden der Städte

      Close (File => DateiLadenNeu);

      Ladezeiten.LadenLadezeiten (2, 1) := Clock;
      Ladezeiten.Laden (WelcheZeit => 1);
      
   end LadenNeu;

end Laden;

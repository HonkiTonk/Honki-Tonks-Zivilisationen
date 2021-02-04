with Ada.Strings.UTF_Encoding.Wide_Wide_Strings, Ada.Calendar, Ada.Wide_Wide_Text_IO;
use Ada.Strings.UTF_Encoding.Wide_Wide_Strings, Ada.Calendar;

with Karten, GlobaleVariablen, Ladezeiten, GlobaleRecords, Informationen, Auswahl, Eingabe;

package body Laden is

   procedure LadenNeu is
   begin
      
      SpielstandName := Eingabe.SpielstandName;
      Ladezeiten.LadenLadezeiten (1, 1) := Clock;

      Open (File => DateiLadenNeu,
            Mode => In_File,
            Name => "Dateien/Spielstand/" & Encode (Item => To_Wide_Wide_String (Source => SpielstandName)));

      Wide_Wide_String'Read (Stream (File => DateiLadenNeu),
                             VersionsnummerPrüfung);

      if VersionsnummerPrüfung = Informationen.Versionsnummer then
         null;
         
      else         
         Ada.Wide_Wide_Text_IO.Put_Line ("Falsche Version!"); -- Hier noch eine Fehlermeldung einbauen
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
               Close (File => DateiLadenNeu); -- Hier noch eine Fehlermeldung einbauen
               return;
         end case;
         return;
      end if;

      -- Schleife zum Laden der Karte
      Integer'Read (Stream (File => DateiLadenNeu),
                    Karten.Kartengröße);

      EAchseSchleife:
      for EAchse in Karten.Karten'Range (1) loop
         YAchseSchleife:
         for YAchse in Karten.Karten'First (2) .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße loop
            XAchseSchleife:
            for XAchse in Karten.Karten'First (3) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße loop
               
               GlobaleRecords.KartenRecord'Read (Stream (File => DateiLadenNeu),
                                                 Karten.Karten (EAchse, YAchse, XAchse)); -- Einfach ein (1 ..1, 1 .. 1, 1 .. 1) großes Array mit diesem Datentype anlegen und entsprechen prüfen was der Wert ist?
                              
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

pragma SPARK_Mode (On);

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

      -- Rundenanzahl und Rundenanzahl bis zum Autospeichern speichern
      Positive'Read (Stream (File => DateiLadenNeu),
                     GlobaleVariablen.RundenAnzahl);
      Natural'Read (Stream (File => DateiLadenNeu), -- Das hier später in eine Config schieben
                    GlobaleVariablen.RundenBisAutosave);

      -- Spieler am Zug laden
      GlobaleDatentypen.RassenMitNullwert'Read (Stream (File => DateiLadenNeu),
                                                GlobaleVariablen.RasseAmZugNachLaden);

      -- Schleife zum Laden der Karte
      Positive'Read (Stream (File => DateiLadenNeu),
                     Karten.Kartengröße);

      EAchseSchleife:
      for EAchse in Karten.Karten'Range (1) loop
         YAchseSchleife:
         for YAchse in Karten.Karten'First (2) .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße loop
            XAchseSchleife:
            for XAchse in Karten.Karten'First (3) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße loop
               
               GlobaleRecords.KartenRecord'Read (Stream (File => DateiLadenNeu),
                                                 Karten.Karten (EAchse, YAchse, XAchse));
                              
            end loop XAchseSchleife;
         end loop YAchseSchleife;
      end loop EAchseSchleife;
      -- Schleife zum Laden der Karte



      -- Rassen im Spiel laden
      GlobaleDatentypen.RassenImSpielArray'Read (Stream (File => DateiLadenNeu),
                                                 GlobaleVariablen.RassenImSpiel);
      -- Rassen im Spiel laden



      -- Schleife zum Laden der Einheiten
      EinheitenRassenSchleife:
      for Rasse in GlobaleVariablen.EinheitenGebaut'Range (1) loop

         case GlobaleVariablen.RassenImSpiel (Rasse) is
            when 0 =>
               null;
               
            when others =>
               EinheitenSchleife:
               for EinheitNummer in GlobaleVariablen.EinheitenGebaut'Range (2) loop
            
                  GlobaleRecords.EinheitenGebautRecord'Read (Stream (File => DateiLadenNeu),
                                                             GlobaleVariablen.EinheitenGebaut (Rasse, EinheitNummer));
            
               end loop EinheitenSchleife;
         end case;
         
      end loop EinheitenRassenSchleife;
      -- Schleife zum Laden der Einheiten



      -- Schleife zum Laden der Städte
      StadtRassenSchleife:
      for Rasse in GlobaleVariablen.EinheitenGebaut'Range (1) loop

         case GlobaleVariablen.RassenImSpiel (Rasse) is
            when 0 =>
               null;
               
            when others =>
               StadtSchleife:
               for StadtNummer in GlobaleVariablen.EinheitenGebaut'Range (2) loop
                  
                  GlobaleRecords.EinheitenGebautRecord'Read (Stream (File => DateiLadenNeu),
                                                             GlobaleVariablen.EinheitenGebaut (Rasse, StadtNummer));
            
               end loop StadtSchleife;
         end case;
         
      end loop StadtRassenSchleife;
      -- Schleife zum Laden der Städte



      -- Schleife zum Laden von Wichtiges
      WichtigesSchleife:
      for Rasse in GlobaleVariablen.Wichtiges'Range loop
         
         case GlobaleVariablen.RassenImSpiel (Rasse) is
            when 0 =>
               null;
               
            when others =>
               GlobaleRecords.WichtigesRecord'Read (Stream (File => DateiLadenNeu),
                                                    GlobaleVariablen.Wichtiges (Rasse));
         end case;
         
      end loop WichtigesSchleife;
      -- Schleife zum Laden von Wichtiges



      -- Schleife zum Laden von Diplomatie
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
                        Integer'Read (Stream (File => DateiLadenNeu),
                                      GlobaleVariablen.Diplomatie (Rasse, Rassen));
                  end case;

               end loop DiplomatieSchleifeInnen;
         end case;
               
      end loop DiplomatieSchleifeAußen;
      -- Schleife zum Laden von Diplomatie



      -- Schleife zum Laden der Cursorpositionen
      CursorSchleife:
      for Rasse in GlobaleVariablen.CursorImSpiel'Range loop
         
         case GlobaleVariablen.RassenImSpiel (Rasse) is
            when 0 =>
               null;
               
            when others =>
               GlobaleRecords.CursorRecord'Read (Stream (File => DateiLadenNeu),
                                                 GlobaleVariablen.CursorImSpiel (Rasse));
         end case;
         
      end loop CursorSchleife;
      -- Schleife zum Laden der Cursorpositionen

      Close (File => DateiLadenNeu);

      Ladezeiten.LadenLadezeiten (2, 1) := Clock;
      Ladezeiten.Laden (WelcheZeit => 1);
      
   end LadenNeu;

end Laden;

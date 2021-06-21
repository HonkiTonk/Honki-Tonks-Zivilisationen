pragma SPARK_Mode (On);

with Ada.Strings.UTF_Encoding.Wide_Wide_Strings, Ada.Calendar, Ada.Directories;
use Ada.Strings.UTF_Encoding.Wide_Wide_Strings, Ada.Calendar, Ada.Directories;

with GlobaleDatentypen, GlobaleVariablen, GlobaleRecords;
use GlobaleDatentypen;

with Karten, Ladezeiten, Informationen, Auswahl, Eingabe;

package body Laden is

   function LadenNeu
     return Boolean
   is begin
      
      SpielstandName := Eingabe.SpielstandName;

      case
        Exists (Name => "Spielstand/" & Encode (Item => To_Wide_Wide_String (Source => SpielstandName)))
      is -- Anzeige der vorhandenen Spielstände einbauen
         when True =>
            null;

         when False =>
            return False;
      end case;
      Ladezeiten.EinzelneZeiten (4, 1) := Clock;

      Open (File => DateiLadenNeu,
            Mode => In_File,
            Name => "Spielstand/" & Encode (Item => To_Wide_Wide_String (Source => SpielstandName)));

      -- Versionsnummer laden
      Wide_Wide_String'Read (Stream (File => DateiLadenNeu),
                             VersionsnummerPrüfung);
      -- Versionsnummer laden

      if
        VersionsnummerPrüfung = Informationen.Versionsnummer
      then
         null;
         
      else -- Falsche Versionsnummer
         case
           Auswahl.AuswahlJaNein (FrageZeileExtern => 24)
         is
            when -3 =>
               null;
                     
            when others =>
               Close (File => DateiLadenNeu); -- Hier noch eine Fehlermeldung einbauen
               return False;
         end case;
      end if;

      -- Rundenanzahl laden
      Positive'Read (Stream (File => DateiLadenNeu),
                     GlobaleVariablen.RundenAnzahl);
      -- Rundenanzahl laden

      -- Spieler am Zug laden
      GlobaleDatentypen.RassenMitNullwert'Read (Stream (File => DateiLadenNeu),
                                                GlobaleVariablen.RasseAmZugNachLaden);
      -- Spieler am Zug laden

      -- Schleife zum Laden der Karte
      Positive'Read (Stream (File => DateiLadenNeu),
                     Karten.Kartengröße);

      EAchseSchleife:
      for EAchseSchleifenwert in Karten.WeltkarteArray'Range (1) loop
         YAchseSchleife:
         for YAchseSchleifenwert in Karten.WeltkarteArray'First (2) .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße loop
            XAchseSchleife:
            for XAchseSchleifenwert in Karten.WeltkarteArray'First (3) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße loop
               
               GlobaleRecords.KartenRecord'Read (Stream (File => DateiLadenNeu),
                                                 Karten.Weltkarte (EAchseSchleifenwert, YAchseSchleifenwert, XAchseSchleifenwert));
                              
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
      for RasseEinheitenSchleifenwert in GlobaleVariablen.EinheitenGebautArray'Range (1) loop

         case
           GlobaleVariablen.RassenImSpiel (RasseEinheitenSchleifenwert)
         is
            when 0 =>
               null;
               
            when others =>
               EinheitenSchleife:
               for EinheitNummerSchleifenwert in GlobaleVariablen.EinheitenGebautArray'Range (2) loop
            
                  GlobaleRecords.EinheitenGebautRecord'Read (Stream (File => DateiLadenNeu),
                                                             GlobaleVariablen.EinheitenGebaut (RasseEinheitenSchleifenwert, EinheitNummerSchleifenwert));
            
               end loop EinheitenSchleife;
         end case;
         
      end loop EinheitenRassenSchleife;
      -- Schleife zum Laden der Einheiten



      -- Schleife zum Laden der Städte
      StadtRassenSchleife:
      for RasseStadtSchleifenwert in GlobaleVariablen.EinheitenGebautArray'Range (1) loop

         case
           GlobaleVariablen.RassenImSpiel (RasseStadtSchleifenwert)
         is
            when 0 =>
               null;
               
            when others =>
               StadtSchleife:
               for StadtNummerSchleifenwert in GlobaleVariablen.EinheitenGebautArray'Range (2) loop
                  
                  GlobaleRecords.EinheitenGebautRecord'Read (Stream (File => DateiLadenNeu),
                                                             GlobaleVariablen.EinheitenGebaut (RasseStadtSchleifenwert, StadtNummerSchleifenwert));
            
               end loop StadtSchleife;
         end case;
         
      end loop StadtRassenSchleife;
      -- Schleife zum Laden der Städte



      -- Schleife zum Laden von Wichtiges
      WichtigesSchleife:
      for RasseWichtigesSchleifenwert in GlobaleVariablen.WichtigesArray'Range loop
         
         case
           GlobaleVariablen.RassenImSpiel (RasseWichtigesSchleifenwert)
         is
            when 0 =>
               null;
               
            when others =>
               GlobaleRecords.WichtigesRecord'Read (Stream (File => DateiLadenNeu),
                                                    GlobaleVariablen.Wichtiges (RasseWichtigesSchleifenwert));
         end case;
         
      end loop WichtigesSchleife;
      -- Schleife zum Laden von Wichtiges



      -- Schleife zum Laden von Diplomatie
      DiplomatieSchleifeAußen:
      for RasseDiplomatieEinsSchleifenwert in GlobaleVariablen.DiplomatieArray'Range (1) loop
         
         case
           GlobaleVariablen.RassenImSpiel (RasseDiplomatieEinsSchleifenwert)
         is
            when 0 =>
               null;

            when others =>               
               DiplomatieSchleifeInnen:
               for RasseDiplomatieZweiSchleifenwert in GlobaleVariablen.DiplomatieArray'Range (2) loop

                  case
                    GlobaleVariablen.RassenImSpiel (RasseDiplomatieZweiSchleifenwert)
                  is
                     when 0 =>
                        null;
                     
                     when others =>
                        GlobaleDatentypen.StatusUntereinander'Read (Stream (File => DateiLadenNeu),
                                                                    GlobaleVariablen.Diplomatie (RasseDiplomatieEinsSchleifenwert, RasseDiplomatieZweiSchleifenwert));
                  end case;

               end loop DiplomatieSchleifeInnen;
         end case;
               
      end loop DiplomatieSchleifeAußen;
      -- Schleife zum Laden von Diplomatie



      -- Schleife zum Laden der Cursorpositionen
      CursorSchleife:
      for RasseCursorSchleifenwert in GlobaleVariablen.CursorImSpielArray'Range loop
         
         case
           GlobaleVariablen.RassenImSpiel (RasseCursorSchleifenwert)
         is
            when 0 =>
               null;
               
            when others =>
               GlobaleRecords.CursorRecord'Read (Stream (File => DateiLadenNeu),
                                                 GlobaleVariablen.CursorImSpiel (RasseCursorSchleifenwert));
         end case;
         
      end loop CursorSchleife;
      -- Schleife zum Laden der Cursorpositionen

      Close (File => DateiLadenNeu);

      Ladezeiten.EinzelneZeiten (4, 2) := Clock;
      Ladezeiten.AnzeigeEinzelneZeit (WelcheZeitExtern => 4);

      return True;
      
   end LadenNeu;

end Laden;

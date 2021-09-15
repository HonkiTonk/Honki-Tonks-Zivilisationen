pragma SPARK_Mode (On);

with Ada.Strings.UTF_Encoding.Wide_Wide_Strings, Ada.Calendar, Ada.Directories;
use Ada.Strings.UTF_Encoding.Wide_Wide_Strings, Ada.Calendar, Ada.Directories;

with GlobaleDatentypen, GlobaleVariablen, GlobaleRecords, GlobaleKonstanten;
use GlobaleDatentypen;

with Karten, Ladezeiten, Informationen, Auswahl, Eingabe;

package body Laden is

   function LadenNeu
     return Boolean
   is begin
      
      case
        SpielstandNameErmitteln
      is
         when True =>
            null;
            
         when False =>
            return False;
      end case;
      
      Ladezeiten.EinzelneZeiten (Ladezeiten.Ladezeit, GlobaleDatentypen.Anfangswert) := Clock;

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
            when GlobaleKonstanten.JaKonstante =>
               null;
                     
            when others =>
               -- Hier noch eine Fehlermeldung einbauen
               Close (File => DateiLadenNeu);
               return False;
         end case;
      end if;
      
      -- Ironmanmodus speichern
      Unbounded_Wide_Wide_String'Read (Stream (File => DateiLadenNeu), 
                                       GlobaleVariablen.IronmanName);
      -- Ironmanmodus speichern
      
      

      -- Rundenanzahl und Grenze laden
      Positive'Read (Stream (File => DateiLadenNeu),
                     GlobaleVariablen.RundenAnzahl);
      
      Natural'Read (Stream (File => DateiLadenNeu),
                    GlobaleVariablen.Rundengrenze);
      -- Rundenanzahl und Grenze laden
      
      

      -- Spieler am Zug laden
      GlobaleDatentypen.Rassen_Enum'Read (Stream (File => DateiLadenNeu),
                                          GlobaleVariablen.RasseAmZugNachLaden);
      -- Spieler am Zug laden
      
      
      
      -- Schwierigkeitsgrad laden
      GlobaleDatentypen.Schwierigkeitsgrad_Verwendet_Enum'Read (Stream (File => DateiLadenNeu),
                                                                GlobaleVariablen.Schwierigkeitsgrad);
      -- Schwierigkeitsgrad laden
      
      
      
      -- Gewonnen laden
      Boolean'Read (Stream (File => DateiLadenNeu),
                    GlobaleVariablen.Gewonnen);
      -- Gewonnen laden
      
      

      -- Schleife zum Laden der Karte      
      GlobaleDatentypen.Kartentemperatur_Verwendet_Enum'Read (Stream (File => DateiLadenNeu),
                                                              Karten.Kartentemperatur);
      
      GlobaleDatentypen.Kartenform_Verwendet_Enum'Read (Stream (File => DateiLadenNeu),
                                                        Karten.Kartenform);
      
      GlobaleDatentypen.Kartengröße_Verwendet_Enum'Read (Stream (File => DateiLadenNeu),
                                                           Karten.Kartengröße);
      
      case
        Karten.Kartengröße
      is
         when GlobaleDatentypen.Karte_Nutzer =>
            Karten.KartengrößenRecord'Read (Stream (File => DateiLadenNeu),
                                              Karten.Kartengrößen (GlobaleDatentypen.Karte_Nutzer));
            
         when others =>
            null;
      end case;

      EAchseBisBodenSchleife:
      for EAchseSchleifenwert in Karten.WeltkarteArray'Range (1) loop
         YAchseBisBodenSchleife:
         for YAchseSchleifenwert in Karten.WeltkarteArray'First (2) .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße loop
            XAchseBisBodenSchleife:
            for XAchseSchleifenwert in Karten.WeltkarteArray'First (3) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße loop

               GlobaleRecords.KartenRecord'Read (Stream (File => DateiLadenNeu),
                                                 Karten.Weltkarte (EAchseSchleifenwert, YAchseSchleifenwert, XAchseSchleifenwert));
               
            end loop XAchseBisBodenSchleife;
         end loop YAchseBisBodenSchleife;
      end loop EAchseBisBodenSchleife;
      -- Schleife zum Laden der Karte



      -- Rassen und Rassengrenzen laden
      GlobaleDatentypen.RassenImSpielArray'Read (Stream (File => DateiLadenNeu),
                                                 GlobaleVariablen.RassenImSpiel);
      
      GrenzenRassenSchleife:
      for GrenzenRassenSchleifenwert in GlobaleDatentypen.Rassen_Verwendet_Enum'Range loop
         
         GlobaleRecords.GrenzenRecord'Read (Stream (File => DateiLadenNeu),
                                            GlobaleVariablen.Grenzen (GrenzenRassenSchleifenwert));
         
      end loop GrenzenRassenSchleife;
      -- Rassen und Rassengrenzen laden



      -- Schleife zum Laden der Einheiten
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
            
                  GlobaleRecords.EinheitenGebautRecord'Read (Stream (File => DateiLadenNeu),
                                                             GlobaleVariablen.EinheitenGebaut (RasseEinheitenSchleifenwert, EinheitNummerSchleifenwert));
            
               end loop EinheitenSchleife;
         end case;
         
      end loop EinheitenRassenSchleife;
      -- Schleife zum Laden der Einheiten



      -- Schleife zum Laden der Städte
      StadtRassenSchleife:
      for RasseStadtSchleifenwert in GlobaleVariablen.StadtGebautArray'Range (1) loop

         case
           GlobaleVariablen.RassenImSpiel (RasseStadtSchleifenwert)
         is
            when GlobaleDatentypen.Leer =>
               null;
               
            when others =>
               StadtSchleife:
               for StadtNummerSchleifenwert in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (RasseStadtSchleifenwert).Städtegrenze loop
                  
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
            when GlobaleDatentypen.Leer =>
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
                        GlobaleRecords.DiplomatieRecord'Read (Stream (File => DateiLadenNeu),
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
            when GlobaleDatentypen.Leer =>
               null;
               
            when others =>
               GlobaleRecords.CursorRecord'Read (Stream (File => DateiLadenNeu),
                                                 GlobaleVariablen.CursorImSpiel (RasseCursorSchleifenwert));
         end case;
         
      end loop CursorSchleife;
      -- Schleife zum Laden der Cursorpositionen

      Close (File => DateiLadenNeu);

      Ladezeiten.EinzelneZeiten (Ladezeiten.Ladezeit, GlobaleDatentypen.Endwert) := Clock;
      Ladezeiten.AnzeigeEinzelneZeit (WelcheZeitExtern => Ladezeiten.Ladezeit);

      return True;
      
   end LadenNeu;
   
   
   
   function SpielstandNameErmitteln
     return Boolean
   is begin
      
      SpielstandName := Eingabe.SpielstandName;

      return Exists (Name => "Spielstand/" & Encode (Item => To_Wide_Wide_String (Source => SpielstandName)));
      
   end SpielstandNameErmitteln;

end Laden;

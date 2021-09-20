pragma SPARK_Mode (On);

with Ada.Strings.UTF_Encoding.Wide_Wide_Strings, Ada.Calendar, Ada.Strings.Wide_Wide_Unbounded;
use Ada.Strings.UTF_Encoding.Wide_Wide_Strings, Ada.Calendar, Ada.Strings.Wide_Wide_Unbounded;

with GlobaleDatentypen, GlobaleVariablen, GlobaleRecords, GlobaleKonstanten;
use GlobaleDatentypen;

with Karten, Ladezeiten, Informationen, Auswahl, SpeichernLadenAllgemein;

package body Laden is

   function LadenNeu
     return Boolean
   is begin
      
      case
        SpeichernLadenAllgemein.SpielstandNameErmitteln
      is
         when True =>
            null;
            
         when False =>
            return False;
      end case;
      
      Ladezeiten.EinzelneZeiten (Ladezeiten.Ladezeit, GlobaleDatentypen.Anfangswert) := Clock;

      Open (File => DateiLadenNeu,
            Mode => In_File,
            Name => "Spielstand/" & Encode (Item => To_Wide_Wide_String (Source => SpeichernLadenAllgemein.SpielstandName)));

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
      
      SonstigesLaden;
      KarteLaden;
      RassenGrenzenLaden;
      EinheitenLaden;
      StädteLaden;
      WichtigesLaden;
      DiplomatieLaden;
      CursorLaden;

      Close (File => DateiLadenNeu);

      Ladezeiten.EinzelneZeiten (Ladezeiten.Ladezeit, GlobaleDatentypen.Endwert) := Clock;
      Ladezeiten.AnzeigeEinzelneZeit (WelcheZeitExtern => Ladezeiten.Ladezeit);

      return True;
      
   end LadenNeu;
   
   
   
   procedure SonstigesLaden
   is begin
      
      Unbounded_Wide_Wide_String'Read (Stream (File => DateiLadenNeu),
                                       GlobaleVariablen.IronmanName);

      Positive'Read (Stream (File => DateiLadenNeu),
                     GlobaleVariablen.RundenAnzahl);
      
      Natural'Read (Stream (File => DateiLadenNeu),
                    GlobaleVariablen.Rundengrenze);
      
      GlobaleDatentypen.Rassen_Enum'Read (Stream (File => DateiLadenNeu),
                                          GlobaleVariablen.RasseAmZugNachLaden);
      
      GlobaleDatentypen.Schwierigkeitsgrad_Verwendet_Enum'Read (Stream (File => DateiLadenNeu),
                                                                GlobaleVariablen.Schwierigkeitsgrad);
      
      Boolean'Read (Stream (File => DateiLadenNeu),
                    GlobaleVariablen.Gewonnen);
      
      Boolean'Read (Stream (File => DateiLadenNeu),
                     GlobaleVariablen.WeiterSpielen);
      
   end SonstigesLaden;
   
   
   
   procedure KarteLaden
   is begin
      
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
      
   end KarteLaden;
   
   
   
   procedure RassenGrenzenLaden
   is begin
      
      GlobaleDatentypen.RassenImSpielArray'Read (Stream (File => DateiLadenNeu),
                                                 GlobaleVariablen.RassenImSpiel);
      
      GrenzenRassenSchleife:
      for GrenzenRassenSchleifenwert in GlobaleDatentypen.Rassen_Verwendet_Enum'Range loop
         
         GlobaleRecords.GrenzenRecord'Read (Stream (File => DateiLadenNeu),
                                            GlobaleVariablen.Grenzen (GrenzenRassenSchleifenwert));
         
      end loop GrenzenRassenSchleife;
      
   end RassenGrenzenLaden;
   
   
   
   procedure EinheitenLaden
   is begin
      
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
      
   end EinheitenLaden;
   
   
   
   procedure StädteLaden
   is begin
      
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
      
   end StädteLaden;
   
   
   
   procedure WichtigesLaden
   is begin
      
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
      
   end WichtigesLaden;
   
   
   
   procedure DiplomatieLaden
   is begin
      
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
      
   end DiplomatieLaden;
   
   
   
   procedure CursorLaden
   is begin
      
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
      
   end CursorLaden;

end Laden;

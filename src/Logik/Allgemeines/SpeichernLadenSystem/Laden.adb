pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Strings.UTF_Encoding.Wide_Wide_Strings; use Ada.Strings.UTF_Encoding.Wide_Wide_Strings;
with Ada.Calendar; use Ada.Calendar;
with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with SystemDatentypen;
with GlobaleVariablen;
with KartenRecords;
with StadtRecords;
with WichtigeRecords;
with KartenDatentypen;
with SonstigesKonstanten;
with RassenDatentypen;
with SpielDatentypen;
with SpielVariablen;
with SonstigeVariablen;
with EinheitenRecords;

with Karten;
with Ladezeiten;
with LadezeitenDatentypen;
with Auswahl;
with SpeichernLadenAllgemein;

package body Laden is
   
   ------------------------ Beim Neubauen auch alle neuen Nutzereinstellmöglichkeiten mit laden und eventuelle berechneten Werte die jetzt notwendig sind mitnehmen.

   function LadenNeu
     return Boolean
   is begin
      
      NameSpielstand := SpeichernLadenAllgemein.SpielstandNameErmitteln;
      
      case
        NameSpielstand.ErfolgreichAbbruch
      is
         when True =>
            null;
            
         when False =>
            return False;
      end case;
      
      LadezeitenDatentypen.EinzelneZeiten (LadezeitenDatentypen.Ladezeit_Enum, SystemDatentypen.Anfangswert_Enum) := Clock;

      Open (File => DateiLadenNeu,
            Mode => In_File,
            Name => "Spielstand/" & Encode (Item => To_Wide_Wide_String (Source => NameSpielstand.EingegebenerText)));

      -- Versionsnummer laden
      Wide_Wide_String'Read (Stream (File => DateiLadenNeu),
                             VersionsnummerPrüfung);
      -- Versionsnummer laden

      if
        VersionsnummerPrüfung = SonstigesKonstanten.Versionsnummer
      then
         null;
         
      else -- Falsche Versionsnummer
         case
           Auswahl.AuswahlJaNein (FrageZeileExtern => 24)
         is
            -- when RueckgabeDatentypen.Ja_Enum =>
            --    null;
                     
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

      LadezeitenDatentypen.EinzelneZeiten (LadezeitenDatentypen.Ladezeit_Enum, SystemDatentypen.Endwert_Enum) := Clock;
      Ladezeiten.AnzeigeEinzelneZeit (WelcheZeitExtern => LadezeitenDatentypen.Ladezeit_Enum);

      return True;
      
   end LadenNeu;
   
   
   
   procedure SonstigesLaden
   is begin
      
      Unbounded_Wide_Wide_String'Read (Stream (File => DateiLadenNeu),
                                       SpielVariablen.IronmanName);

      Positive'Read (Stream (File => DateiLadenNeu),
                     SpielVariablen.RundenAnzahl);
      
      Natural'Read (Stream (File => DateiLadenNeu),
                    SpielVariablen.Rundengrenze);
      
      RassenDatentypen.Rassen_Enum'Read (Stream (File => DateiLadenNeu),
                                         SonstigeVariablen.RasseAmZugNachLaden);
      
      SpielDatentypen.Schwierigkeitsgrad_Enum'Read (Stream (File => DateiLadenNeu),
                                                    SpielVariablen.Schwierigkeitsgrad);
      
      Boolean'Read (Stream (File => DateiLadenNeu),
                    SonstigeVariablen.Gewonnen);
      
      Boolean'Read (Stream (File => DateiLadenNeu),
                    SonstigeVariablen.WeiterSpielen);
      
   end SonstigesLaden;
   
   
   
   procedure KarteLaden
   is begin
      
      -- KartenDatentypen.Kartenform_Verwendet_Enum'Read (Stream (File => DateiLadenNeu),
      --                                                 Karten.Kartenform);
      KartenDatentypen.Kartengröße_Enum'Read (Stream (File => DateiLadenNeu),
                                                Karten.Kartenparameter.Kartengröße);
      
      case
        Karten.Kartenparameter.Kartengröße
      is
         when KartenDatentypen.Kartengröße_Nutzer_Enum =>
            KartenRecords.YXAchsenKartenfeldPositivRecord'Read (Stream (File => DateiLadenNeu),
                                                                Karten.Kartengrößen (KartenDatentypen.Kartengröße_Nutzer_Enum));
            
         when others =>
            null;
      end case;

      EAchseBisBodenSchleife:
      for EAchseSchleifenwert in Karten.WeltkarteArray'Range (1) loop
         YAchseBisBodenSchleife:
         for YAchseSchleifenwert in Karten.WeltkarteArray'First (2) .. Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse loop
            XAchseBisBodenSchleife:
            for XAchseSchleifenwert in Karten.WeltkarteArray'First (3) .. Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchse loop

               KartenRecords.KartenRecord'Read (Stream (File => DateiLadenNeu),
                                                Karten.Weltkarte (EAchseSchleifenwert, YAchseSchleifenwert, XAchseSchleifenwert));
               
            end loop XAchseBisBodenSchleife;
         end loop YAchseBisBodenSchleife;
      end loop EAchseBisBodenSchleife;
      
   end KarteLaden;
   
   
   
   procedure RassenGrenzenLaden
   is begin
      
      RassenDatentypen.RassenImSpielArray'Read (Stream (File => DateiLadenNeu),
                                                SonstigeVariablen.RassenImSpiel);
      
      GrenzenRassenSchleife:
      for GrenzenRassenSchleifenwert in RassenDatentypen.Rassen_Verwendet_Enum'Range loop
         
         WichtigeRecords.GrenzenRecord'Read (Stream (File => DateiLadenNeu),
                                             SpielVariablen.Grenzen (GrenzenRassenSchleifenwert));
         
      end loop GrenzenRassenSchleife;
      
   end RassenGrenzenLaden;
   
   
   
   procedure EinheitenLaden
   is begin
      
      EinheitenRassenSchleife:
      for RasseEinheitenSchleifenwert in SpielVariablen.EinheitenGebautArray'Range (1) loop

         case
           SonstigeVariablen.RassenImSpiel (RasseEinheitenSchleifenwert)
         is
            when RassenDatentypen.Leer_Spieler_Enum =>
               null;
               
            when others =>
               EinheitenSchleife:
               for EinheitNummerSchleifenwert in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (RasseEinheitenSchleifenwert).Einheitengrenze loop
            
                  EinheitenRecords.EinheitenGebautRecord'Read (Stream (File => DateiLadenNeu),
                                                                  SpielVariablen.EinheitenGebaut (RasseEinheitenSchleifenwert, EinheitNummerSchleifenwert));
            
               end loop EinheitenSchleife;
         end case;
         
      end loop EinheitenRassenSchleife;
      
   end EinheitenLaden;
   
   
   
   procedure StädteLaden
   is begin
      
      StadtRassenSchleife:
      for RasseStadtSchleifenwert in SpielVariablen.StadtGebautArray'Range (1) loop

         case
           SonstigeVariablen.RassenImSpiel (RasseStadtSchleifenwert)
         is
            when RassenDatentypen.Leer_Spieler_Enum =>
               null;
               
            when others =>
               StadtSchleife:
               for StadtNummerSchleifenwert in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (RasseStadtSchleifenwert).Städtegrenze loop
                  
                  StadtRecords.StadtGebautRecord'Read (Stream (File => DateiLadenNeu),
                                                              SpielVariablen.StadtGebaut (RasseStadtSchleifenwert, StadtNummerSchleifenwert));
            
               end loop StadtSchleife;
         end case;
         
      end loop StadtRassenSchleife;
      
   end StädteLaden;
   
   
   
   procedure WichtigesLaden
   is begin
      
      WichtigesSchleife:
      for RasseWichtigesSchleifenwert in SpielVariablen.WichtigesArray'Range loop
         
         case
           SonstigeVariablen.RassenImSpiel (RasseWichtigesSchleifenwert)
         is
            when RassenDatentypen.Leer_Spieler_Enum =>
               null;
               
            when others =>
               WichtigeRecords.WichtigesRecord'Read (Stream (File => DateiLadenNeu),
                                                     SpielVariablen.Wichtiges (RasseWichtigesSchleifenwert));
         end case;
         
      end loop WichtigesSchleife;
      
   end WichtigesLaden;
   
   
   
   procedure DiplomatieLaden
   is begin
      
      DiplomatieSchleifeAußen:
      for RasseDiplomatieEinsSchleifenwert in SpielVariablen.DiplomatieArray'Range (1) loop
         
         case
           SonstigeVariablen.RassenImSpiel (RasseDiplomatieEinsSchleifenwert)
         is
            when RassenDatentypen.Leer_Spieler_Enum =>
               null;

            when others =>
               DiplomatieSchleifeInnen:
               for RasseDiplomatieZweiSchleifenwert in SpielVariablen.DiplomatieArray'Range (2) loop

                  case
                    SonstigeVariablen.RassenImSpiel (RasseDiplomatieZweiSchleifenwert)
                  is
                     when RassenDatentypen.Leer_Spieler_Enum =>
                        null;
                     
                     when others =>
                        WichtigeRecords.DiplomatieRecord'Read (Stream (File => DateiLadenNeu),
                                                               SpielVariablen.Diplomatie (RasseDiplomatieEinsSchleifenwert, RasseDiplomatieZweiSchleifenwert));
                  end case;

               end loop DiplomatieSchleifeInnen;
         end case;
               
      end loop DiplomatieSchleifeAußen;
      
   end DiplomatieLaden;
   
   
   
   procedure CursorLaden
   is begin
      
      CursorSchleife:
      for RasseCursorSchleifenwert in SpielVariablen.CursorImSpielArray'Range loop
         
         case
           SonstigeVariablen.RassenImSpiel (RasseCursorSchleifenwert)
         is
            when RassenDatentypen.Leer_Spieler_Enum =>
               null;
               
            when others =>
               KartenRecords.CursorRecord'Read (Stream (File => DateiLadenNeu),
                                                SpielVariablen.CursorImSpiel (RasseCursorSchleifenwert));
         end case;
         
      end loop CursorSchleife;
      
   end CursorLaden;

end Laden;

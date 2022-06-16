pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Strings.UTF_Encoding.Wide_Wide_Strings; use Ada.Strings.UTF_Encoding.Wide_Wide_Strings;
with Ada.Calendar; use Ada.Calendar;
with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with RueckgabeDatentypen;
with SystemDatentypen;
with GlobaleVariablen;
with KartenRecords;
with StadtRecords;
with WichtigeRecords;
with KartenDatentypen;
with RassenDatentypen;
with SpielDatentypen;
with SpielVariablen;
with SonstigeVariablen;
with EinheitenRecords;
with TextKonstanten;
with GrafikDatentypen;

with Karten;
with Ladezeiten;
with Auswahl;
with SpeichernLadenAllgemein;
with InteraktionGrafiktask;

package body Laden is
   
   ------------------------ Beim Neubauen auch alle neuen Nutzereinstellmöglichkeiten mit laden und eventuelle berechneten Werte die jetzt notwendig sind mitnehmen.

   function LadenNeu
     return Boolean
   is begin
      
      NameSpielstand := SpeichernLadenAllgemein.SpielstandNameErmitteln;
      
      case
        NameSpielstand.ErfolgreichAbbruch
      is
         when False =>
            return False;
            
         when True =>
            null;
      end case;
      
      Open (File => DateiLadenNeu,
            Mode => In_File,
            Name => "Spielstand/" & Encode (Item => To_Wide_Wide_String (Source => NameSpielstand.EingegebenerText)));

      -- Versionsnummer laden
      Wide_Wide_String'Read (Stream (File => DateiLadenNeu),
                             VersionsnummerPrüfung);
      -- Versionsnummer laden

      -- Prüfung auf gleiche Versionsnummer
      if
        VersionsnummerPrüfung = SonstigesKonstanten.Versionsnummer
      then
         null;
         
      else
         case
           Auswahl.AuswahlJaNein (FrageZeileExtern => TextKonstanten.FrageLadeFalscheVersion)
         is
            when RueckgabeDatentypen.Ja_Enum =>
               null;
               
            when others =>
               Close (File => DateiLadenNeu);
               return False;
         end case;
      end if;
      
      Ladezeiten.SpeichernLadenNullsetzen;
      Ladezeiten.SpeichernLaden (SystemDatentypen.Anfangswert_Enum) := Clock;
      InteraktionGrafiktask.AktuelleDarstellung := GrafikDatentypen.Grafik_Speichern_Laden_Enum;
      
      SonstigesLaden;
      Ladezeiten.SpeichernLadenSchreiben (SpeichernLadenExtern => False);
      
      KarteLaden;
      Ladezeiten.SpeichernLadenSchreiben (SpeichernLadenExtern => False);
      
      RassenGrenzenLaden;
      Ladezeiten.SpeichernLadenSchreiben (SpeichernLadenExtern => False);
      
      EinheitenLaden;
      Ladezeiten.SpeichernLadenSchreiben (SpeichernLadenExtern => False);
      
      StädteLaden;
      Ladezeiten.SpeichernLadenSchreiben (SpeichernLadenExtern => False);
      
      WichtigesLaden;
      Ladezeiten.SpeichernLadenSchreiben (SpeichernLadenExtern => False);
      
      DiplomatieLaden;
      Ladezeiten.SpeichernLadenSchreiben (SpeichernLadenExtern => False);
      
      CursorLaden;
      Ladezeiten.SpeichernLadenSchreiben (SpeichernLadenExtern => False);
      
      Close (File => DateiLadenNeu);
      
      Ladezeiten.SpeichernLadenMaximum;
      InteraktionGrafiktask.AktuelleDarstellung := GrafikDatentypen.Grafik_Pause_Enum;
      Ladezeiten.SpeichernLaden (SystemDatentypen.Endwert_Enum) := Clock;

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
               for StadtNummerSchleifenwert in SpielVariablen.StadtGebautArray'First (2) .. SpielVariablen.Grenzen (RasseStadtSchleifenwert).Städtegrenze loop
                  
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

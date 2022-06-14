pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Strings.UTF_Encoding.Wide_Wide_Strings; use Ada.Strings.UTF_Encoding.Wide_Wide_Strings;
-- with Ada.Calendar; use Ada.Calendar;
with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

-- with SystemDatentypen; use SystemDatentypen;
with RueckgabeDatentypen; use RueckgabeDatentypen;
with RassenDatentypen;
with SpielVariablen;
with KartenRecords;
with StadtRecords;
with WichtigeRecords;
with SonstigesKonstanten;
with KartenDatentypen;
with TextKonstanten;
with SpielDatentypen;
with OptionenVariablen;
with SonstigeVariablen;
with EinheitenRecords;

with Karten;
with Auswahl;
-- with Ladezeiten;
with SpeichernLadenAllgemein;
-- with LadezeitenDatentypen;

package body Speichern is

   ------------------------ Beim Neubauen auch alles neuen Nutzereinstellmöglichkeiten mit speichern und eventuelle berechneten Werte die jetzt notwendig sind mitnehmen.
   
   procedure SpeichernNeu
     (AutospeichernExtern : in Boolean)
   is begin

      NameSpielstand := SpielstandNameFestlegen (AutospeichernExtern => AutospeichernExtern);
      
      case
        NameSpielstand.ErfolgreichAbbruch
      is
         when False =>
            return;
              
         when True =>
            null;
      end case;

      -- LadezeitenDatentypen.EinzelneZeiten (LadezeitenDatentypen.Speicherzeit_Enum, SystemDatentypen.Anfangswert_Enum) := Clock;
      
      Create (File => DateiSpeichernNeu,
              Mode => Out_File,
              Name => "Spielstand/" & Encode (Item => (To_Wide_Wide_String (Source => NameSpielstand.EingegebenerText))));
      
      SonstigesSpeichern;
      KarteSpeichern;
      RassenGrenzenSpeichern;
      EinheitenSpeichern;
      StädteSpeichern;
      WichtigesSpeichern;
      DiplomatieSpeichern;
      CursorSpeichern;
      
      Close (File => DateiSpeichernNeu);
         
      -- LadezeitenDatentypen.EinzelneZeiten (LadezeitenDatentypen.Speicherzeit_Enum, SystemDatentypen.Endwert_Enum) := Clock;
      
      -- case
      --  AutospeichernExtern
     -- is
      --   when True =>
       --     Ladezeiten.AnzeigeEinzelneZeitOhneWarten (WelcheZeitExtern => LadezeitenDatentypen.Speicherzeit_Enum);
            
      --   when False =>
      --      Ladezeiten.AnzeigeEinzelneZeit (WelcheZeitExtern => LadezeitenDatentypen.Speicherzeit_Enum);
     -- end case;
   
   end SpeichernNeu;
   
   
   
   procedure SonstigesSpeichern
   is begin
      
      Wide_Wide_String'Write (Stream (File => DateiSpeichernNeu),
                              SonstigesKonstanten.Versionsnummer);
      
      Unbounded_Wide_Wide_String'Write (Stream (File => DateiSpeichernNeu),
                                        SpielVariablen.IronmanName);
      
      Positive'Write (Stream (File => DateiSpeichernNeu),
                      SpielVariablen.RundenAnzahl);
      
      Natural'Write (Stream (File => DateiSpeichernNeu),
                     SpielVariablen.Rundengrenze);
      
      RassenDatentypen.Rassen_Enum'Write (Stream (File => DateiSpeichernNeu),
                                          SonstigeVariablen.RasseAmZugNachLaden);
      
      SpielDatentypen.Schwierigkeitsgrad_Enum'Write (Stream (File => DateiSpeichernNeu),
                                                     SpielVariablen.Schwierigkeitsgrad);
      
      Boolean'Write (Stream (File => DateiSpeichernNeu),
                     SonstigeVariablen.Gewonnen);
      
      Boolean'Write (Stream (File => DateiSpeichernNeu),
                     SonstigeVariablen.WeiterSpielen);
      
   end SonstigesSpeichern;
   
   
   
   procedure KarteSpeichern
   is begin
      
      --  KartenDatentypen.Kartenform_Verwendet_Enum'Write (Stream (File => DateiSpeichernNeu),
      --                                                  Karten.Kartenform);
      KartenDatentypen.Kartengröße_Enum'Write (Stream (File => DateiSpeichernNeu),
                                                 Karten.Kartenparameter.Kartengröße);
      
      case
        Karten.Kartenparameter.Kartengröße
      is
         when KartenDatentypen.Kartengröße_Nutzer_Enum =>
            KartenRecords.YXAchsenKartenfeldPositivRecord'Write (Stream (File => DateiSpeichernNeu),
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

               KartenRecords.KartenRecord'Write (Stream (File => DateiSpeichernNeu),
                                                 Karten.Weltkarte (EAchseSchleifenwert, YAchseSchleifenwert, XAchseSchleifenwert));
               
            end loop XAchseBisBodenSchleife;
         end loop YAchseBisBodenSchleife;
      end loop EAchseBisBodenSchleife;
      
   end KarteSpeichern;
   
   
   
   procedure RassenGrenzenSpeichern
   is begin
      
      RassenDatentypen.RassenImSpielArray'Write (Stream (File => DateiSpeichernNeu),
                                                 SonstigeVariablen.RassenImSpiel);
      
      GrenzenRassenSchleife:
      for GrenzenRassenSchleifenwert in RassenDatentypen.Rassen_Verwendet_Enum'Range loop
         
         WichtigeRecords.GrenzenRecord'Write (Stream (File => DateiSpeichernNeu),
                                              SpielVariablen.Grenzen (GrenzenRassenSchleifenwert));
         
      end loop GrenzenRassenSchleife;
      
   end RassenGrenzenSpeichern;
   
   
   
   procedure EinheitenSpeichern
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
                  
                  EinheitenRecords.EinheitenGebautRecord'Write (Stream (File => DateiSpeichernNeu),
                                                                   SpielVariablen.EinheitenGebaut (RasseEinheitenSchleifenwert, EinheitNummerSchleifenwert));
            
               end loop EinheitenSchleife;
         end case;
         
      end loop EinheitenRassenSchleife;
      
   end EinheitenSpeichern;
   
   
   
   procedure StädteSpeichern
   is begin
      
      StadtRassenSchleife:
      for RasseStadtSchleifenwert in SpielVariablen.EinheitenGebautArray'Range (1) loop
         
         case
           SonstigeVariablen.RassenImSpiel (RasseStadtSchleifenwert)
         is
            when RassenDatentypen.Leer_Spieler_Enum =>
               null;

            when others =>
               StadtSchleife:
               for StadtNummerSchleifenwert in SpielVariablen.StadtGebautArray'First (2) .. SpielVariablen.Grenzen (RasseStadtSchleifenwert).Städtegrenze loop
                  
                  StadtRecords.StadtGebautRecord'Write (Stream (File => DateiSpeichernNeu),
                                                               SpielVariablen.StadtGebaut (RasseStadtSchleifenwert, StadtNummerSchleifenwert));
            
               end loop StadtSchleife;
         end case;
         
      end loop StadtRassenSchleife;
      
   end StädteSpeichern;
   
   
   
   procedure WichtigesSpeichern
   is begin
      
      WichtigesSchleife:
      for RasseWichtigesSchleifenwert in SpielVariablen.WichtigesArray'Range loop
         
         case
           SonstigeVariablen.RassenImSpiel (RasseWichtigesSchleifenwert)
         is
            when RassenDatentypen.Leer_Spieler_Enum =>
               null;
               
            when others =>
               WichtigeRecords.WichtigesRecord'Write (Stream (File => DateiSpeichernNeu),
                                                      SpielVariablen.Wichtiges (RasseWichtigesSchleifenwert));
         end case;
         
      end loop WichtigesSchleife;
      
   end WichtigesSpeichern;
   
   
   
   procedure DiplomatieSpeichern
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
                        WichtigeRecords.DiplomatieRecord'Write (Stream (File => DateiSpeichernNeu),
                                                                SpielVariablen.Diplomatie (RasseDiplomatieEinsSchleifenwert, RasseDiplomatieZweiSchleifenwert));
                  end case;

               end loop DiplomatieSchleifeInnen;
         end case;
               
      end loop DiplomatieSchleifeAußen;
      
   end DiplomatieSpeichern;
   
   
   
   procedure CursorSpeichern
   is begin
      
      CursorSchleife:
      for RasseCursorSchleifenwert in SpielVariablen.CursorImSpielArray'Range loop
         
         case
           SonstigeVariablen.RassenImSpiel (RasseCursorSchleifenwert)
         is
            when RassenDatentypen.Leer_Spieler_Enum =>
               null;
               
            when others =>
               KartenRecords.CursorRecord'Write (Stream (File => DateiSpeichernNeu),
                                                 SpielVariablen.CursorImSpiel (RasseCursorSchleifenwert));
         end case;
         
      end loop CursorSchleife;
      
   end CursorSpeichern;
   
   
   
   function SpielstandNameFestlegen
     (AutospeichernExtern : in Boolean)
      return SystemRecords.TextEingabeRecord
   is begin
      
      case
        AutospeichernExtern
      is
         when False =>
            return NameNutzer;

         when True =>
            NameAutoSpeichern;
            return NameSpielstand;
      end case;
      
   end SpielstandNameFestlegen;
   
   
   
   function NameNutzer
     return SystemRecords.TextEingabeRecord
   is begin
      
      if
        To_Wide_Wide_String (Source => SpielVariablen.IronmanName) /= TextKonstanten.LeerString
      then
         null;
         -- SpeichernLadenAllgemein.SpielstandName.EingegebenerText := SpielVariablen.IronmanName;
               
      else
         -- Anzeige der vorhandenen Spielstände einbauen
         --  case
         --    SpeichernLadenAllgemein.SpielstandNameErmitteln
         --  is
         --     when True =>
         if
           Auswahl.AuswahlJaNein (FrageZeileExtern => 18) = RueckgabeDatentypen.Ja_Enum
         then
            null;
                     
         else
            null;
            --      return False;
         end if;

         --   when False =>
         --       null;
         --  end case;
      end if;
      
      return SpeichernLadenAllgemein.SpielstandNameErmitteln;
      
   end NameNutzer;
   
   
   
   procedure NameAutoSpeichern
   is begin
      
      if
        To_Wide_Wide_String (Source => SpielVariablen.IronmanName) /= TextKonstanten.LeerString
      then
         null;
         -- SpeichernLadenAllgemein.SpielstandName.EingegebenerText := SpielVariablen.IronmanName;
               
      else
         NameSpielstand := (True, To_Unbounded_Wide_Wide_String (Source => "Auto" & AutospeichernWert'Wide_Wide_Image));
         
         if
           OptionenVariablen.NutzerEinstellungen.AnzahlAutosave = 1
         then
            null;

         elsif
           AutospeichernWert <= OptionenVariablen.NutzerEinstellungen.AnzahlAutosave - 1
         then
            AutospeichernWert := AutospeichernWert + 1;
                  
         else
            AutospeichernWert := 1;
         end if;
      end if;
      
   end NameAutoSpeichern;
   
   

   procedure AutoSpeichern
   is begin
      
      case
        OptionenVariablen.NutzerEinstellungen.AnzahlAutosave
      is
         when Natural'First =>
            return;
            
         when others =>
            null;
      end case;
      
      case
        SpielVariablen.RundenAnzahl mod OptionenVariablen.NutzerEinstellungen.RundenBisAutosave
      is
         when 0 =>
            SpeichernNeu (AutospeichernExtern => True);
         
         when others =>
            null;
      end case;
      
   end AutoSpeichern;

end Speichern;

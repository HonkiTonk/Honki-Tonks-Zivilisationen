pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Strings.UTF_Encoding.Wide_Wide_Strings; use Ada.Strings.UTF_Encoding.Wide_Wide_Strings;
with Ada.Calendar; use Ada.Calendar;
with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with SystemDatentypen; use SystemDatentypen;
with RueckgabeDatentypen; use RueckgabeDatentypen;
with SonstigeVariablen;
with KartenRecords;
with StadtRecords;
with WichtigeRecords;
with SonstigesKonstanten;
with TextKonstanten;
with SpielDatentypen;
with OptionenVariablen;
with EinheitenRecords;
with GrafikDatentypen;

with Karten;
with Ladezeiten;
with SpeichernLadenAllgemein;
with InteraktionGrafiktask;
with Auswahl;

-- Bei Änderungen am Speichersystem auch immer das Ladesystem anpassen!
package body Speichern is

   procedure Speichern
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

      case
        AutospeichernExtern
      is
         when True =>
            null;
            
         when False =>
            Ladezeiten.SpeichernLadenNullsetzen;
            Ladezeiten.SpeichernLaden (SystemDatentypen.Anfangswert_Enum) := Clock;
            InteraktionGrafiktask.AktuelleDarstellung := GrafikDatentypen.Grafik_Speichern_Laden_Enum;
      end case;
      
      Create (File => DateiSpeichern,
              Mode => Out_File,
              Name => "Spielstand/" & Encode (Item => (To_Wide_Wide_String (Source => NameSpielstand.EingegebenerText))));
      
      Allgemeines;
      FortschrittErhöhen (AutospeichernExtern => AutospeichernExtern);
      
      Karte;
      FortschrittErhöhen (AutospeichernExtern => AutospeichernExtern);
      
      RassenwerteSpeichern;
      FortschrittErhöhen (AutospeichernExtern => AutospeichernExtern);
            
      Close (File => DateiSpeichern);

      case
        AutospeichernExtern
      is
         when True =>
            null;
            
         when False =>
            Ladezeiten.SpeichernLadenMaximum;
            InteraktionGrafiktask.AktuelleDarstellung := GrafikDatentypen.Grafik_Pause_Enum;
            Ladezeiten.SpeichernLaden (SystemDatentypen.Endwert_Enum) := Clock;
      end case;
   
   end Speichern;
   
   
   
   procedure FortschrittErhöhen
     (AutospeichernExtern : in Boolean)
   is begin
      
      case
        AutospeichernExtern
      is
         when False =>
            Ladezeiten.SpeichernLadenSchreiben (SpeichernLadenExtern => True);
            
         when True =>
            null;
      end case;
      
   end FortschrittErhöhen;
   
   
   
   procedure Allgemeines
   is begin
      
      Wide_Wide_String'Write (Stream (File => DateiSpeichern),
                              SonstigesKonstanten.Versionsnummer);
      
      Unbounded_Wide_Wide_String'Write (Stream (File => DateiSpeichern),
                                        SpielVariablen.IronmanName);
      
      Positive'Write (Stream (File => DateiSpeichern),
                      SpielVariablen.RundenAnzahl);
      
      Natural'Write (Stream (File => DateiSpeichern),
                     SpielVariablen.Rundengrenze);
      
      RassenDatentypen.RassenImSpielArray'Write (Stream (File => DateiSpeichern),
                                                 SpielVariablen.RassenImSpiel);
      
      RassenDatentypen.Rassen_Enum'Write (Stream (File => DateiSpeichern),
                                          SonstigeVariablen.RasseAmZugNachLaden);
      
      SpielDatentypen.Schwierigkeitsgrad_Enum'Write (Stream (File => DateiSpeichern),
                                                     SpielVariablen.Schwierigkeitsgrad);
      
      Boolean'Write (Stream (File => DateiSpeichern),
                     SonstigeVariablen.Gewonnen);
      
      Boolean'Write (Stream (File => DateiSpeichern),
                     SonstigeVariablen.WeiterSpielen);
      
   end Allgemeines;
   
   
   
   procedure Karte
   is begin
      
      KartenRecords.PermanenteKartenparameterRecord'Write (Stream (File => DateiSpeichern),
                                                           Karten.Karteneinstellungen);
      
      EAchseSchleife:
      for EAchseSchleifenwert in Karten.WeltkarteArray'Range (1) loop
         YAchseSchleife:
         for YAchseSchleifenwert in Karten.WeltkarteArray'First (2) .. Karten.Karteneinstellungen.Kartengröße.YAchse loop
            XAchseSchleife:
            for XAchseSchleifenwert in Karten.WeltkarteArray'First (3) .. Karten.Karteneinstellungen.Kartengröße.XAchse loop

               KartenRecords.KartenRecord'Write (Stream (File => DateiSpeichern),
                                                 Karten.Weltkarte (EAchseSchleifenwert, YAchseSchleifenwert, XAchseSchleifenwert));
               
            end loop XAchseSchleife;
         end loop YAchseSchleife;
      end loop EAchseSchleife;
      
   end Karte;
   
   
   
   procedure RassenwerteSpeichern
   is begin
      
      RassenSchleife:
      for RasseSchleifenwert in RassenDatentypen.Rassen_Verwendet_Enum'Range loop
         
         case
           SpielVariablen.RassenImSpiel (RasseSchleifenwert)
         is
            when RassenDatentypen.Leer_Spieler_Enum =>
               null;
               
            when others =>
               Rassenwerte (RasseExtern => RasseSchleifenwert);
         end case;
         
      end loop RassenSchleife;
      
   end RassenwerteSpeichern;
   
   
   
   procedure Rassenwerte
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      WichtigeRecords.GrenzenRecord'Write (Stream (File => DateiSpeichern),
                                           SpielVariablen.Grenzen (RasseExtern));
      
      EinheitenSchleife:
      for EinheitSchleifenwert in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (RasseExtern).Einheitengrenze loop
                  
         EinheitenRecords.EinheitenGebautRecord'Write (Stream (File => DateiSpeichern),
                                                       SpielVariablen.EinheitenGebaut (RasseExtern, EinheitSchleifenwert));
            
      end loop EinheitenSchleife;
      
      StadtSchleife:
      for StadtSchleifenwert in SpielVariablen.StadtGebautArray'First (2) .. SpielVariablen.Grenzen (RasseExtern).Städtegrenze loop
                  
         StadtRecords.StadtGebautRecord'Write (Stream (File => DateiSpeichern),
                                               SpielVariablen.StadtGebaut (RasseExtern, StadtSchleifenwert));
            
      end loop StadtSchleife;
      
      WichtigeRecords.WichtigesRecord'Write (Stream (File => DateiSpeichern),
                                             SpielVariablen.Wichtiges (RasseExtern));
      
      DiplomatieSchleife:
      for DiplomatieSchleifenwert in SpielVariablen.DiplomatieArray'Range (2) loop

         case
           SpielVariablen.RassenImSpiel (DiplomatieSchleifenwert)
         is
            when RassenDatentypen.Leer_Spieler_Enum =>
               null;
                     
            when others =>
               WichtigeRecords.DiplomatieRecord'Write (Stream (File => DateiSpeichern),
                                                       SpielVariablen.Diplomatie (RasseExtern, DiplomatieSchleifenwert));
         end case;

      end loop DiplomatieSchleife;
      
      KartenRecords.CursorRecord'Write (Stream (File => DateiSpeichern),
                                        SpielVariablen.CursorImSpiel (RasseExtern));
      
   end Rassenwerte;
   
   
   
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
            return NameAutoSpeichern;
      end case;
      
   end SpielstandNameFestlegen;
   
   
   
   function NameNutzer
     return SystemRecords.TextEingabeRecord
   is begin
      
      if
        To_Wide_Wide_String (Source => SpielVariablen.IronmanName) /= TextKonstanten.LeerString
      then
         NameSpielstand := (True, SpielVariablen.IronmanName);
               
      else
         ------------------------------ Anzeige der vorhandenen Spielstände einbauen
         NameSpielstand := SpeichernLadenAllgemein.SpielstandNameErmitteln;
         
         case
           NameSpielstand.ErfolgreichAbbruch
         is
            when True =>
               SpielstandVorhanden := SpeichernLadenAllgemein.SpielstandVorhanden (SpielstandnameExtern => NameSpielstand.EingegebenerText);
                 
               if
                 SpielstandVorhanden = False
               then
                  null;
                  
               elsif
                 SpielstandVorhanden
                 and then
                   Auswahl.AuswahlJaNein (FrageZeileExtern => TextKonstanten.FrageSpielstandÜberschreiben) = RueckgabeDatentypen.Ja_Enum
               then
                  null;
            
               else
                  NameSpielstand.ErfolgreichAbbruch := False;
               end if;

            when False =>
               null;
         end case;
      end if;
      
      return NameSpielstand;
      
   end NameNutzer;
   
   
   
   function NameAutoSpeichern
     return SystemRecords.TextEingabeRecord
   is begin
      
      if
        To_Wide_Wide_String (Source => SpielVariablen.IronmanName) /= TextKonstanten.LeerString
      then
         NameSpielstand := (True, SpielVariablen.IronmanName);
               
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
      
      return NameSpielstand;
      
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
            Speichern (AutospeichernExtern => True);
         
         when others =>
            null;
      end case;
      
   end AutoSpeichern;

end Speichern;

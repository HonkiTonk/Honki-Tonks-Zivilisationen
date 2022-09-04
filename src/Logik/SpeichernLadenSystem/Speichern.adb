pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Strings.UTF_Encoding.Wide_Wide_Strings; use Ada.Strings.UTF_Encoding.Wide_Wide_Strings;
with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with KartenRecords;
with StadtRecords;
with SpielRecords;
with SonstigesKonstanten;
with TextKonstanten;
with SpielDatentypen;
with OptionenVariablen;
with EinheitenRecords;
with GrafikDatentypen;
with TextnummernKonstanten;
with WeltkarteRecords;

with Karten;
with LadezeitenLogik;
with SpeichernLadenAllgemein;
with NachGrafiktask;
with AuswahlLogik;

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
            LadezeitenLogik.SpeichernLadenNullsetzen;
            NachGrafiktask.AktuelleDarstellung := GrafikDatentypen.Grafik_Speichern_Laden_Enum;
      end case;
      
      Create (File => DateiSpeichern,
              Mode => Out_File,
              Name => TextKonstanten.SpielstandStrich & Encode (Item => (To_Wide_Wide_String (Source => NameSpielstand.EingegebenerText))));
      
      Allgemeines (DateiSpeichernExtern => DateiSpeichern);
      FortschrittErhöhen (AutospeichernExtern => AutospeichernExtern);
      
      Karte (DateiSpeichernExtern => DateiSpeichern);
      -- Das hier auch noch mal überarbeiten, damit es nicht auf 33 springt und bei größeren Karten da dann länger bleibt, bis die Karte vollständig eingelesen ist. äöü
      FortschrittErhöhen (AutospeichernExtern => AutospeichernExtern);
      
      RassenwerteSpeichern (DateiSpeichernExtern => DateiSpeichern);
      FortschrittErhöhen (AutospeichernExtern => AutospeichernExtern);
            
      Close (File => DateiSpeichern);

      case
        AutospeichernExtern
      is
         when True =>
            null;
            
         when False =>
            LadezeitenLogik.SpeichernLadenMaximum;
            NachGrafiktask.AktuelleDarstellung := GrafikDatentypen.Grafik_Pause_Enum;
      end case;
   
   end Speichern;
   
   
   
   procedure FortschrittErhöhen
     (AutospeichernExtern : in Boolean)
   is begin
      
      case
        AutospeichernExtern
      is
         when False =>
            LadezeitenLogik.SpeichernLadenSchreiben (SpeichernLadenExtern => True);
            
         when True =>
            null;
      end case;
      
   end FortschrittErhöhen;
   
   
   
   procedure Allgemeines
     (DateiSpeichernExtern : in File_Type)
   is begin
      
      Wide_Wide_String'Write (Stream (File => DateiSpeichernExtern),
                              SonstigesKonstanten.Versionsnummer);
      
      Unbounded_Wide_Wide_String'Write (Stream (File => DateiSpeichernExtern),
                                        SpielVariablen.Allgemeines.IronmanName);
      
      Positive'Write (Stream (File => DateiSpeichernExtern),
                      SpielVariablen.Allgemeines.Rundenanzahl);
      
      Natural'Write (Stream (File => DateiSpeichernExtern),
                     SpielVariablen.Allgemeines.Rundengrenze);
      
      RassenDatentypen.RassenImSpielArray'Write (Stream (File => DateiSpeichernExtern),
                                                 SpielVariablen.RassenImSpiel);
      
      RassenDatentypen.Rassen_Enum'Write (Stream (File => DateiSpeichernExtern),
                                          SpielVariablen.Allgemeines.RasseAmZugNachLaden);
      
      SpielDatentypen.Schwierigkeitsgrad_Enum'Write (Stream (File => DateiSpeichernExtern),
                                                     SpielVariablen.Allgemeines.Schwierigkeitsgrad);
      
      Boolean'Write (Stream (File => DateiSpeichernExtern),
                     SpielVariablen.Allgemeines.Gewonnen);
      
      Boolean'Write (Stream (File => DateiSpeichernExtern),
                     SpielVariablen.Allgemeines.Weiterspielen);
      
   end Allgemeines;
   
   
   
   procedure Karte
     (DateiSpeichernExtern : in File_Type)
   is begin
      
      KartenRecords.PermanenteKartenparameterRecord'Write (Stream (File => DateiSpeichernExtern),
                                                           Karten.Karteneinstellungen);
      
      EAchseSchleife:
      for EAchseSchleifenwert in Karten.WeltkarteArray'Range (1) loop
         YAchseSchleife:
         for YAchseSchleifenwert in Karten.WeltkarteArray'First (2) .. Karten.Karteneinstellungen.Kartengröße.YAchse loop
            XAchseSchleife:
            for XAchseSchleifenwert in Karten.WeltkarteArray'First (3) .. Karten.Karteneinstellungen.Kartengröße.XAchse loop

               WeltkarteRecords.WeltkarteRecord'Write (Stream (File => DateiSpeichernExtern),
                                                       Karten.Weltkarte (EAchseSchleifenwert, YAchseSchleifenwert, XAchseSchleifenwert));
               
            end loop XAchseSchleife;
         end loop YAchseSchleife;
      end loop EAchseSchleife;
      
   end Karte;
   
   
   
   procedure RassenwerteSpeichern
     (DateiSpeichernExtern : in File_Type)
   is begin
      
      RassenSchleife:
      for RasseSchleifenwert in RassenDatentypen.Rassen_Verwendet_Enum'Range loop
         
         case
           SpielVariablen.RassenImSpiel (RasseSchleifenwert)
         is
            when RassenDatentypen.Leer_Spieler_Enum =>
               null;
               
            when others =>
               Rassenwerte (RasseExtern          => RasseSchleifenwert,
                            DateiSpeichernExtern => DateiSpeichernExtern);
         end case;
         
      end loop RassenSchleife;
      
   end RassenwerteSpeichern;
   
   
   
   procedure Rassenwerte
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      DateiSpeichernExtern : in File_Type)
   is begin
      
      SpielRecords.GrenzenRecord'Write (Stream (File => DateiSpeichernExtern),
                                        SpielVariablen.Grenzen (RasseExtern));
      
      EinheitenSchleife:
      for EinheitSchleifenwert in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (RasseExtern).Einheitengrenze loop
                  
         EinheitenRecords.EinheitenGebautRecord'Write (Stream (File => DateiSpeichernExtern),
                                                       SpielVariablen.EinheitenGebaut (RasseExtern, EinheitSchleifenwert));
            
      end loop EinheitenSchleife;
      
      StadtSchleife:
      for StadtSchleifenwert in SpielVariablen.StadtGebautArray'First (2) .. SpielVariablen.Grenzen (RasseExtern).Städtegrenze loop
                  
         StadtRecords.StadtGebautRecord'Write (Stream (File => DateiSpeichernExtern),
                                               SpielVariablen.StadtGebaut (RasseExtern, StadtSchleifenwert));
            
      end loop StadtSchleife;
      
      SpielRecords.WichtigesRecord'Write (Stream (File => DateiSpeichernExtern),
                                          SpielVariablen.Wichtiges (RasseExtern));
      
      DiplomatieSchleife:
      for DiplomatieSchleifenwert in SpielVariablen.DiplomatieArray'Range (2) loop

         case
           SpielVariablen.RassenImSpiel (DiplomatieSchleifenwert)
         is
            when RassenDatentypen.Leer_Spieler_Enum =>
               null;
                     
            when others =>
               SpielRecords.DiplomatieRecord'Write (Stream (File => DateiSpeichernExtern),
                                                    SpielVariablen.Diplomatie (RasseExtern, DiplomatieSchleifenwert));
         end case;

      end loop DiplomatieSchleife;
      
      KartenRecords.CursorRecord'Write (Stream (File => DateiSpeichernExtern),
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
        To_Wide_Wide_String (Source => SpielVariablen.Allgemeines.IronmanName) /= TextKonstanten.LeerString
      then
         NameSpielstand := (True, SpielVariablen.Allgemeines.IronmanName);
               
      else
         -- Anzeige der vorhandenen Spielstände einbauen äöü
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
                 AuswahlLogik.JaNein (FrageZeileExtern => TextnummernKonstanten.FrageSpielstandÜberschreiben) = True
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
        To_Wide_Wide_String (Source => SpielVariablen.Allgemeines.IronmanName) /= TextKonstanten.LeerString
      then
         NameSpielstand := (True, SpielVariablen.Allgemeines.IronmanName);
               
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
        SpielVariablen.Allgemeines.Rundenanzahl mod OptionenVariablen.NutzerEinstellungen.RundenBisAutosave
      is
         when 0 =>
            Speichern (AutospeichernExtern => True);
         
         when others =>
            null;
      end case;
      
   end AutoSpeichern;

end Speichern;

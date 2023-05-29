with Ada.Strings.UTF_Encoding.Wide_Wide_Strings; use Ada.Strings.UTF_Encoding.Wide_Wide_Strings;

with KartenRecords;
with StadtRecords;
with SpielRecords;
with TextKonstanten;
with EinheitenRecords;
with GrafikDatentypen;
with VerzeichnisKonstanten;
with SpielstandlisteLogik;
with StadtKonstanten;
with EinheitenKonstanten;
with OptionenVariablen;

with LeseWichtiges;
with LeseGrenzen;
with LeseAllgemeines;
with LeseDiplomatie;
with LeseCursor;
with LeseEinheitenGebaut;
with LeseStadtGebaut;
with LeseOptionen;

with LadezeitenLogik;
with NachGrafiktask;
with SpielstandAllgemeinesLogik;
with SpeichernKarteLogik;
with Fehlermeldungssystem;

-- Bei Änderungen am Speichersystem auch immer das Ladesystem anpassen!
package body SpeichernLogik is

   procedure Speichern
     (AutospeichernExtern : in Boolean)
   is begin
      
      SpeichernSchleife:
      loop
         
         case
           AutospeichernExtern
         is
            when True =>
               Spielstandname := NameAutoSpeichern;
            
            when False =>
               Spielstandname := SpielstandlisteLogik.Spielstandliste (SpeichernLadenExtern => True);
         end case;
      
         if
           Spielstandname = TextKonstanten.LeerUnboundedString
         then
            return;
      
         else
            null;
         end if;

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
                 Name => (VerzeichnisKonstanten.SpielstandStrich & Encode (Item => (To_Wide_Wide_String (Source => Spielstandname)))),
                 Form => "WCEM=8");
         
         if
           False = SpeichernKarteLogik.Karte (DateiSpeichernExtern => DateiSpeichern,
                                              AutospeichernExtern  => AutospeichernExtern)
         then
            null;
            
         elsif
           False = Allgemeines (DateiSpeichernExtern => DateiSpeichern)
         then
            null;
            
         elsif
           False = SpezieswerteSpeichern (DateiSpeichernExtern => DateiSpeichern)
         then
            null;
            
         else
            SpielstandAllgemeinesLogik.FortschrittErhöhen (AutospeichernExtern => AutospeichernExtern);
         end if;
            
         Close (File => DateiSpeichern);
         
         LadezeitenLogik.SpeichernLadenMaximum;

         case
           AutospeichernExtern
         is
            when True =>
               return;
            
            when False =>
               NachGrafiktask.AktuelleDarstellung := GrafikDatentypen.Grafik_Pause_Enum;
         end case;
         
      end loop SpeichernSchleife;
      
      -- Zu den ganzen exceptions hier und beim Schreiben noch spezifisches Handeln einbauen. äöü
      -- Beispielsweise Datei schließen wenn etwas nicht geschrieben werden konnte, aber nicht wenn die Datei gar nicht angelegt werden konnt. äöü
   exception
      when End_Error | Status_Error | Mode_Error | Name_Error | Use_Error | Device_Error | Data_Error =>
         Fehlermeldungssystem.Logik (FehlermeldungExtern => "SpeichernLogik.Speichern - Datei konnte nicht angelegt werden");
         
         case
           AutospeichernExtern
         is
            when True =>
               return;
            
            when False =>
               NachGrafiktask.AktuelleDarstellung := GrafikDatentypen.Grafik_Pause_Enum;
         end case;
      
   end Speichern;
   
   
   
   function Allgemeines
     (DateiSpeichernExtern : in File_Type)
      return Boolean
   is begin
            
      SpielRecords.AllgemeinesRecord'Write (Stream (File => DateiSpeichernExtern),
                                            LeseAllgemeines.GanzerEintrag);
            
      SpielRecords.SpeziesbelegungArray'Write (Stream (File => DateiSpeichernExtern),
                                               LeseSpeziesbelegung.GanzesArray);
      
      return True;
      
   exception
      when End_Error | Status_Error | Mode_Error | Name_Error | Use_Error | Device_Error | Data_Error =>
         Fehlermeldungssystem.Logik (FehlermeldungExtern => "SpeichernLogik.Allgemeines - Konnte nicht geschrieben werden");
         return False;
      
   end Allgemeines;
   
   
   
   function SpezieswerteSpeichern
     (DateiSpeichernExtern : in File_Type)
      return Boolean
   is begin
      
      SpeziesSchleife:
      for SpeziesSchleifenwert in SpeziesDatentypen.Spezies_Verwendet_Enum'Range loop
         
         if
           LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesSchleifenwert) = SpeziesDatentypen.Leer_Spieler_Enum
         then
            null;
               
         elsif
           False =StädteEinheitenSpeichern (SpeziesExtern        => SpeziesSchleifenwert,
                                             DateiSpeichernExtern => DateiSpeichernExtern)
         then
            return False;
                  
         elsif
           False = Spezieswerte (SpeziesExtern        => SpeziesSchleifenwert,
                                 DateiSpeichernExtern => DateiSpeichernExtern)
         then
            return False;
                  
         else
            null;
         end if;
         
      end loop SpeziesSchleife;
      
      return True;
      
   end SpezieswerteSpeichern;
   
   
   
   function StädteEinheitenSpeichern
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      DateiSpeichernExtern : in File_Type)
      return Boolean
   is begin
      
      SpielRecords.GrenzenRecord'Write (Stream (File => DateiSpeichernExtern),
                                        LeseGrenzen.GanzerEintrag (SpeziesExtern => SpeziesExtern));
      
      VorhandeneEinheiten := EinheitenKonstanten.LeerNummer;
      
      AnzahlEinheitenSchleife:
      for AnzahlEinheitenSchleifenwert in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => SpeziesExtern) loop
         
         case
           LeseEinheitenGebaut.ID (EinheitSpeziesNummerExtern => (SpeziesExtern, AnzahlEinheitenSchleifenwert))
         is
            when EinheitenKonstanten.LeerID =>
               exit AnzahlEinheitenSchleife;
               
            when others =>
               VorhandeneEinheiten := AnzahlEinheitenSchleifenwert;
         end case;
         
      end loop AnzahlEinheitenSchleife;
      
      EinheitenDatentypen.MaximaleEinheitenMitNullWert'Write (Stream (File => DateiSpeichernExtern),
                                                              VorhandeneEinheiten);
      
      EinheitenSchleife:
      for EinheitSchleifenwert in EinheitenKonstanten.AnfangNummer .. VorhandeneEinheiten loop
                  
         EinheitenRecords.EinheitenGebautRecord'Write (Stream (File => DateiSpeichernExtern),
                                                       LeseEinheitenGebaut.GanzerEintrag (EinheitSpeziesNummerExtern => (SpeziesExtern, EinheitSchleifenwert)));
         
      end loop EinheitenSchleife;
      
      

      VorhandeneStädte := StadtKonstanten.LeerNummer;
      
      AnzahlStädteSchleife:
      for AnzahlStädteSchleifenwert in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => SpeziesExtern) loop

         case
           LeseStadtGebaut.ID (StadtSpeziesNummerExtern => (SpeziesExtern, AnzahlStädteSchleifenwert))
         is
            when StadtKonstanten.LeerID =>
               exit AnzahlStädteSchleife;
               
            when others =>
               VorhandeneStädte := AnzahlStädteSchleifenwert;
         end case;

      end loop AnzahlStädteSchleife;
      
      StadtDatentypen.MaximaleStädteMitNullWert'Write (Stream (File => DateiSpeichernExtern),
                                                        VorhandeneStädte);
      
      StadtSchleife:
      for StadtSchleifenwert in StadtKonstanten.AnfangNummer .. VorhandeneStädte loop
                  
         StadtRecords.StadtGebautRecord'Write (Stream (File => DateiSpeichernExtern),
                                               LeseStadtGebaut.GanzerEintrag (StadtSpeziesNummerExtern => (SpeziesExtern, StadtSchleifenwert)));
            
      end loop StadtSchleife;
      
      return True;
      
   exception
      when End_Error | Status_Error | Mode_Error | Name_Error | Use_Error | Device_Error | Data_Error =>
         Fehlermeldungssystem.Logik (FehlermeldungExtern => "SpeichernLogik.StädteEinheitenSpeichern - Konnte nicht geschrieben werden");
         return False;
      
   end StädteEinheitenSpeichern;
   
   
   
   function Spezieswerte
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      DateiSpeichernExtern : in File_Type)
      return Boolean
   is
      use type SpeziesDatentypen.Spezies_Enum;
   begin
      
      DiplomatieSchleife:
      for DiplomatieSchleifenwert in SpeziesDatentypen.Spezies_Verwendet_Enum'Range loop

         if
           LeseSpeziesbelegung.Belegung (SpeziesExtern => DiplomatieSchleifenwert) = SpeziesDatentypen.Leer_Spieler_Enum
           or
             DiplomatieSchleifenwert = SpeziesExtern
         then
            null;
                     
         else
            SpielRecords.DiplomatieRecord'Write (Stream (File => DateiSpeichernExtern),
                                                 LeseDiplomatie.GanzerEintrag (SpeziesEinsExtern => SpeziesExtern,
                                                                               SpeziesZweiExtern => DiplomatieSchleifenwert));
         end if;

      end loop DiplomatieSchleife;
      
      SpielRecords.WichtigesRecord'Write (Stream (File => DateiSpeichernExtern),
                                          LeseWichtiges.GanzerEintrag (SpeziesExtern => SpeziesExtern));
      
      case
        LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern)
      is
         when SpeziesDatentypen.Mensch_Spieler_Enum =>
            KartenRecords.CursorRecord'Write (Stream (File => DateiSpeichernExtern),
                                              LeseCursor.GanzerEintrag (SpeziesExtern => SpeziesExtern));
            
         when others =>
            null;
      end case;
      
      return True;
      
   exception
      when End_Error | Status_Error | Mode_Error | Name_Error | Use_Error | Device_Error | Data_Error =>
         Fehlermeldungssystem.Logik (FehlermeldungExtern => "SpeichernLogik.Spezieswerte - Konnte nicht geschrieben werden");
         return False;
      
   end Spezieswerte;
   
   
   
   function NameAutoSpeichern
     return Unbounded_Wide_Wide_String
   is begin
      
      if
        To_Wide_Wide_String (Source => LeseAllgemeines.Ironman) /= TextKonstanten.LeerString
      then
         Autospeichernname := LeseAllgemeines.Ironman;
               
      else
         Autospeichernname := To_Unbounded_Wide_Wide_String (Source => "Auto" & OptionenVariablen.SonstigeEinstellungen.AktuellerAutospeichernwert'Wide_Wide_Image);
         MaximalerAutospeichernwert := LeseOptionen.AnzahlAutospeichern;
         
         if
           MaximalerAutospeichernwert = 1
         then
            null;

         elsif
           OptionenVariablen.SonstigeEinstellungen.AktuellerAutospeichernwert <= MaximalerAutospeichernwert
         then
            OptionenVariablen.SonstigeEinstellungen.AktuellerAutospeichernwert := OptionenVariablen.SonstigeEinstellungen.AktuellerAutospeichernwert + 1;
                  
         else
            OptionenVariablen.SonstigeEinstellungen.AktuellerAutospeichernwert := 1;
         end if;
      end if;
      
      return Autospeichernname;
      
   end NameAutoSpeichern;
   
   

   procedure AutoSpeichern
   is begin
      
      case
        LeseOptionen.AnzahlAutospeichern
      is
         when Natural'First =>
            return;
            
         when others =>
            null;
      end case;
      
      case
        LeseAllgemeines.Rundenanzahl mod LeseOptionen.RundenAutospeichern
      is
         when 0 =>
            Speichern (AutospeichernExtern => True);
         
         when others =>
            null;
      end case;
      
   end AutoSpeichern;

end SpeichernLogik;

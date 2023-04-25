with Ada.Strings.UTF_Encoding.Wide_Wide_Strings; use Ada.Strings.UTF_Encoding.Wide_Wide_Strings;

with KartenRecords;
with StadtRecords;
with SpielRecords;
with TextKonstanten;
with EinheitenRecords;
with GrafikDatentypen;
with WeltkarteRecords;
with VerzeichnisKonstanten;
with SpielstandlisteLogik;
with KartenKonstanten;
with StadtKonstanten;
with EinheitenKonstanten;

with LeseWeltkarte;
with LeseWeltkarteneinstellungen;
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
      
         Karte (DateiSpeichernExtern => DateiSpeichern,
                AutospeichernExtern  => AutospeichernExtern);
      
         Allgemeines (DateiSpeichernExtern => DateiSpeichern);
         FortschrittErhöhen (AutospeichernExtern => AutospeichernExtern);
      
         SpezieswerteSpeichern (DateiSpeichernExtern => DateiSpeichern);
         FortschrittErhöhen (AutospeichernExtern => AutospeichernExtern);
            
         Close (File => DateiSpeichern);

         case
           AutospeichernExtern
         is
            when True =>
               return;
            
            when False =>
               LadezeitenLogik.SpeichernLadenMaximum;
               NachGrafiktask.AktuelleDarstellung := GrafikDatentypen.Grafik_Pause_Enum;
         end case;
         
      end loop SpeichernSchleife;
      
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
   
   
   
   procedure Karte
     (DateiSpeichernExtern : in File_Type;
      AutospeichernExtern : in Boolean)
   is begin
      
      KartenRecords.PermanenteKartenparameterRecord'Write (Stream (File => DateiSpeichernExtern),
                                                           LeseWeltkarteneinstellungen.GesamteEinstellungen);
      
      EAchseSchleife:
      for EAchseSchleifenwert in KartenKonstanten.AnfangEAchse .. KartenKonstanten.EndeEAchse loop
         YAchseSchleife:
         for YAchseSchleifenwert in KartenKonstanten.AnfangYAchse .. LeseWeltkarteneinstellungen.YAchse loop
            XAchseSchleife:
            for XAchseSchleifenwert in KartenKonstanten.AnfangXAchse .. LeseWeltkarteneinstellungen.XAchse loop

               WeltkarteRecords.WeltkarteRecord'Write (Stream (File => DateiSpeichernExtern),
                                                       LeseWeltkarte.GanzerEintrag (KoordinatenExtern => (EAchseSchleifenwert, YAchseSchleifenwert, XAchseSchleifenwert)));
               
            end loop XAchseSchleife;
         end loop YAchseSchleife;
                  
         FortschrittErhöhen (AutospeichernExtern => AutospeichernExtern);
         
      end loop EAchseSchleife;
      
   end Karte;
   
   
   
   procedure Allgemeines
     (DateiSpeichernExtern : in File_Type)
   is begin
            
      SpielRecords.AllgemeinesRecord'Write (Stream (File => DateiSpeichernExtern),
                                            LeseAllgemeines.GanzerEintrag);
            
      SpielRecords.SpeziesbelegungArray'Write (Stream (File => DateiSpeichernExtern),
                                               LeseSpeziesbelegung.GanzesArray);
      
   end Allgemeines;
   
   
   
   procedure SpezieswerteSpeichern
     (DateiSpeichernExtern : in File_Type)
   is begin
      
      SpeziesSchleife:
      for SpeziesSchleifenwert in SpeziesDatentypen.Spezies_Verwendet_Enum'Range loop
         
         case
           LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesSchleifenwert)
         is
            when SpeziesDatentypen.Leer_Spieler_Enum =>
               null;
               
            when others =>
               Spezieswerte (SpeziesExtern        => SpeziesSchleifenwert,
                             DateiSpeichernExtern => DateiSpeichernExtern);
         end case;
         
      end loop SpeziesSchleife;
      
   end SpezieswerteSpeichern;
   
   
   
   procedure Spezieswerte
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      DateiSpeichernExtern : in File_Type)
   is
      use type SpeziesDatentypen.Spezies_Enum;
   begin
      
      SpielRecords.GrenzenRecord'Write (Stream (File => DateiSpeichernExtern),
                                        LeseGrenzen.GanzerEintrag (SpeziesExtern => SpeziesExtern));
      
      EinheitenSchleife:
      for EinheitSchleifenwert in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => SpeziesExtern) loop
                  
         EinheitenRecords.EinheitenGebautRecord'Write (Stream (File => DateiSpeichernExtern),
                                                       LeseEinheitenGebaut.GanzerEintrag (EinheitSpeziesNummerExtern => (SpeziesExtern, EinheitSchleifenwert)));
         
      end loop EinheitenSchleife;
      
      StadtSchleife:
      for StadtSchleifenwert in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => SpeziesExtern) loop
                  
         StadtRecords.StadtGebautRecord'Write (Stream (File => DateiSpeichernExtern),
                                               LeseStadtGebaut.GanzerEintrag (StadtSpeziesNummerExtern => (SpeziesExtern, StadtSchleifenwert)));
            
      end loop StadtSchleife;
      
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
      
      KartenRecords.CursorRecord'Write (Stream (File => DateiSpeichernExtern),
                                        LeseCursor.GanzerEintrag (SpeziesExtern => SpeziesExtern));
      
   end Spezieswerte;
   
   
   
   function NameAutoSpeichern
     return Unbounded_Wide_Wide_String
   is begin
      
      if
        To_Wide_Wide_String (Source => LeseAllgemeines.Ironman) /= TextKonstanten.LeerString
      then
         Autospeichernname := LeseAllgemeines.Ironman;
               
      else
         Autospeichernname := To_Unbounded_Wide_Wide_String (Source => "Auto" & AutospeichernWert'Wide_Wide_Image);
         
         if
           LeseOptionen.AnzahlAutospeichern = 1
         then
            null;

         elsif
           AutospeichernWert <= LeseOptionen.AnzahlAutospeichern - 1
         then
            AutospeichernWert := AutospeichernWert + 1;
                  
         else
            AutospeichernWert := 1;
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

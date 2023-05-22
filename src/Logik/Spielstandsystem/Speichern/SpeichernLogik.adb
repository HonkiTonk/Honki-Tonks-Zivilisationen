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
with KartenverbesserungDatentypen;

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
      
         SpeichernKarteLogik.Karte (DateiSpeichernExtern => DateiSpeichern,
                                    AutospeichernExtern  => AutospeichernExtern);
         
         Allgemeines (DateiSpeichernExtern => DateiSpeichern);
         SpielstandAllgemeinesLogik.FortschrittErhöhen (AutospeichernExtern => AutospeichernExtern);
      
         SpezieswerteSpeichern (DateiSpeichernExtern => DateiSpeichern);
         SpielstandAllgemeinesLogik.FortschrittErhöhen (AutospeichernExtern => AutospeichernExtern);
            
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
               StädteEinheitenSpeichern (SpeziesExtern        => SpeziesSchleifenwert,
                                          DateiSpeichernExtern => DateiSpeichernExtern);
               
               Spezieswerte (SpeziesExtern        => SpeziesSchleifenwert,
                             DateiSpeichernExtern => DateiSpeichernExtern);
         end case;
         
      end loop SpeziesSchleife;
      
   end SpezieswerteSpeichern;
   
   
   
   procedure StädteEinheitenSpeichern
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      DateiSpeichernExtern : in File_Type)
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
            when KartenverbesserungDatentypen.Leer_Verbesserung_Enum =>
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
      
   end StädteEinheitenSpeichern;
   
   
   
   procedure Spezieswerte
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      DateiSpeichernExtern : in File_Type)
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

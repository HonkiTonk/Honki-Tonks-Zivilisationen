with Ada.Strings.UTF_Encoding.Wide_Wide_Strings; use Ada.Strings.UTF_Encoding.Wide_Wide_Strings;

with KartenRecords;
with StadtRecords;
with SpielRecords;
with TextKonstanten;
with OptionenVariablen;
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
                 Name => (VerzeichnisKonstanten.SpielstandStrich & Encode (Item => (To_Wide_Wide_String (Source => Spielstandname)))));
      
         Karte (DateiSpeichernExtern => DateiSpeichern,
                AutospeichernExtern  => AutospeichernExtern);
      
         Allgemeines (DateiSpeichernExtern => DateiSpeichern);
         FortschrittErhöhen (AutospeichernExtern => AutospeichernExtern);
      
         RassenwerteSpeichern (DateiSpeichernExtern => DateiSpeichern);
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
            
      SpielRecords.RassenbelegungArray'Write (Stream (File => DateiSpeichernExtern),
                                              LeseRassenbelegung.GanzesArray);
      
   end Allgemeines;
   
   
   
   procedure RassenwerteSpeichern
     (DateiSpeichernExtern : in File_Type)
   is begin
      
      RassenSchleife:
      for RasseSchleifenwert in RassenDatentypen.Rassen_Verwendet_Enum'Range loop
         
         case
           LeseRassenbelegung.Belegung (RasseExtern => RasseSchleifenwert)
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
   is
      use type RassenDatentypen.Rassen_Enum;
   begin
      
      SpielRecords.GrenzenRecord'Write (Stream (File => DateiSpeichernExtern),
                                        LeseGrenzen.GanzerEintrag (RasseExtern => RasseExtern));
      
      EinheitenSchleife:
      for EinheitSchleifenwert in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (RasseExtern => RasseExtern) loop
                  
         EinheitenRecords.EinheitenGebautRecord'Write (Stream (File => DateiSpeichernExtern),
                                                       LeseEinheitenGebaut.GanzerEintrag (EinheitRasseNummerExtern => (RasseExtern, EinheitSchleifenwert)));
                                                       
      end loop EinheitenSchleife;
      
      StadtSchleife:
      for StadtSchleifenwert in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (RasseExtern => RasseExtern) loop
                  
         StadtRecords.StadtGebautRecord'Write (Stream (File => DateiSpeichernExtern),
                                               LeseStadtGebaut.GanzerEintrag (StadtRasseNummerExtern => (RasseExtern, StadtSchleifenwert)));
            
      end loop StadtSchleife;
      
      DiplomatieSchleife:
      for DiplomatieSchleifenwert in RassenDatentypen.Rassen_Verwendet_Enum'Range loop

         if
           LeseRassenbelegung.Belegung (RasseExtern => DiplomatieSchleifenwert) = RassenDatentypen.Leer_Spieler_Enum
           or
             DiplomatieSchleifenwert = RasseExtern
         then
            null;
                     
         else
            SpielRecords.DiplomatieRecord'Write (Stream (File => DateiSpeichernExtern),
                                                 LeseDiplomatie.GanzerEintrag (RasseEinsExtern => RasseExtern,
                                                                               RasseZweiExtern => DiplomatieSchleifenwert));
         end if;

      end loop DiplomatieSchleife;
      
      SpielRecords.WichtigesRecord'Write (Stream (File => DateiSpeichernExtern),
                                          LeseWichtiges.GanzerEintrag (RasseExtern => RasseExtern));
      
      KartenRecords.CursorRecord'Write (Stream (File => DateiSpeichernExtern),
                                        LeseCursor.GanzerEintrag (RasseExtern => RasseExtern));
      
   end Rassenwerte;
   
   
   
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
      
      return Autospeichernname;
      
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
        LeseAllgemeines.Rundenanzahl mod OptionenVariablen.NutzerEinstellungen.RundenBisAutosave
      is
         when 0 =>
            Speichern (AutospeichernExtern => True);
         
         when others =>
            null;
      end case;
      
   end AutoSpeichern;

end SpeichernLogik;

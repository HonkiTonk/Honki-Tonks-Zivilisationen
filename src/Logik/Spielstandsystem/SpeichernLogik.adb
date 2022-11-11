with Ada.Strings.UTF_Encoding.Wide_Wide_Strings; use Ada.Strings.UTF_Encoding.Wide_Wide_Strings;

with KartenRecords;
with StadtRecords;
with SpielRecords;
with SonstigesKonstanten;
with TextKonstanten;
with OptionenVariablen;
with EinheitenRecords;
with GrafikDatentypen;
with WeltkarteRecords;
with VerzeichnisKonstanten;
with SpielstandlisteLogik;

with Weltkarte;
with LadezeitenLogik;
with NachGrafiktask;

-- Bei Änderungen am Speichersystem auch immer das Ladesystem anpassen!
package body SpeichernLogik is

   procedure Speichern
     (AutospeichernExtern : in Boolean)
   is begin
      
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
      
      Allgemeines (DateiSpeichernExtern => DateiSpeichern);
      FortschrittErhöhen (AutospeichernExtern => AutospeichernExtern);
      
      Karte (DateiSpeichernExtern => DateiSpeichern,
             AutospeichernExtern  => AutospeichernExtern);
      
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
      
      SpielRecords.AllgemeinesRecord'Write (Stream (File => DateiSpeichernExtern),
                                            SpielVariablen.Allgemeines);
            
      SpielVariablen.RassenbelegungArray'Write (Stream (File => DateiSpeichernExtern),
                                                SpielVariablen.Rassenbelegung);
      
   end Allgemeines;
   
   
   
   procedure Karte
     (DateiSpeichernExtern : in File_Type;
      AutospeichernExtern : in Boolean)
   is begin
      
      KartenRecords.PermanenteKartenparameterRecord'Write (Stream (File => DateiSpeichernExtern),
                                                           Weltkarte.Karteneinstellungen);
      
      EAchseSchleife:
      for EAchseSchleifenwert in Weltkarte.KarteArray'Range (1) loop
         YAchseSchleife:
         for YAchseSchleifenwert in Weltkarte.KarteArray'First (2) .. Weltkarte.Karteneinstellungen.Kartengröße.YAchse loop
            XAchseSchleife:
            for XAchseSchleifenwert in Weltkarte.KarteArray'First (3) .. Weltkarte.Karteneinstellungen.Kartengröße.XAchse loop

               WeltkarteRecords.WeltkarteRecord'Write (Stream (File => DateiSpeichernExtern),
                                                       Weltkarte.Karte (EAchseSchleifenwert, YAchseSchleifenwert, XAchseSchleifenwert));
               
            end loop XAchseSchleife;
         end loop YAchseSchleife;
                  
         FortschrittErhöhen (AutospeichernExtern => AutospeichernExtern);
         
      end loop EAchseSchleife;
      
   end Karte;
   
   
   
   procedure RassenwerteSpeichern
     (DateiSpeichernExtern : in File_Type)
   is begin
      
      RassenSchleife:
      for RasseSchleifenwert in RassenDatentypen.Rassen_Verwendet_Enum'Range loop
         
         case
           SpielVariablen.Rassenbelegung (RasseSchleifenwert).Belegung
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
           SpielVariablen.Rassenbelegung (DiplomatieSchleifenwert).Belegung
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
   
   
   
   function NameAutoSpeichern
     return Unbounded_Wide_Wide_String
   is begin
      
      if
        To_Wide_Wide_String (Source => SpielVariablen.Allgemeines.IronmanName) /= TextKonstanten.LeerString
      then
         Autospeichernname := SpielVariablen.Allgemeines.IronmanName;
               
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
        SpielVariablen.Allgemeines.Rundenanzahl mod OptionenVariablen.NutzerEinstellungen.RundenBisAutosave
      is
         when 0 =>
            Speichern (AutospeichernExtern => True);
         
         when others =>
            null;
      end case;
      
   end AutoSpeichern;

end SpeichernLogik;

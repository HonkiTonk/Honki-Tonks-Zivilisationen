with Ada.Exceptions;

with DateizugriffssystemHTSEB;

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
with TextnummernKonstanten;

with LeseWichtiges;
with LeseGrenzen;
with LeseAllgemeines;
with LeseDiplomatie;
with LeseZeiger;
with LeseEinheitenGebaut;
with LeseStadtGebaut;
with LeseOptionen;
with SchreibeOptionen;
with SchreibeGrafiktask;

with LadezeitenLogik;
with SpielstandAllgemeinesLogik;
with SpeichernKarteLogik;
with MeldungssystemHTSEB;
with MeldungFestlegenLogik;
with UmwandlungenVerzeichnisse;
with UmwandlungssystemHTSEB;

-- Bei Änderungen am Speichersystem auch immer das Ladesystem anpassen!
package body SpeichernLogik is
      
   procedure Speichern
     (AutospeichernExtern : in Boolean;
      NotfallspeichernExtern : in Boolean)
   is
      use Ada.Exceptions;
   begin
      
      SpeichernSchleife:
      loop
         
         case
           AutospeichernExtern
         is
            when True =>
               if
                 NotfallspeichernExtern = False
               then
                  Spielstandname := NameAutoSpeichern;
                  
               else
                  Spielstandname := To_Unbounded_Wide_Wide_String (Source => VerzeichnisKonstanten.Notfallspeichern);
               end if;
            
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
               Spielstandart := SystemDatentypen.Automatischer_Spielstand_Enum;
            
            when False =>
               LadezeitenLogik.SpeichernLadenNullsetzen;
               SchreibeGrafiktask.Darstellung (DarstellungExtern => GrafikDatentypen.Speichern_Laden_Enum);
               Spielstandart := SystemDatentypen.Manueller_Spielstand_Enum;
         end case;
         
         DateizugriffssystemHTSEB.ErstellenStream (DateiartExtern => DateiSpeichern,
                                                  NameExtern     => UmwandlungenVerzeichnisse.Spielstandpfad (SpielstandarteExtern => Spielstandart,
                                                                                                              SpielstandnameExtern => Spielstandname));
         
         if
           False = SpeichernKarteLogik.Karte (DateiSpeichernExtern => DateiSpeichern,
                                              AutospeichernExtern  => AutospeichernExtern)
         then
            MeldungFestlegenLogik.MeldungFestlegen (MeldungExtern => TextnummernKonstanten.MeldungSpeichernFehlgeschlagen);
            
         elsif
           False = Allgemeines (DateiSpeichernExtern => DateiSpeichern)
         then
            MeldungFestlegenLogik.MeldungFestlegen (MeldungExtern => TextnummernKonstanten.MeldungSpeichernFehlgeschlagen);
            
         elsif
           False = SpezieswerteSpeichern (DateiSpeichernExtern => DateiSpeichern)
         then
            MeldungFestlegenLogik.MeldungFestlegen (MeldungExtern => TextnummernKonstanten.MeldungSpeichernFehlgeschlagen);
            
         else
            SpielstandAllgemeinesLogik.FortschrittErhöhen (AutospeichernExtern => AutospeichernExtern);
         end if;
            
         DateizugriffssystemHTSEB.SchließenStream (DateiartExtern => DateiSpeichern,
                                                    NameExtern     => UmwandlungenVerzeichnisse.Spielstandpfad (SpielstandarteExtern => Spielstandart,
                                                                                                                SpielstandnameExtern => Spielstandname));
         
         LadezeitenLogik.SpeichernLadenMaximum;

         case
           AutospeichernExtern
         is
            when True =>
               return;
            
            when False =>
               SchreibeGrafiktask.Darstellung (DarstellungExtern => GrafikDatentypen.Pause_Enum);
         end case;
         
      end loop SpeichernSchleife;
      
   exception
      when StandardAdaFehler : others =>
         MeldungFestlegenLogik.MeldungFestlegen (MeldungExtern => TextnummernKonstanten.MeldungSpeichernFehlgeschlagen);
         MeldungssystemHTSEB.Logik (MeldungExtern => "SpeichernLogik.Speichern: Konnte nicht gespeichert werden: "
                                    & UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
            
         DateizugriffssystemHTSEB.SchließenStream (DateiartExtern => DateiSpeichern,
                                                    NameExtern     => UmwandlungenVerzeichnisse.Spielstandpfad (SpielstandarteExtern => Spielstandart,
                                                                                                                SpielstandnameExtern => Spielstandname));
         
         case
           AutospeichernExtern
         is
            when True =>
               return;
            
            when False =>
               SchreibeGrafiktask.Darstellung (DarstellungExtern => GrafikDatentypen.Pause_Enum);
         end case;
         
   end Speichern;
   
   
   
   function Allgemeines
     (DateiSpeichernExtern : in File_Type)
      return Boolean
   is
      use Ada.Exceptions;
   begin
            
      SpielRecords.AllgemeinesRecord'Write (Stream (File => DateiSpeichernExtern),
                                            LeseAllgemeines.GanzerEintrag);
            
      SpielRecords.SpeziesbelegungArray'Write (Stream (File => DateiSpeichernExtern),
                                               LeseSpeziesbelegung.GanzesArray);
      
      return True;
      
   exception
      when StandardAdaFehler : others =>
         MeldungssystemHTSEB.Logik (MeldungExtern => "SpeichernLogik.Allgemeines: Konnte nicht gespeichert werden: "
                                     & UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         return False;
      
   end Allgemeines;
   
   
   
   function SpezieswerteSpeichern
     (DateiSpeichernExtern : in File_Type)
      return Boolean
   is begin
      
      SpeziesSchleife:
      for SpeziesSchleifenwert in SpeziesDatentypen.Spezies_Vorhanden_Enum'Range loop
         
         if
           LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesSchleifenwert) = SpeziesDatentypen.Leer_Spieler_Enum
         then
            null;
               
         elsif
           False = StädteEinheitenSpeichern (SpeziesExtern        => SpeziesSchleifenwert,
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
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      DateiSpeichernExtern : in File_Type)
      return Boolean
   is
      use Ada.Exceptions;
   begin
      
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
      
      EinheitenDatentypen.Einheitenbereich'Write (Stream (File => DateiSpeichernExtern),
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
      
      StadtDatentypen.Städtebereich'Write (Stream (File => DateiSpeichernExtern),
                                            VorhandeneStädte);
      
      StadtSchleife:
      for StadtSchleifenwert in StadtKonstanten.AnfangNummer .. VorhandeneStädte loop
                  
         StadtRecords.StadtGebautRecord'Write (Stream (File => DateiSpeichernExtern),
                                               LeseStadtGebaut.GanzerEintrag (StadtSpeziesNummerExtern => (SpeziesExtern, StadtSchleifenwert)));
            
      end loop StadtSchleife;
      
      return True;
      
   exception
      when StandardAdaFehler : others =>
         MeldungssystemHTSEB.Logik (MeldungExtern => "SpeichernLogik.StädteEinheitenSpeichern: Konnte nicht gespeichert werden: "
                                     & UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         return False;
      
   end StädteEinheitenSpeichern;
   
   
   
   function Spezieswerte
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      DateiSpeichernExtern : in File_Type)
      return Boolean
   is
      use type SpeziesDatentypen.Spezies_Enum;
      use Ada.Exceptions;
   begin
      
      DiplomatieSchleife:
      for DiplomatieSchleifenwert in SpeziesDatentypen.Spezies_Vorhanden_Enum'Range loop

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
            KartenRecords.ZeigerRecord'Write (Stream (File => DateiSpeichernExtern),
                                              LeseZeiger.GanzerEintrag (SpeziesExtern => SpeziesExtern));
            
         when others =>
            null;
      end case;
      
      return True;
      
   exception
      when StandardAdaFehler : others =>
         MeldungssystemHTSEB.Logik (MeldungExtern => "SpeichernLogik.Spezieswerte: Konnte nicht gespeichert werden: "
                                     & UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
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
         MaximalerAutospeichernwert := LeseOptionen.AnzahlAutospeichern;
         AktuellerAutospeichernwert := LeseOptionen.AktuellerAutospeichernwert;
         
         if
           AktuellerAutospeichernwert > MaximalerAutospeichernwert
         then
            SchreibeOptionen.AktuellerAutospeichernwert (AutospeichernwertExtern => MaximalerAutospeichernwert);
            
         else
            null;
         end if;
         
         Autospeichernname := To_Unbounded_Wide_Wide_String (Source => "Auto" & AktuellerAutospeichernwert'Wide_Wide_Image);
         
         if
           MaximalerAutospeichernwert = 1
         then
            null;

         elsif
           AktuellerAutospeichernwert < MaximalerAutospeichernwert
         then
            SchreibeOptionen.AktuellerAutospeichernwert (AutospeichernwertExtern => AktuellerAutospeichernwert + 1);
                  
         else
            SchreibeOptionen.AktuellerAutospeichernwert (AutospeichernwertExtern => 1);
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
            Speichern (AutospeichernExtern    => True,
                       NotfallspeichernExtern => False);
         
         when others =>
            null;
      end case;
      
   end AutoSpeichern;

end SpeichernLogik;

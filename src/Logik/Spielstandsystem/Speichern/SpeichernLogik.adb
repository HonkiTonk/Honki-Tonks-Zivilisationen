with Ada.Exceptions;

with DateizugriffssystemHTSEB;
with TextKonstantenHTSEB;
with MeldungssystemHTSEB;
with UmwandlungssystemHTSEB;

with GrafikDatentypen;
with VerzeichnisKonstanten;
with SpielstandlisteLogik;
with TextnummernKonstanten;

with LeseAllgemeines;
with LeseOptionen;
with SchreibeOptionen;
with SchreibeGrafiktask;
with LeseSpeziesbelegung;

with LadezeitenLogik;
with SpielstandAllgemeinesLogik;
with SpeichernKarteLogik;
with MeldungFestlegenLogik;
with UmwandlungenVerzeichnisse;
with SpeichernStaedteLogik;
with SpeichernEinheitenLogik;
with SpeichernDiplomatieLogik;
with SpeichernSpezienspezifischesLogik;
with SpeichernAllgemeinesLogik;

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
           Spielstandname = TextKonstantenHTSEB.LeerUnboundedString
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
         
         -- Wenn hier ein False auftritt auch die Datei löschen? äöü
         if
           False = SpeichernAllgemeinesLogik.Aufteilung (DateiSpeichernExtern => DateiSpeichern)
         then
            MeldungFestlegenLogik.MeldungFestlegen (MeldungExtern => TextnummernKonstanten.MeldungSpeichernFehlgeschlagen);
            
         elsif
           False = SpeichernKarteLogik.Karte (DateiSpeichernExtern => DateiSpeichern,
                                              AutospeichernExtern  => AutospeichernExtern)
         then
            MeldungFestlegenLogik.MeldungFestlegen (MeldungExtern => TextnummernKonstanten.MeldungSpeichernFehlgeschlagen);
            
         elsif
           False = Spezieswerte (DateiSpeichernExtern => DateiSpeichern)
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
   
   
   
   function Spezieswerte
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
           LeseSpeziesbelegung.Besiegt (SpeziesExtern => SpeziesSchleifenwert) = True
         then
            null;
            
         elsif
           False = SpeichernSpezienspezifischesLogik.Aufteilung (SpeziesExtern        => SpeziesSchleifenwert,
                                                                 DateiSpeichernExtern => DateiSpeichernExtern)
         then
            return False;
            
         elsif
           False = SpeichernEinheitenLogik.Einheiten (SpeziesExtern        => SpeziesSchleifenwert,
                                                      DateiSpeichernExtern => DateiSpeichernExtern)
         then
            return False;
            
         elsif
           False = SpeichernStaedteLogik.Städte (SpeziesExtern        => SpeziesSchleifenwert,
                                                  DateiSpeichernExtern => DateiSpeichernExtern)
         then
            return False;
           
         elsif
           False = SpeichernDiplomatieLogik.Diplomatie (SpeziesExtern        => SpeziesSchleifenwert,
                                                        DateiSpeichernExtern => DateiSpeichernExtern)
         then
            return False;
                  
         else
            null;
         end if;
         
      end loop SpeziesSchleife;
      
      return True;
      
   end Spezieswerte;
   
   
   
   function NameAutoSpeichern
     return Unbounded_Wide_Wide_String
   is begin
      
      if
        To_Wide_Wide_String (Source => LeseAllgemeines.Ironman) /= TextKonstantenHTSEB.LeerString
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

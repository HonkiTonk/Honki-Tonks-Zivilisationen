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

with LadezeitenLogik;
with SpeichernKarteLogik;
with MeldungFestlegenLogik;
with UmwandlungenVerzeichnisse;
with SpeichernAllgemeinesLogik;
with SpeichernSpeziesLogik;

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
            SchreibeGrafiktask.Dateiname (DateinameExtern => Spielstandname);
         end if;

         case
           AutospeichernExtern
         is
            when True =>
               Spielstandart := SystemDatentypenHTSEB.Automatischer_Spielstand_Enum;
            
            when False =>
               Spielstandart := SystemDatentypenHTSEB.Manueller_Spielstand_Enum;
         end case;
         
         LadezeitenLogik.SpielstandNullsetzen;
         SchreibeGrafiktask.Darstellung (DarstellungExtern => GrafikDatentypen.Speichern_Enum);
         
         DateizugriffssystemHTSEB.ErstellenStream (DateiartExtern => DateiSpeichern,
                                                   NameExtern     => UmwandlungenVerzeichnisse.Spielstandpfad (SpielstandarteExtern => Spielstandart,
                                                                                                               SpielstandnameExtern => Spielstandname));
         
         if
           False = SpeichernAllgemeinesLogik.Aufteilung (DateiSpeichernExtern => DateiSpeichern)
         then
            FehlerAufgetreten := True;
            MeldungFestlegenLogik.MeldungFestlegen (MeldungExtern => TextnummernKonstanten.MeldungSpeichernFehlgeschlagen);
            
         elsif
           False = SpeichernKarteLogik.Karte (DateiSpeichernExtern => DateiSpeichern)
         then
            FehlerAufgetreten := True;
            MeldungFestlegenLogik.MeldungFestlegen (MeldungExtern => TextnummernKonstanten.MeldungSpeichernFehlgeschlagen);
            
         elsif
           False = SpeichernSpeziesLogik.Spezieswerte (DateiSpeichernExtern => DateiSpeichern)
         then
            FehlerAufgetreten := True;
            MeldungFestlegenLogik.MeldungFestlegen (MeldungExtern => TextnummernKonstanten.MeldungSpeichernFehlgeschlagen);
            
         else
            FehlerAufgetreten := False;
         end if;
            
         DateizugriffssystemHTSEB.SchließenStream (DateiartExtern => DateiSpeichern,
                                                    NameExtern     => UmwandlungenVerzeichnisse.Spielstandpfad (SpielstandarteExtern => Spielstandart,
                                                                                                                SpielstandnameExtern => Spielstandname));
         
         case
           FehlerAufgetreten
         is
            when True =>
               DateizugriffssystemHTSEB.Löschen (NameExtern => UmwandlungenVerzeichnisse.Spielstandpfad (SpielstandarteExtern => Spielstandart,
                                                                                                          SpielstandnameExtern => Spielstandname));
               
            when False =>
               null;
         end case;

         case
           AutospeichernExtern
         is
            when True =>
               return;
            
            when False =>
               null;
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

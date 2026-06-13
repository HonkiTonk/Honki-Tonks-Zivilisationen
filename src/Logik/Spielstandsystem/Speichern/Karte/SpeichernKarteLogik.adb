with Ada.Exceptions; use Ada.Exceptions;

with MeldungssystemHTSEB;
with UmwandlungssystemHTSEB;
with SystemDatentypenHTSEB;

with KartenKonstanten;
with LadezeitenDatentypen;
with KartenRecords;

with LeseWeltkarteneinstellungen;

with SpielstandAllgemeinesLogik;
with SpeichernSichtbarkeitLogik;
with LadezeitenLogik;
with SpeichernBasisgrundLogik;
with SpeichernZusatzbelegungLogik;

-- Bei Änderungen am Speichersystem auch immer das Ladesystem anpassen!
package body SpeichernKarteLogik is

   function Karte
     (DateiSpeichernExtern : in File_Type;
      AutospeichernExtern : in Boolean)
      return Boolean
   is begin
      
      -- Wenn ich hier auch noch die Dicke und Art des Kartenrands mitspeichere, dann könnte ich das beim Speichern der Karte sparen, wäre vermutlich kleiner? äöü
      KartenRecords.PermanenteKartenparameterRecord'Write (Stream (File => DateiSpeichernExtern),
                                                           LeseWeltkarteneinstellungen.GesamteEinstellungen);
      
      FelderanzahlZusatzgrund := SystemDatentypenHTSEB.AchtElemente'First;
      SpeichernZusatzbelegungLogik.Leersetzung;
      
      VorhandeneSpezies := SpielstandAllgemeinesLogik.VorhandeneSpeziesanzahl (SpeichernLadenExtern => True);
      FelderanzahlSichtbarkeit := SystemDatentypenHTSEB.AchtElemente'First;
      SpeichernSichtbarkeitLogik.Leersetzung;
      GesamtgrößeSpezieszusammenfassung := 0;
      
      EbeneSchleife:
      -- Warum loope ich da nicht diekt über EbeneVorhanden'Range? äöü
      for EbeneSchleifenwert in KartenKonstanten.AnfangEbene .. KartenKonstanten.EndeEbene loop
         SenkrechteSchleife:
         for SenkrechteSchleifenwert in KartenKonstanten.AnfangSenkrechte .. LeseWeltkarteneinstellungen.Senkrechte loop
            WaagerechteSchleife:
            for WaagerechteSchleifenwert in KartenKonstanten.AnfangWaagerechte .. LeseWeltkarteneinstellungen.Waagerechte loop
               
               case
                 SpeichernBasisgrundLogik.Basisgrund (KoordinatenExtern    => (EbeneSchleifenwert, SenkrechteSchleifenwert, WaagerechteSchleifenwert),
                                                      DateiSpeichernExtern => DateiSpeichernExtern)
               is
                  when False =>
                     return False;
                     
                  when True =>
                     SpeichernZusatzbelegungLogik.ZusätzeAbfragen (KoordinatenExtern => (EbeneSchleifenwert, SenkrechteSchleifenwert, WaagerechteSchleifenwert),
                                                                    FelderanzahlExtern => FelderanzahlZusatzgrund);
                     
                     FelderanzahlZusatzgrund := FelderanzahlZusatzgrund + 1;
               end case;
               
               if
                 FelderanzahlZusatzgrund < SystemDatentypenHTSEB.AchtElemente'Last + 1
               then
                  null;
                  
               elsif
                 SpeichernZusatzbelegungLogik.Aufteilung (DateiSpeichernExtern => DateiSpeichernExtern) = False
               then
                  return False;
                        
               else
                  FelderanzahlZusatzgrund := SystemDatentypenHTSEB.AchtElemente'First;
                  SpeichernZusatzbelegungLogik.Leersetzung;
               end if;
               
               case
                 VorhandeneSpezies
               is
                  when 1 .. 8 =>
                     SpeichernSichtbarkeitLogik.Sichtbarkeitsbelegung (KoordinatenExtern  => (EbeneSchleifenwert, SenkrechteSchleifenwert, WaagerechteSchleifenwert),
                                                                       FelderanzahlExtern => FelderanzahlSichtbarkeit);
                     FelderanzahlSichtbarkeit := FelderanzahlSichtbarkeit + 1;
                     
                     if
                       FelderanzahlSichtbarkeit < SystemDatentypenHTSEB.AchtElemente'Last + 1
                     then
                        null;
                        
                     elsif
                       SpeichernSichtbarkeitLogik.Aufteilung (DateiSpeichernExtern => DateiSpeichernExtern) = False
                     then
                        return False;
                        
                     else
                        FelderanzahlSichtbarkeit := SystemDatentypenHTSEB.AchtElemente'First;
                        SpeichernSichtbarkeitLogik.Leersetzung;
                     end if;
                     
                  when 9 .. 18 =>
                     GesamtgrößeSpezieszusammenfassung := GesamtgrößeSpezieszusammenfassung
                       + SpeichernSichtbarkeitLogik.SpeicherverbrauchErmitteln (KoordinatenExtern       => (EbeneSchleifenwert, SenkrechteSchleifenwert, WaagerechteSchleifenwert),
                                                                                VorhandeneSpeziesExtern => VorhandeneSpezies);
               end case;
               
            end loop WaagerechteSchleife;
         end loop SenkrechteSchleife;
         
         case
           AutospeichernExtern
         is
            when False =>
               null;
               
            when True =>
               null;
               -- LadezeitenLogik.Speichern (WelcheBerechnungszeitExtern => LadezeitenDatentypen.Karte_Enum,
               --                            ErhöhungExtern              => 20);
         end case;
         
         -- SpielstandAllgemeinesLogik.FortschrittErhöhen (AutospeichernExtern => AutospeichernExtern);
         
      end loop EbeneSchleife;
      
      if
        FelderanzahlZusatzgrund = SystemDatentypenHTSEB.AchtElemente'First
      then
         null;
            
      elsif
        SpeichernZusatzbelegungLogik.Aufteilung (DateiSpeichernExtern => DateiSpeichernExtern) = False
      then
         return False;
                        
      else
         null;
      end if;
      
      case
        VorhandeneSpezies
      is
         when 1 .. 8 =>
            if
              FelderanzahlSichtbarkeit = SystemDatentypenHTSEB.AchtElemente'First
            then
               null;
            
            elsif
              SpeichernSichtbarkeitLogik.Aufteilung (DateiSpeichernExtern => DateiSpeichernExtern) = False
            then
               return False;
                        
            else
               null;
            end if;
            
            LadezeitenLogik.SpeichernMaximum (WelcheBerechnungszeitExtern => LadezeitenDatentypen.Karte_Enum);
      
            return True;
            
         when 9 .. 18 =>
            GesamteFelderanzahl := 5 * Positive (LeseWeltkarteneinstellungen.Senkrechte) * Positive (LeseWeltkarteneinstellungen.Waagerechte);
            ByteanzahlSiebenFelderzusammenfassung := Float'Ceiling (Float (GesamteFelderanzahl) / 7.00) * Float (VorhandeneSpezies);
      end case;
      
      if
        Positive (ByteanzahlSiebenFelderzusammenfassung) < GesamtgrößeSpezieszusammenfassung
      then
         SystemDatentypenHTSEB.EinByte'Write (Stream (File => DateiSpeichernExtern),
                                              1);
         return SiebenFelderzusammenfassung (DateiSpeichernExtern => DateiSpeichernExtern,
                                             AutospeichernExtern  => AutospeichernExtern);
                  
      else
         SystemDatentypenHTSEB.EinByte'Write (Stream (File => DateiSpeichernExtern),
                                              0);
         return Spezieszusammenfassung (DateiSpeichernExtern => DateiSpeichernExtern,
                                        AutospeichernExtern  => AutospeichernExtern);
      end if;
      
   exception
      when StandardAdaFehler : others =>
         MeldungssystemHTSEB.Logik (MeldungExtern => "SpeichernKarteLogik.Karte: Konnte nicht gespeichert werden: "
                                    & UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         return False;
         
   end Karte;
   
   
   
   function SiebenFelderzusammenfassung
     (DateiSpeichernExtern : in File_Type;
      AutospeichernExtern : in Boolean)
      return Boolean
   is begin
      
      FelderanzahlSichtbarkeit := SystemDatentypenHTSEB.AchtElemente'First;
      SpeichernSichtbarkeitLogik.Leersetzung;
      
      EbeneSchleife:
      -- Warum loope ich da nicht diekt über EbeneVorhanden'Range? äöü
      for EbeneSchleifenwert in KartenKonstanten.AnfangEbene .. KartenKonstanten.EndeEbene loop
         SenkrechteSchleife:
         for SenkrechteSchleifenwert in KartenKonstanten.AnfangSenkrechte .. LeseWeltkarteneinstellungen.Senkrechte loop
            WaagerechteSchleife:
            for WaagerechteSchleifenwert in KartenKonstanten.AnfangWaagerechte .. LeseWeltkarteneinstellungen.Waagerechte loop
               
               SpeichernSichtbarkeitLogik.Sichtbarkeitsbelegung (KoordinatenExtern  => (EbeneSchleifenwert, SenkrechteSchleifenwert, WaagerechteSchleifenwert),
                                                                 FelderanzahlExtern => FelderanzahlSichtbarkeit);
               FelderanzahlSichtbarkeit := FelderanzahlSichtbarkeit + 1;
                     
               if
                 FelderanzahlSichtbarkeit < SystemDatentypenHTSEB.AchtElemente'Last
               then
                  null;
                        
               elsif
                 SpeichernSichtbarkeitLogik.Aufteilung (DateiSpeichernExtern => DateiSpeichernExtern) = False
               then
                  return False;
                        
               else
                  FelderanzahlSichtbarkeit := SystemDatentypenHTSEB.AchtElemente'First;
                  SpeichernSichtbarkeitLogik.Leersetzung;
               end if;
               
            end loop WaagerechteSchleife;
         end loop SenkrechteSchleife;
         
         case
           AutospeichernExtern
         is
            when False =>
               null;
               
            when True =>
               null;
               -- LadezeitenLogik.Speichern (WelcheBerechnungszeitExtern => LadezeitenDatentypen.Karte_Enum,
               --                             ErhöhungExtern              => 20);
         end case;
         
         -- SpielstandAllgemeinesLogik.FortschrittErhöhen (AutospeichernExtern => AutospeichernExtern);
         
      end loop EbeneSchleife;
      
      if
        FelderanzahlSichtbarkeit = SystemDatentypenHTSEB.AchtElemente'First
      then
         null;
            
      elsif
        SpeichernSichtbarkeitLogik.Aufteilung (DateiSpeichernExtern => DateiSpeichernExtern) = False
      then
         return False;
                        
      else
         null;
      end if;
            
      LadezeitenLogik.SpeichernMaximum (WelcheBerechnungszeitExtern => LadezeitenDatentypen.Karte_Enum);
      
      return True;
      
   exception
      when StandardAdaFehler : others =>
         MeldungssystemHTSEB.Logik (MeldungExtern => "SpeichernKarteLogik.SiebenFelderzusammenfassung: Konnte nicht gespeichert werden: "
                                    & UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         return False;
      
   end SiebenFelderzusammenfassung;
   
   
   
   function Spezieszusammenfassung
     (DateiSpeichernExtern : in File_Type;
      AutospeichernExtern : in Boolean)
      return Boolean
   is begin
      
      EbeneSchleife:
      -- Warum loope ich da nicht diekt über EbeneVorhanden'Range? äöü
      for EbeneSchleifenwert in KartenKonstanten.AnfangEbene .. KartenKonstanten.EndeEbene loop
         SenkrechteSchleife:
         for SenkrechteSchleifenwert in KartenKonstanten.AnfangSenkrechte .. LeseWeltkarteneinstellungen.Senkrechte loop
            WaagerechteSchleife:
            for WaagerechteSchleifenwert in KartenKonstanten.AnfangWaagerechte .. LeseWeltkarteneinstellungen.Waagerechte loop
               
               case
                 SpeichernSichtbarkeitLogik.SichtbarkeitVorzeichen (KoordinatenExtern       => (EbeneSchleifenwert, SenkrechteSchleifenwert, WaagerechteSchleifenwert),
                                                                    VorhandeneSpeziesExtern => VorhandeneSpezies,
                                                                    DateiSpeichernExtern    => DateiSpeichernExtern)
               is
                  when False =>
                     return False;
                     
                  when True =>
                     null;
               end case;
               
            end loop WaagerechteSchleife;
         end loop SenkrechteSchleife;
         
         case
           AutospeichernExtern
         is
            when False =>
               null;
               
            when True =>
               null;
               --      LadezeitenLogik.Speichern (WelcheBerechnungszeitExtern => LadezeitenDatentypen.Karte_Enum,
               --                                  ErhöhungExtern              => 20);
         end case;
         
         -- SpielstandAllgemeinesLogik.FortschrittErhöhen (AutospeichernExtern => AutospeichernExtern);
         
      end loop EbeneSchleife;
            
      LadezeitenLogik.SpeichernMaximum (WelcheBerechnungszeitExtern => LadezeitenDatentypen.Karte_Enum);
      
      return True;
      
   exception
      when StandardAdaFehler : others =>
         MeldungssystemHTSEB.Logik (MeldungExtern => "SpeichernKarteLogik.Spezieszusammenfassung: Konnte nicht gespeichert werden: "
                                    & UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         return False;
      
   end Spezieszusammenfassung;

end SpeichernKarteLogik;

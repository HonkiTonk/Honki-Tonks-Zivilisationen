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
      
      VorhandeneSpezies := SpielstandAllgemeinesLogik.VorhandeneSpeziesanzahl (SpeichernLadenExtern => True);
      
      AnzahlFelder := SystemDatentypenHTSEB.AchtElemente'First;
      SpeichernZusatzbelegungLogik.Leersetzung;
      
      EbeneSchleife:
      -- Warum loope ich da nicht diekt über EbeneVorhanden'Range? äöü
      for EbeneSchleifenwert in KartenKonstanten.AnfangEbene .. KartenKonstanten.EndeEbene loop
         SenkrechteSchleife:
         for SenkrechteSchleifenwert in KartenKonstanten.AnfangSenkrechte .. LeseWeltkarteneinstellungen.Senkrechte loop
            WaagerechteSchleife:
            for WaagerechteSchleifenwert in KartenKonstanten.AnfangWaagerechte .. LeseWeltkarteneinstellungen.Waagerechte loop
               
               if
                 False = SpeichernSichtbarkeitLogik.Aufteilung (KoordinatenExtern       => (EbeneSchleifenwert, SenkrechteSchleifenwert, WaagerechteSchleifenwert),
                                                                VorhandeneSpeziesExtern => VorhandeneSpezies,
                                                                DateiSpeichernExtern    => DateiSpeichernExtern)
               then
                  return False;
                  
               elsif
                 False = SpeichernBasisgrundLogik.Basisgrund (KoordinatenExtern    => (EbeneSchleifenwert, SenkrechteSchleifenwert, WaagerechteSchleifenwert),
                                                              DateiSpeichernExtern => DateiSpeichernExtern)
               then
                  return False;
                  
               else
                  SpeichernZusatzbelegungLogik.ZusätzeAbfragen (KoordinatenExtern => (EbeneSchleifenwert, SenkrechteSchleifenwert, WaagerechteSchleifenwert),
                                                                 FelderanzahlExtern => AnzahlFelder);
                  
                  AnzahlFelder := AnzahlFelder + 1;
               end if;
               
               case
                 AnzahlFelder
               is
                  when SystemDatentypenHTSEB.AchtElemente'Last + 1 =>
                     if
                       SpeichernZusatzbelegungLogik.Aufteilung (DateiSpeichernExtern => DateiSpeichernExtern) = False
                     then
                        return False;
                        
                     else
                        AnzahlFelder := SystemDatentypenHTSEB.AchtElemente'First;
                        SpeichernZusatzbelegungLogik.Leersetzung;
                     end if;
                     
                  when others =>
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
               LadezeitenLogik.Speichern (WelcheBerechnungszeitExtern => LadezeitenDatentypen.Karte_Enum,
                                          ErhöhungExtern              => 20);
         end case;
         
         SpielstandAllgemeinesLogik.FortschrittErhöhen (AutospeichernExtern => AutospeichernExtern);
         
      end loop EbeneSchleife;
      
      case
        AnzahlFelder
      is
         when SystemDatentypenHTSEB.AchtElemente'First =>
            null;
            
         when others =>
            if
              SpeichernZusatzbelegungLogik.Aufteilung (DateiSpeichernExtern => DateiSpeichernExtern) = False
            then
               return False;
                        
            else
               null;
            end if;
      end case;
      
      LadezeitenLogik.SpeichernMaximum (WelcheBerechnungszeitExtern => LadezeitenDatentypen.Karte_Enum);
      
      return True;
      
   exception
      when StandardAdaFehler : others =>
         MeldungssystemHTSEB.Logik (MeldungExtern => "SpeichernKarteLogik.Karte: Konnte nicht gespeichert werden: "
                                    & UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         return False;
         
   end Karte;

end SpeichernKarteLogik;

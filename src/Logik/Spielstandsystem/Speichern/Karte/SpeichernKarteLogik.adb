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

-- with DiagnosesystemHTSEB;

-- Bei Änderungen am Speichersystem auch immer das Ladesystem anpassen!
package body SpeichernKarteLogik is

   function Karte
     (DateiSpeichernExtern : in File_Type)
      return Boolean
   is begin
      
      -- Wenn ich hier auch noch die Dicke und Art des Kartenrands mitspeichere, dann könnte ich das beim Speichern der Karte sparen, wäre vermutlich kleiner? äöü
      -- Wobei ich ja immer noch den Zusatzscheiß speichern muss, da der ja änderbar ist, bringt dass denn viel? äöü
      KartenRecords.PermanenteKartenparameterRecord'Write (Stream (File => DateiSpeichernExtern),
                                                           LeseWeltkarteneinstellungen.GesamteEinstellungen);
      
      FelderanzahlZusatzgrund := SystemDatentypenHTSEB.AchtElemente'First;
      SpeichernZusatzbelegungLogik.Leersetzung;
      
      FelderanzahlSichtbarkeit := SystemDatentypenHTSEB.AchtElemente'First;
      SichtbarkeitFelderreiheFestgelegt := (others => (others => False));
      
      VorhandeneSpezies := SpielstandAllgemeinesLogik.VorhandeneSpeziesanzahl (SpeichernLadenExtern => True);
      GesamtgrößeSpezieszusammenfassung := 0;
      
      SpeicherzeitKarteBasiswert := 100.00 / (5.00 * Float (LeseWeltkarteneinstellungen.Senkrechte));
      SpeicherzeitKarte := SpeicherzeitKarteBasiswert;
      
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
                 FelderanzahlZusatzgrund <= SystemDatentypenHTSEB.AchtElemente'Last
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
                     SichtbarkeitFelderreiheFestgelegt
                       := SpeichernSichtbarkeitLogik.SichtbarkeitsbelegungFelderreihe (AktuelleSichtbarkeitFelderbelegungExtern => SichtbarkeitFelderreiheFestgelegt,
                                                                                       KoordinatenExtern                        => (EbeneSchleifenwert, SenkrechteSchleifenwert, WaagerechteSchleifenwert),
                                                                                       FelderanzahlExtern                       => FelderanzahlSichtbarkeit);
                     FelderanzahlSichtbarkeit := FelderanzahlSichtbarkeit + 1;
                     
                     if
                       FelderanzahlSichtbarkeit <= SystemDatentypenHTSEB.AchtElemente'Last
                     then
                        null;
                        
                     elsif
                       False = SpeichernSichtbarkeitLogik.Felderreihe (DateiSpeichernExtern => DateiSpeichernExtern,
                                                                       SichtbarkeitExtern   => SichtbarkeitFelderreiheFestgelegt)
                     then
                        return False;
                        
                     else
                        FelderanzahlSichtbarkeit := SystemDatentypenHTSEB.AchtElemente'First;
                        SichtbarkeitFelderreiheFestgelegt := (others => (others => False));
                     end if;
                     
                  when 9 .. 18 =>
                     GesamtgrößeSpezieszusammenfassung := GesamtgrößeSpezieszusammenfassung
                       + SpeichernSichtbarkeitLogik.SpeicherverbrauchErmitteln (KoordinatenExtern       => (EbeneSchleifenwert, SenkrechteSchleifenwert, WaagerechteSchleifenwert),
                                                                                VorhandeneSpeziesExtern => VorhandeneSpezies);
               end case;
               
            end loop WaagerechteSchleife;
         
            LadezeitenLogik.Speichern (WelcheBerechnungszeitExtern => LadezeitenDatentypen.Karte_Enum,
                                       ErhöhungExtern              => SystemDatentypenHTSEB.NullBisHundert (SpeicherzeitKarte),
                                       SetzenExtern                => True);
            
            SpeicherzeitKarte := SpeicherzeitKarte + SpeicherzeitKarteBasiswert;
            
            if
              SpeicherzeitKarte > 100.00
            then
               SpeicherzeitKarte := 100.00;
               
            else
               null;
            end if;
            
         end loop SenkrechteSchleife;
      end loop EbeneSchleife;
            
      LadezeitenLogik.SpeichernMaximum (WelcheBerechnungszeitExtern => LadezeitenDatentypen.Karte_Enum);
      
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
              False = SpeichernSichtbarkeitLogik.Felderreihe (DateiSpeichernExtern => DateiSpeichernExtern,
                                                              SichtbarkeitExtern   => SichtbarkeitFelderreiheFestgelegt)
            then
               return False;
                        
            else
               null;
            end if;
      
            return True;
            
         when 9 .. 18 =>
            GesamteFelderanzahl := 5 * Positive (LeseWeltkarteneinstellungen.Senkrechte) * Positive (LeseWeltkarteneinstellungen.Waagerechte);
            ByteanzahlAchtFelderzusammenfassung := Float'Ceiling (Float (GesamteFelderanzahl) / 8.00) * Float (VorhandeneSpezies);
      end case;
      
      -- Die 0/1 in ein Enum umbasteln? äöü
      if
        Positive (ByteanzahlAchtFelderzusammenfassung) < GesamtgrößeSpezieszusammenfassung
      then
         SystemDatentypenHTSEB.EinByte'Write (Stream (File => DateiSpeichernExtern),
                                              0);
         return Felderzusammenfassung (DateiSpeichernExtern => DateiSpeichernExtern);
                  
      else
         SystemDatentypenHTSEB.EinByte'Write (Stream (File => DateiSpeichernExtern),
                                              1);
         return Spezieszusammenfassung (DateiSpeichernExtern => DateiSpeichernExtern);
      end if;
      
   exception
      when StandardAdaFehler : others =>
         MeldungssystemHTSEB.Logik (MeldungExtern => "SpeichernKarteLogik.Karte: Konnte nicht gespeichert werden: "
                                    & UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         return False;
         
   end Karte;
   
   
   
   function Felderzusammenfassung
     (DateiSpeichernExtern : in File_Type)
      return Boolean
   is begin
      
      FelderanzahlSichtbarkeit := SystemDatentypenHTSEB.AchtElemente'First;
      SichtbarkeitFelderreiheFestgelegt := (others => (others => False));
      
      EbeneSchleife:
      -- Warum loope ich da nicht diekt über EbeneVorhanden'Range? äöü
      for EbeneSchleifenwert in KartenKonstanten.AnfangEbene .. KartenKonstanten.EndeEbene loop
         SenkrechteSchleife:
         for SenkrechteSchleifenwert in KartenKonstanten.AnfangSenkrechte .. LeseWeltkarteneinstellungen.Senkrechte loop
            WaagerechteSchleife:
            for WaagerechteSchleifenwert in KartenKonstanten.AnfangWaagerechte .. LeseWeltkarteneinstellungen.Waagerechte loop
               
               SichtbarkeitFelderreiheFestgelegt
                 := SpeichernSichtbarkeitLogik.SichtbarkeitsbelegungFelderreihe (AktuelleSichtbarkeitFelderbelegungExtern => SichtbarkeitFelderreiheFestgelegt,
                                                                                 KoordinatenExtern                        => (EbeneSchleifenwert, SenkrechteSchleifenwert, WaagerechteSchleifenwert),
                                                                                 FelderanzahlExtern                       => FelderanzahlSichtbarkeit);
               FelderanzahlSichtbarkeit := FelderanzahlSichtbarkeit + 1;
                     
               if
                 FelderanzahlSichtbarkeit <= SystemDatentypenHTSEB.AchtElemente'Last
               then
                  null;
                        
               elsif
                 False = SpeichernSichtbarkeitLogik.Felderreihe (DateiSpeichernExtern => DateiSpeichernExtern,
                                                                 SichtbarkeitExtern   => SichtbarkeitFelderreiheFestgelegt)
               then
                  return False;
                  
               else
                  FelderanzahlSichtbarkeit := SystemDatentypenHTSEB.AchtElemente'First;
                  SichtbarkeitFelderreiheFestgelegt := (others => (others => False));
               end if;
               
            end loop WaagerechteSchleife;
         end loop SenkrechteSchleife;
         
      end loop EbeneSchleife;
      
      if
        FelderanzahlSichtbarkeit = SystemDatentypenHTSEB.AchtElemente'First
      then
         null;
            
      elsif
        False = SpeichernSichtbarkeitLogik.Felderreihe (DateiSpeichernExtern => DateiSpeichernExtern,
                                                        SichtbarkeitExtern   => SichtbarkeitFelderreiheFestgelegt)
      then
         return False;
                        
      else
         null;
      end if;
      
      return True;
      
   exception
      when StandardAdaFehler : others =>
         MeldungssystemHTSEB.Logik (MeldungExtern => "SpeichernKarteLogik.Felderzusammenfassung: Konnte nicht gespeichert werden: "
                                    & UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         return False;
      
   end Felderzusammenfassung;
   
   
   
   function Spezieszusammenfassung
     (DateiSpeichernExtern : in File_Type)
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
                 SpeichernSichtbarkeitLogik.Spezieszeile (KoordinatenExtern       => (EbeneSchleifenwert, SenkrechteSchleifenwert, WaagerechteSchleifenwert),
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
         
      end loop EbeneSchleife;
      
      return True;
      
   exception
      when StandardAdaFehler : others =>
         MeldungssystemHTSEB.Logik (MeldungExtern => "SpeichernKarteLogik.Spezieszusammenfassung: Konnte nicht gespeichert werden: "
                                    & UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         return False;
      
   end Spezieszusammenfassung;

end SpeichernKarteLogik;

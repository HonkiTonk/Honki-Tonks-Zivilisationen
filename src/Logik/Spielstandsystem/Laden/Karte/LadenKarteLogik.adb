with Ada.Exceptions; use Ada.Exceptions;

with MeldungssystemHTSEB;
with UmwandlungssystemHTSEB;

with KartenKonstanten;
with SchreibeWeltkarteneinstellungen;

with LadezeitenLogik;
with LadenSichtbarkeitLogik;
with SpielstandAllgemeinesLogik;
with LadenBasisgrundLogik;
with LadenZusatzbelegungLogik;

-- Bei Änderungen am Ladesystem auch immer das Speichersystem anpassen!
package body LadenKarteLogik is
   
   function KarteLaden
     (LadenPrüfenExtern : in Boolean;
      DateiLadenExtern : in File_Type)
      return Boolean
   is begin
      
      KartenRecords.PermanenteKartenparameterRecord'Read (Stream (File => DateiLadenExtern),
                                                          Karteneinstellungen);
      
      VorhandeneSpezies := SpielstandAllgemeinesLogik.VorhandeneSpeziesanzahl (SpeichernLadenExtern => False);
      
      case
        LadenPrüfenExtern
      is
         when True =>
            SchreibeWeltkarteneinstellungen.GesamteEinstellungen (EinstellungenExtern => Karteneinstellungen);
            
         when False =>
            null;
      end case;
      
      FelderanzahlZusatzgrund := SystemDatentypenHTSEB.AchtElemente'First;
      FelderanzahlSichtbarkeit := SystemDatentypenHTSEB.AchtElemente'First;
      -- Ich muss das doch jedes Mal auf null setzen, oder? äöü
      -- Und auch beim Schreiben muss ich aufpassen dass ich nur die richtigen Werte setze und vorher auf null setzen. äöü
      LadenZusatzbelegungLogik.Leersetzung;
      LadenSichtbarkeitLogik.Leersetzung;
      
      EbeneSchleife:
      for EbeneSchleifenwert in KartenKonstanten.AnfangEbene .. KartenKonstanten.EndeEbene loop
         SenkrechteSchleife:
         for SenkrechteSchleifenwert in KartenKonstanten.AnfangSenkrechte .. Karteneinstellungen.Kartengröße.Senkrechte loop
            WaagerechteSchleife:
            for WaagerechteSchleifenwert in KartenKonstanten.AnfangWaagerechte .. Karteneinstellungen.Kartengröße.Waagerechte loop
               
               case
                 LadenBasisgrundLogik.BasisgrundEinlesen (DateiLadenExtern  => DateiLadenExtern,
                                                          KoordinatenExtern => (EbeneSchleifenwert, SenkrechteSchleifenwert, WaagerechteSchleifenwert),
                                                          KartenfeldExtern  => Karteneinstellungen.Kartengröße,
                                                          LadenPrüfenExtern => LadenPrüfenExtern)
               is
                  when False =>
                     return False;
                     
                  when True =>
                     LadenZusatzbelegungLogik.KoordinatenSetzen (KoordinatenExtern  => (EbeneSchleifenwert, SenkrechteSchleifenwert, WaagerechteSchleifenwert),
                                                                 FelderanzahlExtern => FelderanzahlZusatzgrund);
                     FelderanzahlZusatzgrund := FelderanzahlZusatzgrund + 1;
               end case;
               
               case
                 FelderanzahlZusatzgrund
               is
                  when SystemDatentypenHTSEB.AchtElemente'Last + 1 =>
                     if
                       False = LadenZusatzbelegungLogik.Aufteilung (DateiLadenExtern  => DateiLadenExtern,
                                                                    LadenPrüfenExtern => LadenPrüfenExtern)
                     then
                        return False;
                                               
                     else
                        FelderanzahlZusatzgrund := SystemDatentypenHTSEB.AchtElemente'First;
                        LadenZusatzbelegungLogik.Leersetzung;
                     end if;
                     
                  when others =>
                     null;
               end case;
               
               case
                 VorhandeneSpezies
               is
                  when 1 .. 8 =>
                     LadenSichtbarkeitLogik.KoordinatenSetzen (KoordinatenExtern  => (EbeneSchleifenwert, SenkrechteSchleifenwert, WaagerechteSchleifenwert),
                                                               FelderanzahlExtern => FelderanzahlSichtbarkeit);
                     FelderanzahlSichtbarkeit := FelderanzahlSichtbarkeit + 1;
                     
                     if
                       FelderanzahlSichtbarkeit = SystemDatentypenHTSEB.AchtElemente'Last + 1
                     then
                        if
                          False = LadenSichtbarkeitLogik.Aufteilung (DateiLadenExtern        => DateiLadenExtern,
                                                                     LadenPrüfenExtern       => LadenPrüfenExtern)
                        then
                           return False;
                           
                        else
                           FelderanzahlSichtbarkeit := SystemDatentypenHTSEB.AchtElemente'First;
                           LadenSichtbarkeitLogik.Leersetzung;
                        end if;
                        
                     else
                        null;
                     end if;
                     
                  when others =>
                     null;
               end case;
                                                            
            end loop WaagerechteSchleife;
         end loop SenkrechteSchleife;
         
         LadezeitenLogik.SpeichernLadenSchreiben (SpeichernLadenExtern => False);
         
      end loop EbeneSchleife;
      
      case
        FelderanzahlZusatzgrund
      is
         when SystemDatentypenHTSEB.AchtElemente'First =>
            null;
            
         when others =>
            if
              False = LadenZusatzbelegungLogik.Aufteilung (DateiLadenExtern  => DateiLadenExtern,
                                                           LadenPrüfenExtern => LadenPrüfenExtern)
            then
               return False;
                                               
            else
               null;
            end if;
      end case;
      
      case
        VorhandeneSpezies
      is
         when 1 .. 8 =>
            return True;
            
         when others =>
            SystemDatentypenHTSEB.EinByte'Read (Stream (File => DateiLadenExtern),
                                                SichtbarkeitLadeaufteilung);
      end case;
      
      case
        SichtbarkeitLadeaufteilung
      is
         when 0 =>
            ZweiteEbeneSchleife:
            -- Warum loope ich da nicht diekt über EbeneVorhanden'Range? äöü
            for ZweiteEbeneSchleifenwert in KartenKonstanten.AnfangEbene .. KartenKonstanten.EndeEbene loop
               ZweiteSenkrechteSchleife:
               for ZweiteSenkrechteSchleifenwert in KartenKonstanten.AnfangSenkrechte .. Karteneinstellungen.Kartengröße.Senkrechte loop
                  ZweiteWaagerechteSchleife:
                  for ZweiteWaagerechteSchleifenwert in KartenKonstanten.AnfangWaagerechte .. Karteneinstellungen.Kartengröße.Waagerechte loop
               
                     case
                       LadenSichtbarkeitLogik.AufteilungSpezienzusammenfassung (DateiLadenExtern        => DateiLadenExtern,
                                                                                KoordinatenExtern       => (ZweiteEbeneSchleifenwert, ZweiteSenkrechteSchleifenwert, ZweiteWaagerechteSchleifenwert),
                                                                                VorhandeneSpeziesExtern => VorhandeneSpezies,
                                                                                LadenPrüfenExtern       => LadenPrüfenExtern)
                     is
                        when False =>
                           return False;
                     
                        when True =>
                           null;
                     end case;
               
                  end loop ZweiteWaagerechteSchleife;
               end loop ZweiteSenkrechteSchleife;
            end loop ZweiteEbeneSchleife;
            
         when 1 =>
            null;
            
         when others =>
            return False;
      end case;
            
      return True;
      
   exception
      when StandardAdaFehler : others =>
         MeldungssystemHTSEB.Logik (MeldungExtern => "LadenKarteLogik.KarteLaden: Konnte nicht geladen werden: LadenPrüfenExtern = " & LadenPrüfenExtern'Wide_Wide_Image & " "
                                    & UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         return False;
      
   end KarteLaden;

end LadenKarteLogik;

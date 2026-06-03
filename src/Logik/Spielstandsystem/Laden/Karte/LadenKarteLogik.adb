with Ada.Exceptions; use Ada.Exceptions;

with MeldungssystemHTSEB;
with UmwandlungssystemHTSEB;
with SystemDatentypenHTSEB;

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
      
      AnzahlFelder := SystemDatentypenHTSEB.AchtElemente'First;
      -- Ich muss das doch jedes Mal fauf null setzen, oder? äöü
      -- Und auch beim Schreiben muss ich aufpassen dass ich nur die richtigen Werte setze und vorher auf null setzen. äöü
      LadenZusatzbelegungLogik.Leersetzung;
      
      EbeneSchleife:
      for EbeneSchleifenwert in KartenKonstanten.AnfangEbene .. KartenKonstanten.EndeEbene loop
         SenkrechteSchleife:
         for SenkrechteSchleifenwert in KartenKonstanten.AnfangSenkrechte .. Karteneinstellungen.Kartengröße.Senkrechte loop
            WaagerechteSchleife:
            for WaagerechteSchleifenwert in KartenKonstanten.AnfangWaagerechte .. Karteneinstellungen.Kartengröße.Waagerechte loop
               
               if
                 False = LadenSichtbarkeitLogik.Aufteilung (DateiLadenExtern        => DateiLadenExtern,
                                                            KoordinatenExtern       => (EbeneSchleifenwert, SenkrechteSchleifenwert, WaagerechteSchleifenwert),
                                                            VorhandeneSpeziesExtern => VorhandeneSpezies,
                                                            LadenPrüfenExtern       => LadenPrüfenExtern)
               then
                  return False;
                  
               elsif
                 False = LadenBasisgrundLogik.BasisgrundEinlesen (DateiLadenExtern  => DateiLadenExtern,
                                                                  KoordinatenExtern => (EbeneSchleifenwert, SenkrechteSchleifenwert, WaagerechteSchleifenwert),
                                                                  LadenPrüfenExtern => LadenPrüfenExtern)
               then
                  return False;
                  
               else
                  LadenZusatzbelegungLogik.KoordinatenSetzen (KoordinatenExtern  => (EbeneSchleifenwert, SenkrechteSchleifenwert, WaagerechteSchleifenwert),
                                                              FelderanzahlExtern => AnzahlFelder);
                  AnzahlFelder := AnzahlFelder + 1;
               end if;
               
               case
                 AnzahlFelder
               is
                  when SystemDatentypenHTSEB.AchtElemente'Last + 1 =>
                     if
                       False = LadenZusatzbelegungLogik.Aufteilung (DateiLadenExtern  => DateiLadenExtern,
                                                                    LadenPrüfenExtern => LadenPrüfenExtern)
                     then
                        return False;
                                               
                     else
                        AnzahlFelder := SystemDatentypenHTSEB.AchtElemente'First;
                        LadenZusatzbelegungLogik.Leersetzung;
                     end if;
                     
                  when others =>
                     null;
               end case;
                                                            
            end loop WaagerechteSchleife;
         end loop SenkrechteSchleife;
         
         LadezeitenLogik.SpeichernLadenSchreiben (SpeichernLadenExtern => False);
         
      end loop EbeneSchleife;
      
      case
        AnzahlFelder
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
            
      return True;
      
   exception
      when StandardAdaFehler : others =>
         MeldungssystemHTSEB.Logik (MeldungExtern => "LadenKarteLogik.KarteLaden: Konnte nicht geladen werden: LadenPrüfenExtern = " & LadenPrüfenExtern'Wide_Wide_Image & " "
                                    & UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         return False;
      
   end KarteLaden;

end LadenKarteLogik;

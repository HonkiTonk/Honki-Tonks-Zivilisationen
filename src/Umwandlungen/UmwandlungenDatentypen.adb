with EinheitenDatentypen;
with StadtDatentypen;
with AuswahlKonstanten;

with Grafiktask;

package body UmwandlungenDatentypen is

   function BefehleNachKartenverbesserung
     (TasteExtern : in BefehleDatentypen.Siedler_Konstruktionen_Enum)
      return KartenverbesserungDatentypen.Verbesserungen_Gebilde_Enum
   is begin
      
      return BefehleKartenverbesserung (TasteExtern);
      
   end BefehleNachKartenverbesserung;
   
   
   
   function RückgabeNachSpezies
     (RückgabeExtern : in RueckgabeDatentypen.Spezies_Verwendet_Enum)
      return SpeziesDatentypen.Spezies_Vorhanden_Enum
   is begin
      
      return RückgabeSpezies (RückgabeExtern);
      
   end RückgabeNachSpezies;
   
   
   
   function KartentemperaturrückgabeNachKartentemperatur
     (RückgabeExtern : in RueckgabeDatentypen.Kartentemperatur_Enum)
      return KartenartDatentypen.Kartentemperatur_Enum
   is begin
      
      return KartentemperaturrückgabeKartentemperatur (RückgabeExtern);
      
   end KartentemperaturrückgabeNachKartentemperatur;
   
   
   
   function KartenrohstofferückgabeNachKartenRohstoff
     (RückgabeExtern : in RueckgabeDatentypen.Kartenrohstoffe_Enum)
      return KartenrohstoffeDatentypen.Rohstoffanzahl_Enum
   is begin
      
      return KartenrohstofferückgabeKartenRohstoff (RückgabeExtern);
      
   end KartenrohstofferückgabeNachKartenRohstoff;
   
   
   
   function RückgabeNachSchwierigkeitsgrad
     (RückgabeExtern : in RueckgabeDatentypen.Schwierigkeitsgrad_Enum)
      return SpielDatentypen.Schwierigkeitsgrad_Enum
   is begin
      
      return RückgabeSchwierigkeitsgrad (RückgabeExtern);
      
   end RückgabeNachSchwierigkeitsgrad;
   
   
   
   -- Das hier noch in eine eigene Datei verschieben? Eventuell aufteilen in Pur und nicht Pure? äöü
   function AuswahlBauprojekt
     (AuswahlExtern : in Integer)
      return StadtRecords.BauprojektRecord
   is begin
      
      case
        Grafiktask.WelchesBaumenü
      is
         when StadtDatentypen.Gebäudeart_Enum =>
            return (StadtDatentypen.GebäudeIDBasis (AuswahlExtern), EinheitenDatentypen.EinheitenIDBasis (AuswahlKonstanten.LeerAuswahl));
               
         when StadtDatentypen.Einheitenart_Enum =>
            return (StadtDatentypen.GebäudeIDBasis (AuswahlKonstanten.LeerAuswahl), EinheitenDatentypen.EinheitenIDBasis (AuswahlExtern));
      end case;
      
   end AuswahlBauprojekt;

end UmwandlungenDatentypen;

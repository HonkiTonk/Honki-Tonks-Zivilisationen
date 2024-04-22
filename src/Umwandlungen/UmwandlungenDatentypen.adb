with EinheitenDatentypen;
with StadtDatentypen;
with AuswahlKonstanten;

with Grafiktask;

package body UmwandlungenDatentypen is

   function BefehleNachKartenverbesserung
     (TasteExtern : in BefehleDatentypen.Siedler_Konstruktionen_Enum)
      return KartenverbesserungDatentypen.Verbesserung_Gebilde_Enum
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
   
   
   
   function KartenressourcenrückgabeNachKartenressource
     (RückgabeExtern : in RueckgabeDatentypen.Kartenressourcen_Enum)
      return KartenartDatentypen.Kartenressourcenmenge_Enum
   is begin
      
      return KartenressourcenrückgabeKartenressource (RückgabeExtern);
      
   end KartenressourcenrückgabeNachKartenressource;
   
   
   
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
            return (StadtDatentypen.GebäudeID (AuswahlExtern), EinheitenDatentypen.EinheitenID (AuswahlKonstanten.LeerAuswahl));
               
         when StadtDatentypen.Einheitenart_Enum =>
            return (StadtDatentypen.GebäudeID (AuswahlKonstanten.LeerAuswahl), EinheitenDatentypen.EinheitenID (AuswahlExtern));
      end case;
      
   end AuswahlBauprojekt;

end UmwandlungenDatentypen;

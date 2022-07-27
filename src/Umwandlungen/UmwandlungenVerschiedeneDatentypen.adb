pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

package body UmwandlungenVerschiedeneDatentypen is

   function TastenbelegungNachKartenverbesserung
     (TasteExtern : in TastenbelegungDatentypen.Tastenbelegung_Konstruktionen_Enum)
      return KartenVerbesserungDatentypen.Karten_Verbesserung_Gebilde_Enum
   is begin
      
      return TastenbelegungKartenverbesserung (TasteExtern);
      
   end TastenbelegungNachKartenverbesserung;
   
   
   
   function KartenverbesserungNachTastenbelegung
     (VerbesserungExtern : in KartenVerbesserungDatentypen.Karten_Verbesserung_Gebilde_Enum)
      return TastenbelegungDatentypen.Tastenbelegung_Konstruktionen_Enum
   is begin
      
      return KartenverbesserungTastenbelegung (VerbesserungExtern);
      
   end KartenverbesserungNachTastenbelegung;
   
   
   
   function RückgabeNachRasse
     (RückgabeExtern : in RueckgabeDatentypen.Rassen_Verwendet_Enum)
      return RassenDatentypen.Rassen_Verwendet_Enum
   is begin
      
      return RückgabeRasse (RückgabeExtern);
      
   end RückgabeNachRasse;
   
   
   
   function KartenartrückgabeNachKartenart
     (RückgabeExtern : in RueckgabeDatentypen.Kartenart_Enum)
      return KartenDatentypen.Kartenart_Enum
   is begin
      
      return KartenartrückgabeKartenart (RückgabeExtern);
      
   end KartenartrückgabeNachKartenart;
   
   
   
   function KartentemperaturrückgabeNachKartentemperatur
     (RückgabeExtern : in RueckgabeDatentypen.Kartentemperatur_Enum)
      return KartenDatentypen.Kartentemperatur_Enum
   is begin
      
      return KartentemperaturrückgabeKartentemperatur (RückgabeExtern);
      
   end KartentemperaturrückgabeNachKartentemperatur;
   
   
   
   function KartenressourcenrückgabeNachKartenressource
     (RückgabeExtern : in RueckgabeDatentypen.Kartenressourcen_Enum)
      return KartenDatentypen.Kartenressourcen_Enum
   is begin
      
      return KartenressourcenrückgabeKartenressource (RückgabeExtern);
      
   end KartenressourcenrückgabeNachKartenressource;
   
   
   
   function RückgabeNachSchwierigkeitsgrad
     (RückgabeExtern : in RueckgabeDatentypen.Schwierigkeitsgrad_Enum)
      return SpielDatentypen.Schwierigkeitsgrad_Enum
   is begin
      
      return RückgabeSchwierigkeitsgrad (RückgabeExtern);
      
   end RückgabeNachSchwierigkeitsgrad;

end UmwandlungenVerschiedeneDatentypen;

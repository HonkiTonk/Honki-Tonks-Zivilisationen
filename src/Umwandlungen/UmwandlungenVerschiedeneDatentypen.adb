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

end UmwandlungenVerschiedeneDatentypen;

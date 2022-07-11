pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with TastenbelegungDatentypen;
with KartenVerbesserungDatentypen;

package UmwandlungenVerschiedeneDatentypen is

   function TastenbelegungNachKartenverbesserung
     (TasteExtern : in TastenbelegungDatentypen.Tastenbelegung_Konstruktionen_Enum)
      return KartenVerbesserungDatentypen.Karten_Verbesserung_Gebilde_Enum;
   
   function KartenverbesserungNachTastenbelegung
     (VerbesserungExtern : in KartenVerbesserungDatentypen.Karten_Verbesserung_Gebilde_Enum)
      return TastenbelegungDatentypen.Tastenbelegung_Konstruktionen_Enum;
   
private
   
   type TastenbelegungKartenverbesserungArray is array (TastenbelegungDatentypen.Tastenbelegung_Konstruktionen_Enum'Range) of KartenVerbesserungDatentypen.Karten_Verbesserung_Gebilde_Enum;
   TastenbelegungKartenverbesserung : constant TastenbelegungKartenverbesserungArray := (
                                                                                         TastenbelegungDatentypen.Mine_Bauen_Enum    => KartenVerbesserungDatentypen.Mine_Enum,
                                                                                         TastenbelegungDatentypen.Farm_Bauen_Enum    => KartenVerbesserungDatentypen.Farm_Enum,
                                                                                         TastenbelegungDatentypen.Festung_Bauen_Enum => KartenVerbesserungDatentypen.Festung_Enum
                                                                                        );
   
   type KartenverbesserungTastenbelegungArray is array (KartenVerbesserungDatentypen.Karten_Verbesserung_Gebilde_Enum'Range) of TastenbelegungDatentypen.Tastenbelegung_Konstruktionen_Enum;
   KartenverbesserungTastenbelegung : constant KartenverbesserungTastenbelegungArray := (
                                                                                         KartenVerbesserungDatentypen.Mine_Enum    => TastenbelegungDatentypen.Mine_Bauen_Enum,
                                                                                         KartenVerbesserungDatentypen.Farm_Enum    => TastenbelegungDatentypen.Farm_Bauen_Enum,
                                                                                         KartenVerbesserungDatentypen.Festung_Enum => TastenbelegungDatentypen.Festung_Bauen_Enum
                                                                                        );

end UmwandlungenVerschiedeneDatentypen;

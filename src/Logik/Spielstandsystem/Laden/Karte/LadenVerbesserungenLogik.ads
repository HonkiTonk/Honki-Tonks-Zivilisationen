with Ada.Streams.Stream_IO; use Ada.Streams.Stream_IO;

with KartenRecords;
with KartenDatentypen;

private with KartenverbesserungDatentypen;

with LeseWeltkarteneinstellungen;

package LadenVerbesserungenLogik is
   pragma Elaborate_Body;
   use type KartenDatentypen.SenkrechteBasis;
   use type KartenDatentypen.WaagerechteBasis;

   function Verbesserungen
     (DateiLadenExtern : in File_Type;
      KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      LadenPrüfenExtern : in Boolean)
      return Boolean
     with
       Pre => (
                 if
                   LadenPrüfenExtern
                     then
                 (KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
                  and
                    KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte)
              );
   
private
   
   Rohstoff : KartenverbesserungDatentypen.Verbesserungen_Enum;

end LadenVerbesserungenLogik;

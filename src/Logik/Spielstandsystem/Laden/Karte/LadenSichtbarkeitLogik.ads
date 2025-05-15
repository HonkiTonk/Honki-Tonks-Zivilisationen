with Ada.Streams.Stream_IO; use Ada.Streams.Stream_IO;

private with SystemDatentypenHTSEB;

with KartenRecords;
with KartenDatentypen;
with SpeziesDatentypen;

private with ZahlenDatentypen;

with LeseWeltkarteneinstellungen;

package LadenSichtbarkeitLogik is
   pragma Elaborate_Body;
   use type KartenDatentypen.Senkrechte;
   use type KartenDatentypen.Waagerechte;
   
   function Sichtbarkeit
     (DateiLadenExtern : in File_Type;
      KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      VorhandeneSpeziesExtern : in SpeziesDatentypen.Speziesnummern;
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
   
   SichtbarkeitVorhanden : SystemDatentypenHTSEB.EinByte;
   
   Potenz : ZahlenDatentypen.EigenesNatural;
   
   GesamteSichtbarkeit : KartenRecords.SichtbarkeitArray;

end LadenSichtbarkeitLogik;

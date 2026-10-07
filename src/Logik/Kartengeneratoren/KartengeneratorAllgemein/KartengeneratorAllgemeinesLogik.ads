private with KartenDatentypen;

package KartengeneratorAllgemeinesLogik is
   pragma Elaborate_Body;
   
   procedure GenerierungAllgemeines;
   
private
   
   procedure GenerierungGrundlagen
     (SenkrechteExtern : in KartenDatentypen.SenkrechteNatural);

end KartengeneratorAllgemeinesLogik;

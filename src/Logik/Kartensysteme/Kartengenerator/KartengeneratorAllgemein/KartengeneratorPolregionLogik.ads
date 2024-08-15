private with KartenDatentypen;

package KartengeneratorPolregionLogik is
   pragma Elaborate_Body;

   procedure PolregionGenerieren;

private

   SüdpolSchleifenkorrektur : KartenDatentypen.SenkrechteNatural;
   OstpolSchleifenkorrektur : KartenDatentypen.SenkrechteNatural;

   procedure PolregionNorden;
   procedure PolregionSüden;
   procedure PolregionWesten;
   procedure PolregionOsten;

end KartengeneratorPolregionLogik;

private with KartenDatentypen;

package KartengeneratorPolregionLogik is
   pragma Elaborate_Body;

   procedure PolregionGenerieren;

private

   SüdpolSchleifenkorrektur : KartenDatentypen.KartenfeldNatural;
   OstpolSchleifenkorrektur : KartenDatentypen.KartenfeldNatural;

   procedure PolregionNorden;
   procedure PolregionSüden;
   procedure PolregionWesten;
   procedure PolregionOsten;

end KartengeneratorPolregionLogik;

private with KartenDatentypen;

private with AllgemeineBerechnungen;

package KartengeneratorWeltraumLogik is
   pragma Elaborate_Body;

   procedure Weltraum;

private

   Kartenzeitwert : KartenDatentypen.KartenfeldPositiv;



   function Basiszeitwert is new AllgemeineBerechnungen.Basiszeitwert (GanzeZahl => KartenDatentypen.KartenfeldPositiv);

end KartengeneratorWeltraumLogik;

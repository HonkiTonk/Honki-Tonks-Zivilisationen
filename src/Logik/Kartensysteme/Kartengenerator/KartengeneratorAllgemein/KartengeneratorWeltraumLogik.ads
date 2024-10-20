private with KartenDatentypen;

private with AllgemeineBerechnungen;

package KartengeneratorWeltraumLogik is
   pragma Elaborate_Body;

   procedure Weltraum;

private

   Kartenzeitwert : KartenDatentypen.SenkrechtePositiv;



   function Basiszeitwert is new AllgemeineBerechnungen.Basiszeitwert (GanzeZahl => KartenDatentypen.SenkrechtePositiv);

end KartengeneratorWeltraumLogik;

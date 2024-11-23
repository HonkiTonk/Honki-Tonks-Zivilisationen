private with AllgemeinberechnungenHTB7;

private with KartenDatentypen;

package KartengeneratorWeltraumLogik is
   pragma Elaborate_Body;

   procedure Weltraum;

private

   Kartenzeitwert : KartenDatentypen.SenkrechtePositiv;



   function Basiszeitwert is new AllgemeinberechnungenHTB7.Basiszeitwert (GanzeZahl => KartenDatentypen.SenkrechtePositiv);

end KartengeneratorWeltraumLogik;

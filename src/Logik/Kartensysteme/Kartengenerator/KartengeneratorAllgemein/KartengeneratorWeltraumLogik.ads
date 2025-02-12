private with AllgemeineBerechnungenHTSEB;

private with KartenDatentypen;

package KartengeneratorWeltraumLogik is
   pragma Elaborate_Body;

   procedure Weltraum;

private

   Kartenzeitwert : KartenDatentypen.SenkrechtePositiv;



   function Basiszeitwert is new AllgemeineBerechnungenHTSEB.Basiszeitwert (GanzeZahl => KartenDatentypen.SenkrechtePositiv);

end KartengeneratorWeltraumLogik;

private with AllgemeinberechnungenHTB7;

private with KartenDatentypen;

package KartengeneratorHimmelLogik is
   pragma Elaborate_Body;

   procedure Himmel;

private

   Kartenzeitwert : KartenDatentypen.SenkrechtePositiv;



   function Basiszeitwert is new AllgemeinberechnungenHTB7.Basiszeitwert (GanzeZahl => KartenDatentypen.SenkrechtePositiv);

end KartengeneratorHimmelLogik;

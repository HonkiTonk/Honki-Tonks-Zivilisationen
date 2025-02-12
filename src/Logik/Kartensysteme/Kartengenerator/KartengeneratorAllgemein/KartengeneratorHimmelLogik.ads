private with AllgemeineBerechnungenHTSEB;

private with KartenDatentypen;

package KartengeneratorHimmelLogik is
   pragma Elaborate_Body;

   procedure Himmel;

private

   Kartenzeitwert : KartenDatentypen.SenkrechtePositiv;



   function Basiszeitwert is new AllgemeineBerechnungenHTSEB.Basiszeitwert (GanzeZahl => KartenDatentypen.SenkrechtePositiv);

end KartengeneratorHimmelLogik;

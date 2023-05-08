private with KartenDatentypen;

private with AllgemeineBerechnungen;

package KartengeneratorHimmelLogik is
   pragma Elaborate_Body;

   procedure Himmel;

private

   Kartenzeitwert : KartenDatentypen.KartenfeldPositiv;



   function Basiszeitwert is new AllgemeineBerechnungen.Basiszeitwert (GanzeZahl => KartenDatentypen.KartenfeldPositiv);

end KartengeneratorHimmelLogik;

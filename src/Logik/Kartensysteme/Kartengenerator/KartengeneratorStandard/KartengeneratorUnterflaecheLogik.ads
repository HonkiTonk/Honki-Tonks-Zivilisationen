private with KartenDatentypen;

private with AllgemeineBerechnungen;

package KartengeneratorUnterflaecheLogik is
   pragma Elaborate_Body;

   procedure GenerierungLandschaft;

private

   Kartenzeitwert : KartenDatentypen.KartenfeldPositiv;



   function Basiszeitwert is new AllgemeineBerechnungen.Basiszeitwert (GanzeZahl => KartenDatentypen.KartenfeldPositiv);

end KartengeneratorUnterflaecheLogik;

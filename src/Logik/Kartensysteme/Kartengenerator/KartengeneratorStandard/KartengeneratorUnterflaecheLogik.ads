private with AllgemeineBerechnungenHTSEB;

private with KartenDatentypen;

package KartengeneratorUnterflaecheLogik is
   pragma Elaborate_Body;

   procedure GenerierungLandschaft;

private

   Kartenzeitwert : KartenDatentypen.SenkrechtePositiv;



   function Basiszeitwert is new AllgemeineBerechnungenHTSEB.Basiszeitwert (GanzeZahl => KartenDatentypen.SenkrechtePositiv);

end KartengeneratorUnterflaecheLogik;

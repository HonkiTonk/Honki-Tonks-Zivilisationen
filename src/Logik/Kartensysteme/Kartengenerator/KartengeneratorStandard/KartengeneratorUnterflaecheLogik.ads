private with AllgemeinberechnungenHTB7;

private with KartenDatentypen;

package KartengeneratorUnterflaecheLogik is
   pragma Elaborate_Body;

   procedure GenerierungLandschaft;

private

   Kartenzeitwert : KartenDatentypen.SenkrechtePositiv;



   function Basiszeitwert is new AllgemeinberechnungenHTB7.Basiszeitwert (GanzeZahl => KartenDatentypen.SenkrechtePositiv);

end KartengeneratorUnterflaecheLogik;

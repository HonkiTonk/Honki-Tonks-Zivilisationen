private with AllgemeinberechnungenHTB7;

private with KartenDatentypen;

package KartengeneratorRessourcenLogik is
   pragma Elaborate_Body;
   
   procedure GenerierungRessourcen;

private
   
   type KartenzeitwertArray is array (KartenDatentypen.EbenePlanet'Range) of KartenDatentypen.SenkrechtePositiv;
   Kartenzeitwert : KartenzeitwertArray;
         
   procedure RessourcenGenerierung
     (EbeneExtern : in KartenDatentypen.EbenePlanet);
   
   
   
   function Basiszeitwert is new AllgemeinberechnungenHTB7.Basiszeitwert (GanzeZahl => KartenDatentypen.SenkrechtePositiv);

end KartengeneratorRessourcenLogik;

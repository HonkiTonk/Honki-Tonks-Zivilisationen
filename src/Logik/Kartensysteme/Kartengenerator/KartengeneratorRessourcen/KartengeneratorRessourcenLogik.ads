private with KartenDatentypen;

private with AllgemeineBerechnungen;

package KartengeneratorRessourcenLogik is
   pragma Elaborate_Body;
   
   procedure GenerierungRessourcen;

private
   
   type KartenzeitwertArray is array (KartenDatentypen.EbenePlanet'Range) of KartenDatentypen.SenkrechtePositiv;
   Kartenzeitwert : KartenzeitwertArray;
         
   procedure RessourcenGenerierung
     (EbeneExtern : in KartenDatentypen.EbenePlanet);
   
   
   
   function Basiszeitwert is new AllgemeineBerechnungen.Basiszeitwert (GanzeZahl => KartenDatentypen.SenkrechtePositiv);

end KartengeneratorRessourcenLogik;

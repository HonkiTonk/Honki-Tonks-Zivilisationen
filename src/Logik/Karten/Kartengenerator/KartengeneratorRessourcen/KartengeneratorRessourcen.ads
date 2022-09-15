pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

private with KartenDatentypen;

package KartengeneratorRessourcen is
   
   procedure GenerierungRessourcen;

private
   
   type KartenzeitwertArray is array (KartenDatentypen.EbenePlanet'Range) of KartenDatentypen.KartenfeldNatural;
   Kartenzeitwert : KartenzeitwertArray;
         
   procedure RessourcenGenerierung
     (EbeneExtern : in KartenDatentypen.EbenePlanet);

end KartengeneratorRessourcen;

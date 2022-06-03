pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen;

package KartengeneratorRessourcen is
   
   procedure GenerierungRessourcen;

private
      
   
   procedure RessourcenGenerierung
     (EbeneExtern : in KartenDatentypen.EbeneVorhanden);

end KartengeneratorRessourcen;

pragma SPARK_Mode (On);

with GlobaleRecords, GlobaleDatentypen, GlobaleVariablen;
use GlobaleDatentypen;

with KIRecords;
use KIRecords;

package KIGebaeudeBauen is

   function GebäudeBauen
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return KIRecords.GebäudeIDBewertungRecord
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer in GlobaleDatentypen.MaximaleStädte'Range
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) = GlobaleDatentypen.Spieler_KI);
   
private
   
   GebäudeBewertet : KIRecords.GebäudeIDBewertungRecord;

end KIGebaeudeBauen;

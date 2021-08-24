pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleVariablen, GlobaleRecords;
use GlobaleDatentypen;

with KIRecords;

package KIStadt is

   procedure KIStadt
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer in GlobaleDatentypen.MaximaleStädte'Range
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) = GlobaleDatentypen.Spieler_KI);

private

   ProduktionÄndernNotwendig : Boolean;
   FeindNahe : Boolean;

   NotAus : GlobaleDatentypen.Sichtweite;


   EinheitBauen : KIRecords.EinheitIDBewertungRecord;
   GebäudeBauen : KIRecords.GebäudeIDBewertungRecord;

   FremdeEinheit : GlobaleRecords.RassePlatznummerRecord;

   KartenWert : GlobaleRecords.AchsenKartenfeldPositivRecord;

   procedure GefahrStadt
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer in GlobaleDatentypen.MaximaleStädte'Range
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) = GlobaleDatentypen.Spieler_KI);

end KIStadt;

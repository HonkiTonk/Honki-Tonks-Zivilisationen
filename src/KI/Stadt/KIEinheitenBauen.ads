pragma SPARK_Mode (On);

with GlobaleRecords, GlobaleDatentypen, GlobaleVariablen;
use GlobaleDatentypen;

with KIRecords;

package KIEinheitenBauen is

   function EinheitenBauen
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return KIRecords.EinheitIDBewertungRecord
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer in GlobaleDatentypen.MaximaleStädte'Range
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) = GlobaleDatentypen.Spieler_KI);
   
private
   
   UmgebungPassierbar : Boolean;
   
   AnzahlStädte : GlobaleDatentypen.MaximaleStädteMitNullWert;
   
   MinimaleSiedlerMenge : constant GlobaleDatentypen.MaximaleStädte := 2;
   
   SiedlerVorhanden : GlobaleDatentypen.MaximaleEinheitenMitNullWert;
   VerteidigerVorhanden : GlobaleDatentypen.MaximaleEinheitenMitNullWert;
   
   EinheitBewertet : KIRecords.EinheitIDBewertungRecord;
   
   function Siedler
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      EinheitenIDExtern : in GlobaleDatentypen.EinheitenID)
      return Boolean
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer in GlobaleDatentypen.MaximaleStädte'Range
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) = GlobaleDatentypen.Spieler_KI);

end KIEinheitenBauen;

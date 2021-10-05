pragma SPARK_Mode (On);

with GlobaleVariablen, EinheitStadtRecords, KartenRecords, EinheitStadtDatentypen, SonstigeDatentypen;
use SonstigeDatentypen;

with KIRecords;

package KIStadt is

   procedure KIStadt
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer in EinheitStadtDatentypen.MaximaleStädte'Range
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) = SonstigeDatentypen.Spieler_KI);

private

   NotfallEinheit : EinheitStadtDatentypen.EinheitenIDMitNullWert;

   FremdeEinheit : EinheitStadtRecords.RassePlatznummerRecord;

   KartenWert : KartenRecords.AchsenKartenfeldPositivRecord;

   procedure NeuesBauprojekt
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      EinheitBauenExtern : in KIRecords.EinheitIDBewertungRecord;
      GebäudeBauenExtern : in KIRecords.GebäudeIDBewertungRecord;
      NotfallExtern : in Boolean)
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer in EinheitStadtDatentypen.MaximaleStädte'Range
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) = SonstigeDatentypen.Spieler_KI);

   procedure NotfallEinheitBauen
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      EinheitIDExtern : in EinheitStadtDatentypen.EinheitenID)
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer in EinheitStadtDatentypen.MaximaleStädte'Range
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) = SonstigeDatentypen.Spieler_KI);

   procedure WelcheEinheitArt
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord);



   function GefahrStadt
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return Boolean
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer in EinheitStadtDatentypen.MaximaleStädte'Range
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) = SonstigeDatentypen.Spieler_KI);

   function FeindNahe
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return Boolean;

end KIStadt;

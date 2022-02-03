pragma SPARK_Mode (On);

with SystemDatentypen; use SystemDatentypen;
with GlobaleVariablen;
with EinheitStadtRecords;
with KartenRecords;
with EinheitStadtDatentypen;
with SystemKonstanten;

with KIRecords;

package KIStadt is

   procedure KIStadt
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer in EinheitStadtDatentypen.MaximaleStädte'Range
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) = SystemKonstanten.SpielerKIKonstante);

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
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) = SystemKonstanten.SpielerKIKonstante);

   procedure NotfallEinheitBauen
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      EinheitIDExtern : in EinheitStadtDatentypen.EinheitenID)
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer in EinheitStadtDatentypen.MaximaleStädte'Range
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) = SystemKonstanten.SpielerKIKonstante);

   procedure WelcheEinheitArt
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord);



   function GefahrStadt
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return Boolean
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer in EinheitStadtDatentypen.MaximaleStädte'Range
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) = SystemKonstanten.SpielerKIKonstante);

   function FeindNahe
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return Boolean;

end KIStadt;

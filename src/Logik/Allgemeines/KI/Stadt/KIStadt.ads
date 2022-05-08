pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RassenDatentypen; use RassenDatentypen;
with SonstigeVariablen;
with EinheitStadtRecords;
with KartenRecords;
with EinheitStadtDatentypen;

with KIRecords;

package KIStadt is

   procedure KIStadt
     (StadtRasseNummerExtern : in EinheitStadtRecords.RasseEinheitnummerRecord)
     with
       Pre =>
         (StadtRasseNummerExtern.Nummer in EinheitStadtDatentypen.MaximaleStädte'Range
          and
            SonstigeVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) = RassenDatentypen.Spieler_KI_Enum);

private

   NotfallEinheit : EinheitStadtDatentypen.EinheitenIDMitNullWert;

   FremdeEinheit : EinheitStadtRecords.RasseEinheitnummerRecord;

   KartenWert : KartenRecords.AchsenKartenfeldPositivRecord;

   procedure NeuesBauprojekt
     (StadtRasseNummerExtern : in EinheitStadtRecords.RasseEinheitnummerRecord;
      EinheitBauenExtern : in KIRecords.EinheitIDBewertungRecord;
      GebäudeBauenExtern : in KIRecords.GebäudeIDBewertungRecord;
      NotfallExtern : in Boolean)
     with
       Pre =>
         (StadtRasseNummerExtern.Nummer in EinheitStadtDatentypen.MaximaleStädte'Range
          and
            SonstigeVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) = RassenDatentypen.Spieler_KI_Enum);

   procedure NotfallEinheitBauen
     (StadtRasseNummerExtern : in EinheitStadtRecords.RasseEinheitnummerRecord;
      EinheitIDExtern : in EinheitStadtDatentypen.EinheitenID)
     with
       Pre =>
         (StadtRasseNummerExtern.Nummer in EinheitStadtDatentypen.MaximaleStädte'Range
          and
            SonstigeVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) = RassenDatentypen.Spieler_KI_Enum);

   procedure WelcheEinheitArt
     (StadtRasseNummerExtern : in EinheitStadtRecords.RasseEinheitnummerRecord);



   function GefahrStadt
     (StadtRasseNummerExtern : in EinheitStadtRecords.RasseEinheitnummerRecord)
      return Boolean
     with
       Pre =>
         (StadtRasseNummerExtern.Nummer in EinheitStadtDatentypen.MaximaleStädte'Range
          and
            SonstigeVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) = RassenDatentypen.Spieler_KI_Enum);

   function FeindNahe
     (StadtRasseNummerExtern : in EinheitStadtRecords.RasseEinheitnummerRecord)
      return Boolean;

end KIStadt;

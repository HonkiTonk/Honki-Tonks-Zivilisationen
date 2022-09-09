pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RassenDatentypen; use RassenDatentypen;
with StadtRecords;
with SpielVariablen;

private with EinheitenRecords;
private with KartenRecords;
private with EinheitenDatentypen;

private with KIRecords;

package KIStadt is

   procedure KIStadt
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
     with
       Pre => (
                 StadtRasseNummerExtern.Nummer in SpielVariablen.StadtGebautArray'First (2) .. SpielVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
               and
                 SpielVariablen.Rassenbelegung (StadtRasseNummerExtern.Rasse).Belegung = RassenDatentypen.KI_Spieler_Enum
              );

private

   NotfallEinheit : EinheitenDatentypen.EinheitenIDMitNullWert;

   FremdeEinheit : EinheitenRecords.RasseEinheitnummerRecord;

   KartenWert : KartenRecords.AchsenKartenfeldNaturalRecord;

   procedure NeuesBauprojekt
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      EinheitBauenExtern : in KIRecords.EinheitIDBewertungRecord;
      GebäudeBauenExtern : in KIRecords.GebäudeIDBewertungRecord;
      NotfallExtern : in Boolean)
     with
       Pre => (
                 StadtRasseNummerExtern.Nummer in SpielVariablen.StadtGebautArray'First (2) .. SpielVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
               and
                 SpielVariablen.Rassenbelegung (StadtRasseNummerExtern.Rasse).Belegung = RassenDatentypen.KI_Spieler_Enum
              );

   procedure NotfallEinheitBauen
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      EinheitIDExtern : in EinheitenDatentypen.EinheitenID)
     with
       Pre => (
                 StadtRasseNummerExtern.Nummer in SpielVariablen.StadtGebautArray'First (2) .. SpielVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
               and
                 SpielVariablen.Rassenbelegung (StadtRasseNummerExtern.Rasse).Belegung = RassenDatentypen.KI_Spieler_Enum
              );

   procedure WelcheEinheitArt
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
     with
       Pre => (
                 StadtRasseNummerExtern.Nummer in SpielVariablen.StadtGebautArray'First (2) .. SpielVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
               and
                 SpielVariablen.Rassenbelegung (StadtRasseNummerExtern.Rasse).Belegung = RassenDatentypen.KI_Spieler_Enum
              );



   function GefahrStadt
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
      return Boolean
     with
       Pre => (
                 StadtRasseNummerExtern.Nummer in SpielVariablen.StadtGebautArray'First (2) .. SpielVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
               and
                 SpielVariablen.Rassenbelegung (StadtRasseNummerExtern.Rasse).Belegung = RassenDatentypen.KI_Spieler_Enum
              );

   function FeindNahe
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
      return Boolean
     with
       Pre => (
                 StadtRasseNummerExtern.Nummer in SpielVariablen.StadtGebautArray'First (2) .. SpielVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
               and
                 SpielVariablen.Rassenbelegung (StadtRasseNummerExtern.Rasse).Belegung = RassenDatentypen.KI_Spieler_Enum
              );

end KIStadt;

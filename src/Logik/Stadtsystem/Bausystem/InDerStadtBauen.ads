pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RassenDatentypen; use RassenDatentypen;
with StadtDatentypen; use StadtDatentypen;
with EinheitenDatentypen; use EinheitenDatentypen;
with SpielVariablen;
with StadtRecords;

private with KartenRecords;

package InDerStadtBauen is

   procedure Bauen
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
     with
       Pre => (
                 StadtRasseNummerExtern.Nummer in SpielVariablen.StadtGebautArray'First (2) .. SpielVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
               and
                 SpielVariablen.Rassenbelegung (StadtRasseNummerExtern.Rasse).Belegung = RassenDatentypen.Mensch_Spieler_Enum
              );

private

   GebäudeBaubar : Boolean;
   EinheitenBaubar : Boolean;
   BauenMöglich : Boolean;

   WasGebautWerdenSoll : Natural;
   Befehl : Natural;

   Zeilenabstand : Float;

   AktuelleAuswahl : StadtRecords.BauprojektRecord := (0, 0);
   AktuellesBauprojekt : StadtRecords.BauprojektRecord;
   NeuesBauprojekt : StadtRecords.BauprojektRecord;
   GewähltesBauprojekt : StadtRecords.BauprojektRecord;

   KartenWert : KartenRecords.AchsenKartenfeldNaturalRecord;

   function MöglicheGebäudeErmitteln
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
      return Boolean
     with
       Pre => (
                 StadtRasseNummerExtern.Nummer in SpielVariablen.StadtGebautArray'First (2) .. SpielVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
               and
                 SpielVariablen.Rassenbelegung (StadtRasseNummerExtern.Rasse).Belegung = RassenDatentypen.Mensch_Spieler_Enum
              );

   function MöglicheEinheitenErmitteln
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
      return Boolean
     with
       Pre => (
                 StadtRasseNummerExtern.Nummer in SpielVariablen.StadtGebautArray'First (2) .. SpielVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
               and
                 SpielVariablen.Rassenbelegung (StadtRasseNummerExtern.Rasse).Belegung = RassenDatentypen.Mensch_Spieler_Enum
              );



   function BauobjektAuswählen
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
      return StadtRecords.BauprojektRecord
     with
       Pre => (
                 StadtRasseNummerExtern.Nummer in SpielVariablen.StadtGebautArray'First (2) .. SpielVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
               and
                 SpielVariablen.Rassenbelegung (StadtRasseNummerExtern.Rasse).Belegung = RassenDatentypen.Mensch_Spieler_Enum
              );

   function AuswahlBauprojektSFML
     return StadtRecords.BauprojektRecord
     with
       Post => (
                (if AuswahlBauprojektSFML'Result.Gebäude /= 0 then AuswahlBauprojektSFML'Result.Einheit = 0)
                and
                  (if AuswahlBauprojektSFML'Result.Einheit /= 0 then AuswahlBauprojektSFML'Result.Gebäude = 0)
               );

end InDerStadtBauen;

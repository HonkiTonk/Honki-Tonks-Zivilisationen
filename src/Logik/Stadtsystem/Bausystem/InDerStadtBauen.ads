pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

private with Sf.System.Vector2;

with RassenDatentypen; use RassenDatentypen;
with StadtDatentypen; use StadtDatentypen;
with EinheitenDatentypen; use EinheitenDatentypen;
with SpielVariablen;
with StadtRecords;

private with KartenRecords;

package InDerStadtBauen is

   AktuelleAuswahl : StadtRecords.BauprojektRecord := (0, 0);

   procedure Bauen
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
     with
       Pre => (
                 StadtRasseNummerExtern.Nummer in SpielVariablen.StadtGebautArray'First (2) .. SpielVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
               and
                 SpielVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) = RassenDatentypen.Mensch_Spieler_Enum
              );

private

   GebäudeBaubar : Boolean;
   EinheitenBaubar : Boolean;

   WasGebautWerdenSoll : Natural;
   Befehl : Natural;

   Zeilenabstand : Float;

   AktuellesBauprojekt : StadtRecords.BauprojektRecord;
   NeuesBauprojekt : StadtRecords.BauprojektRecord;
   GewähltesBauprojekt : StadtRecords.BauprojektRecord;

   Mausposition : Sf.System.Vector2.sfVector2f;

   KartenWert : KartenRecords.AchsenKartenfeldNaturalRecord;

   procedure MöglicheGebäudeErmitteln
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
     with
       Pre => (
                 StadtRasseNummerExtern.Nummer in SpielVariablen.StadtGebautArray'First (2) .. SpielVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
               and
                 SpielVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) = RassenDatentypen.Mensch_Spieler_Enum
              );

   procedure MöglicheEinheitenErmitteln
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
     with
       Pre => (
                 StadtRasseNummerExtern.Nummer in SpielVariablen.StadtGebautArray'First (2) .. SpielVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
               and
                 SpielVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) = RassenDatentypen.Mensch_Spieler_Enum
              );



   function BauobjektAuswählen
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
      return StadtRecords.BauprojektRecord
     with
       Pre => (
                 StadtRasseNummerExtern.Nummer in SpielVariablen.StadtGebautArray'First (2) .. SpielVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
               and
                 SpielVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) = RassenDatentypen.Mensch_Spieler_Enum
              );

   function MausAuswahl
     return StadtRecords.BauprojektRecord
     with
       Post => (
                (if MausAuswahl'Result.Gebäude /= 0 then MausAuswahl'Result.Einheit = 0)
                and
                  (if MausAuswahl'Result.Einheit /= 0 then MausAuswahl'Result.Gebäude = 0)
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

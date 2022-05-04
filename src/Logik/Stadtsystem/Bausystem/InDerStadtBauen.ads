pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.System.Vector2;

with RassenDatentypen; use RassenDatentypen;
with SpielVariablen;
with SonstigeVariablen;
with EinheitStadtRecords;
with KartenRecords;

package InDerStadtBauen is

   AktuelleAuswahl : EinheitStadtRecords.BauprojektRecord := (True, 0);

   procedure Bauen
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer in SpielVariablen.StadtGebautArray'First (2) .. SpielVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
          and
            SonstigeVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) = RassenDatentypen.Spieler_Mensch_Enum);

private

   GebäudeBaubar : Boolean;
   EinheitenBaubar : Boolean;

   WasGebautWerdenSoll : Natural;
   Befehl : Natural;

   Zeilenabstand : Float;

   AktuellesBauprojekt : EinheitStadtRecords.BauprojektRecord;
   NeuesBauprojekt : EinheitStadtRecords.BauprojektRecord;
   GewähltesBauprojekt : EinheitStadtRecords.BauprojektRecord;

   MausZeigerPosition : Sf.System.Vector2.sfVector2i;

   KartenWert : KartenRecords.AchsenKartenfeldPositivRecord;

   procedure MöglicheGebäudeErmitteln
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer in SpielVariablen.StadtGebautArray'First (2) .. SpielVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
          and
            SonstigeVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) = RassenDatentypen.Spieler_Mensch_Enum);

   procedure MöglicheEinheitenErmitteln
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer in SpielVariablen.StadtGebautArray'First (2) .. SpielVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
          and
            SonstigeVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) = RassenDatentypen.Spieler_Mensch_Enum);



   function BauobjektAuswählen
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return EinheitStadtRecords.BauprojektRecord
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer in SpielVariablen.StadtGebautArray'First (2) .. SpielVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
          and
            SonstigeVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) = RassenDatentypen.Spieler_Mensch_Enum);

   function MausAuswahl
     return EinheitStadtRecords.BauprojektRecord;

   function AuswahlBauprojektSFML
     return EinheitStadtRecords.BauprojektRecord;

end InDerStadtBauen;

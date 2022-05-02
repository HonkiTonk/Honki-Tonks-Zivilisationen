pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics;
with Sf.Graphics.Text;
with Sf.System.Vector2;

with EinheitStadtDatentypen; use EinheitStadtDatentypen;
with RassenDatentypen; use RassenDatentypen;
with SpielVariablen;
with SonstigeVariablen;
with EinheitStadtRecords;
with KartenRecords;

package InDerStadtBauen is

   -- Im Array immer die größte Auswahlfläche reinschreiben, damit es bei allen funktioniert.
   type BaulisteArray is array (EinheitStadtDatentypen.MinimimMaximumID'First + 2 .. EinheitStadtDatentypen.MinimimMaximumID'Last) of EinheitStadtRecords.BauprojektRecord;
   Bauliste : BaulisteArray;

   AktuelleAuswahl : EinheitStadtDatentypen.MinimimMaximumID;
   Ende : EinheitStadtDatentypen.MinimimMaximumID;

   procedure Bauen
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer in SpielVariablen.StadtGebautArray'First (2) .. SpielVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
          and
            SonstigeVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) = RassenDatentypen.Spieler_Mensch_Enum);

private

   SchriftartFestgelegt : Boolean := False;
   SchriftfarbeFestgelegt : Boolean := False;
   SchriftgrößeFestgelegt : Boolean := False;

   WasGebautWerdenSoll : Natural;
   Befehl : Natural;

   Zeilenabstand : Float;

   AktuellesBauprojekt : EinheitStadtRecords.BauprojektRecord;
   NeuesBauprojekt : EinheitStadtRecords.BauprojektRecord;
   GewähltesBauprojekt : EinheitStadtRecords.BauprojektRecord;

   MausZeigerPosition : Sf.System.Vector2.sfVector2i;

   KartenWert : KartenRecords.AchsenKartenfeldPositivRecord;

   StartPositionText : constant Sf.System.Vector2.sfVector2f := (5.00, 5.00);
   TextPositionMaus : Sf.System.Vector2.sfVector2f;

   TextAccess : constant Sf.Graphics.sfText_Ptr := Sf.Graphics.Text.create;

   procedure MöglicheGebäudeErmitteln
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord);

   procedure MöglicheEinheitenErmitteln
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord);

   procedure MausAuswahl;
   procedure EndeErhöhen;



   function BauobjektAuswählen
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return EinheitStadtRecords.BauprojektRecord
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer in SpielVariablen.StadtGebautArray'First (2) .. SpielVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
          and
            SonstigeVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) = RassenDatentypen.Spieler_Mensch_Enum);

   function AuswahlBauprojektSFML
     return EinheitStadtRecords.BauprojektRecord;

   function AuswahlBauprojektKonsole
     return EinheitStadtRecords.BauprojektRecord;

end InDerStadtBauen;

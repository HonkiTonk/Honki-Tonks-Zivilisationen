pragma SPARK_Mode (On);

with Sf.Graphics;
with Sf.Graphics.Text;
with Sf.System.Vector2;

with SystemDatentypen; use SystemDatentypen;
with EinheitStadtDatentypen; use EinheitStadtDatentypen;
with GlobaleVariablen;
with EinheitStadtRecords;
with KartenRecords;

package InDerStadtBauen is

   type BaulisteRecord is record

      GebäudeEinheit : Boolean;
      Nummer : Natural;

   end record;

   -- Im Array immer die größte Auswahlfläche reinschreiben, damit es bei allen funktioniert.
   type BaulisteArray is array (EinheitStadtDatentypen.MinimimMaximumID'First + 2 .. EinheitStadtDatentypen.MinimimMaximumID'Last) of BaulisteRecord;
   Bauliste : BaulisteArray;

   AktuelleAuswahl : EinheitStadtDatentypen.MinimimMaximumID;
   Ende : EinheitStadtDatentypen.MinimimMaximumID;

   procedure Bauen
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer in GlobaleVariablen.StadtGebautArray'First (2) .. GlobaleVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) = SystemDatentypen.Spieler_Mensch);

private

   AktuellesBauprojekt : Natural;
   NeuesBauprojekt : Natural;
   WasGebautWerdenSoll : Natural;
   Befehl : Natural;
   GewähltesBauprojekt : Natural;

   Zeilenabstand : Float;

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



   function BauobjektAuswählen
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return Natural
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer in GlobaleVariablen.StadtGebautArray'First (2) .. GlobaleVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) = SystemDatentypen.Spieler_Mensch),
         Post =>
           (BauobjektAuswählen'Result <= 99_999);

   function AuswahlBauprojektSFML
     return Natural;

   function AuswahlBauprojektKonsole
     return Natural;

end InDerStadtBauen;

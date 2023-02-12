with Ada.Calendar; use Ada.Calendar;

private with Sf.System.Vector2;

with SpeziesDatentypen;
with StadtRecords;
with StadtKonstanten;

private with StadtDatentypen;
private with KartenRecords;
private with GrafikRecordKonstanten;

with LeseGrenzen;
with LeseSpeziesbelegung;

package StadtkarteGrafik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;

   procedure Stadtkarte
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
     with
       Pre => (
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) = SpeziesDatentypen.Mensch_Spieler_Enum
              );

private

   GebäudeID : StadtDatentypen.GebäudeID;

   AlteID : StadtDatentypen.GebäudeIDMitNullwert := StadtKonstanten.LeerGebäudeID;
   GebäudeZusatzinformationen : StadtDatentypen.GebäudeIDMitNullwert;

   Anzeigezeit : Time := Clock;

   YMultiplikator : Float;
   XMultiplikator : Float;

   Gesamtgrund : KartenRecords.KartengrundRecord;

   Viewfläche : Sf.System.Vector2.sfVector2f := GrafikRecordKonstanten.StartView;
   Grafikgröße : Sf.System.Vector2.sfVector2f;
   Textposition : Sf.System.Vector2.sfVector2f;

   procedure GrafischeDarstellung
     (GrundExtern : in KartenRecords.KartengrundRecord);

   procedure Zusatzinformationen
     (GebäudeIDExtern : in StadtDatentypen.GebäudeIDMitNullwert;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) = SpeziesDatentypen.Mensch_Spieler_Enum
              );

   procedure Informationsfeld
     (GebäudeIDExtern : in StadtDatentypen.GebäudeID;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) = SpeziesDatentypen.Mensch_Spieler_Enum
              );

end StadtkarteGrafik;

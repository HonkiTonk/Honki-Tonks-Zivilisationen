with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;
with Ada.Calendar; use Ada.Calendar;

private with Sf.System.Vector2;

with SpeziesDatentypen;
with StadtKonstanten;
with StadtGrafikRecords;

private with StadtDatentypen;
private with KartenRecords;
private with GrafikRecordKonstanten;

with LeseSpeziesbelegung;

package StadtkarteGrafik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;

   procedure Stadtkarte
     (StadtauswahlExtern : in StadtGrafikRecords.StadtkarteGrafikRecord)
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtauswahlExtern.Spezies) = SpeziesDatentypen.Mensch_Spieler_Enum
              );

private

   GebäudeID : StadtDatentypen.GebäudeID;

   AlteID : StadtDatentypen.GebäudeIDMitNullwert := StadtKonstanten.LeerGebäudeID;
   GebäudeZusatzinformationen : StadtDatentypen.GebäudeIDMitNullwert;

   Anzeigezeit : Time := Clock;

   YMultiplikator : Float;
   XMultiplikator : Float;
   Textbreite : Float;

   Gesamtgrund : KartenRecords.KartengrundRecord;

   Viewfläche : Sf.System.Vector2.sfVector2f := GrafikRecordKonstanten.StartView;
   Grafikgröße : Sf.System.Vector2.sfVector2f;
   Textposition : Sf.System.Vector2.sfVector2f;

   type GebäudetexteArray is array (1 .. 10) of Unbounded_Wide_Wide_String;
   Gebäudetexte : GebäudetexteArray;

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

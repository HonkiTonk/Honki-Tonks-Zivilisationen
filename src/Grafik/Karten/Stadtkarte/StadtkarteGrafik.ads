with Ada.Calendar; use Ada.Calendar;

private with Sf.System.Vector2;
private with Sf.Graphics.Rect;

with SpeziesDatentypen;
with StadtKonstanten;
with StadtGrafikRecords;

private with StadtDatentypen;
private with KartenRecords;
private with GrafikRecordKonstanten;
private with TextArrays;
private with KampfDatentypen;

with LeseSpeziesbelegung;

private with UmwandlungenAdaEigenes;

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

   GebäudeID : StadtDatentypen.GebäudeIDVorhanden;

   AlteID : StadtDatentypen.GebäudeID := StadtKonstanten.LeerGebäudeID;
   GebäudeZusatzinformationen : StadtDatentypen.GebäudeID;

   Anzeigezeit : Time := Clock;

   YMultiplikator : Float;
   XMultiplikator : Float;
   YTextposition : Float;

   Gesamtgrund : KartenRecords.KartengrundRecord;

   Viewfläche : Sf.System.Vector2.sfVector2f := GrafikRecordKonstanten.StartView;
   Grafikgröße : Sf.System.Vector2.sfVector2f;

   Rechteck : Sf.Graphics.Rect.sfFloatRect;

   Gebäudetexte : TextArrays.AllgemeinesTextArray (1 .. 11);

   procedure GrafischeDarstellung
     (GrundExtern : in KartenRecords.KartengrundRecord);

   procedure Zusatzinformationen
     (GebäudeIDExtern : in StadtDatentypen.GebäudeID;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) = SpeziesDatentypen.Mensch_Spieler_Enum
              );

   procedure Informationsfeld
     (GebäudeIDExtern : in StadtDatentypen.GebäudeIDVorhanden;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) = SpeziesDatentypen.Mensch_Spieler_Enum
              );



   function KommazahlAlsString is new UmwandlungenAdaEigenes.KommazahlAlsString (Kommazahl => KampfDatentypen.Kampfbonus);

end StadtkarteGrafik;

private with Ada.Calendar;

private with Sf.System.Vector2;
private with Sf.Graphics.Rect;

private with ArraysHTSEB;

with SpeziesDatentypen;
with StadtKonstanten;
with StadtGrafikRecords;

private with StadtDatentypen;
private with KartenRecords;
private with GrafikRecordKonstanten;
private with KampfDatentypen;

with LeseSpeziesbelegung;

private with UmwandlungssystemHTSEB;

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
   use Ada.Calendar;

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

   Gebäudetexte : ArraysHTSEB.AllgemeinesTextArray (1 .. 11);

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



   function KommazahlAlsString is new UmwandlungssystemHTSEB.Kommazahlenstring (Kommazahl => KampfDatentypen.Kampfbonus);

end StadtkarteGrafik;

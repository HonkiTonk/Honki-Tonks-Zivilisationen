with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

private with Sf.System.Vector2;
private with Sf.Graphics.Color;

with SpeziesDatentypen;
with StadtDatentypen;
with EinheitenDatentypen;
with StadtRecords;
with StadtGrafikRecords;

private with GrafikRecordKonstanten;

with LeseSpeziesbelegung;

package BauauswahlGrafik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;
   use type EinheitenDatentypen.EinheitenID;
   use type StadtDatentypen.GebäudeID;

   procedure Bauauswahl
     (BauauswahlExtern : in StadtGrafikRecords.BaumenüGrafikRecord;
      AktuelleAuswahlExtern : in StadtRecords.ErweiterterBauprojektRecord;
      AktuelleAufteilungExtern : in StadtDatentypen.Bauprojektart_Enum)
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => BauauswahlExtern.Spezies) = SpeziesDatentypen.Mensch_Spieler_Enum
              );



   function Gebäude
     (AuswahlExtern : in StadtDatentypen.GebäudeID;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      BauenVerkaufenExtern : in Boolean)
      return Float
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) = SpeziesDatentypen.Mensch_Spieler_Enum
              ),

       Post => (
                  Gebäude'Result >= 0.00
               );

private

   Listenanfang : StadtDatentypen.GebäudeIDVorhanden;
   Listenende : StadtDatentypen.GebäudeIDVorhanden;
   AktuelleListenlänge : Natural;

   Textbreite : Float;

   Text : Unbounded_Wide_Wide_String;

   ViewflächeBauliste : Sf.System.Vector2.sfVector2f := GrafikRecordKonstanten.StartView;
   ViewflächeAktuell : Sf.System.Vector2.sfVector2f := GrafikRecordKonstanten.StartView;
   ViewflächeAufteilung : Sf.System.Vector2.sfVector2f := GrafikRecordKonstanten.StartView;
   Textposition : Sf.System.Vector2.sfVector2f;

   Farbe : Sf.Graphics.Color.sfColor;

   procedure BaulistenviewEinstellen
     (AuswahlExtern : in Natural;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      GebäudeEinheitExtern : in Boolean)
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) = SpeziesDatentypen.Mensch_Spieler_Enum
              );

   procedure Bauaufteilung
     (BauprojektartExtern : in StadtDatentypen.Bauprojektart_Enum;
      AktuelleAufteilungExtern : in StadtDatentypen.Bauprojektart_Enum);

   procedure Aktuell
     (BauauswahlExtern : in StadtGrafikRecords.BaumenüGrafikRecord)
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => BauauswahlExtern.Spezies) = SpeziesDatentypen.Mensch_Spieler_Enum
              );



   function Einheiten
     (AuswahlExtern : in EinheitenDatentypen.EinheitenID;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
      return Float
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) = SpeziesDatentypen.Mensch_Spieler_Enum
              ),

       Post => (
                  Einheiten'Result >= 0.00
               );

end BauauswahlGrafik;

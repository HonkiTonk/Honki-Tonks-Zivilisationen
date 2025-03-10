private with Sf.System.Vector2;

with ArraysHTSEB;

with SpeziesDatentypen;
with StadtDatentypen;

private with GrafikRecordKonstanten;
private with KampfDatentypen;
private with GrafikRecords;

with LeseSpeziesbelegung;

private with UmwandlungssystemHTSEB;

package BauauswahlGebaeudeGrafik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;

   procedure Informationen
     (AuswahlExtern : in StadtDatentypen.GebäudeID;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      BauenVerkaufenExtern : in Boolean)
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) = SpeziesDatentypen.Mensch_Spieler_Enum
              );
   
   
   
   function Informationstexte
     (AuswahlExtern : in StadtDatentypen.GebäudeID;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
      return ArraysHTSEB.AllgemeinesTextArray;
   
private
   
   Gebäudetexte : ArraysHTSEB.AllgemeinesTextArray (1 .. 10);

   Textbreite : Float;
   
   ViewflächeInformationen : Sf.System.Vector2.sfVector2f := GrafikRecordKonstanten.StartView;
   ViewbereichBeschreibung : GrafikRecords.ViewbereichRecord := GrafikRecordKonstanten.Anfangsviewbereich;
   Textposition : Sf.System.Vector2.sfVector2f;

   procedure Gebäudebeschreibung
     (AuswahlExtern : in StadtDatentypen.GebäudeID;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      BauenVerkaufenExtern : in Boolean)
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) = SpeziesDatentypen.Mensch_Spieler_Enum
              );
   
   
      
   function KommazahlAlsString is new UmwandlungssystemHTSEB.Kommazahlenstring (Kommazahl => KampfDatentypen.Kampfbonus);

end BauauswahlGebaeudeGrafik;

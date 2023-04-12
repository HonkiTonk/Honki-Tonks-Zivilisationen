with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

private with Sf.System.Vector2;

with SpeziesDatentypen;

private with KartenRecords;
private with KartenverbesserungDatentypen;
private with TextaccessVariablen;
private with GrafikRecordKonstanten;
private with KartenextraDatentypen;

with LeseSpeziesbelegung;

package AllgemeinesSeitenleisteGrafik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;

   procedure AllgemeineInformationen
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) = SpeziesDatentypen.Mensch_Spieler_Enum
              );
   
private
   
   KartenFluss : KartenextraDatentypen.Fluss_Enum;
   
   KartenRessource : KartenextraDatentypen.Ressourcen_Enum;

   KartenVerbesserung : KartenverbesserungDatentypen.Verbesserung_Enum;
   KartenWeg : KartenverbesserungDatentypen.Weg_Enum;
   
   Textbreite : Float;
   
   Text : Unbounded_Wide_Wide_String;
   
   Gesamtgrund : KartenRecords.KartengrundRecord;

   AktuelleKoordinaten : KartenRecords.AchsenKartenfeldNaturalRecord;
   
   Viewfläche : Sf.System.Vector2.sfVector2f := GrafikRecordKonstanten.StartView;
   Textposition : Sf.System.Vector2.sfVector2f;
   
   type TextAnzeigenArray is array (TextaccessVariablen.KarteAllgemeinesAccess'Range) of Boolean;
   TextAnzeigen : TextAnzeigenArray;
   
end AllgemeinesSeitenleisteGrafik;

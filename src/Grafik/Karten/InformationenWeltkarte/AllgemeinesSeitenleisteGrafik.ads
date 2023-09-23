with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with Sf.System.Vector3;

private with Sf.System.Vector2;

with SpeziesDatentypen;

private with KartenRecords;
private with KartenverbesserungDatentypen;
private with TextaccessVariablen;
private with GrafikRecordKonstanten;
private with KartenextraDatentypen;

-- with LeseSpeziesbelegung;

package AllgemeinesSeitenleisteGrafik is
   pragma Elaborate_Body;
   -- use type SpeziesDatentypen.Spieler_Enum;

   function AllgemeineInformationen
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Enum;
      TextpositionsinformationenExtern : in Sf.System.Vector3.sfVector3f)
      return Sf.System.Vector3.sfVector3f
     with
       Pre => (
                 TextpositionsinformationenExtern.x > 0.00
               and
                 TextpositionsinformationenExtern.y > 0.00
               and
                 TextpositionsinformationenExtern.z >= 0.00
                 --           LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) = SpeziesDatentypen.Mensch_Spieler_Enum
              ),
         
       Post => (
                  AllgemeineInformationen'Result.x > 0.00
                and
                  AllgemeineInformationen'Result.y > 0.00
                and
                  AllgemeineInformationen'Result.z >= 0.00
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
   
   LetzteAuflösung : Sf.System.Vector2.sfVector2f := GrafikRecordKonstanten.Nullposition;
   AktuelleAuflösung : Sf.System.Vector2.sfVector2f;
   Textposition : Sf.System.Vector2.sfVector2f;
   
   type TextAnzeigenArray is array (TextaccessVariablen.KarteAllgemeinesAccess'Range) of Boolean;
   TextAnzeigen : TextAnzeigenArray;
   
   procedure TextZeichnen;
   
end AllgemeinesSeitenleisteGrafik;

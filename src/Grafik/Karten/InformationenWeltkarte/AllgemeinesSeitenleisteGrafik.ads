with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

private with Sf.System.Vector2;

with SpeziesDatentypen;
with SpeziesKonstanten;
with GrafikRecords;

private with KartenRecords;
private with KartenverbesserungDatentypen;
private with TextaccessVariablen;
private with KartenextraDatentypen;
private with TextArrays;
private with KartengrundDatentypen;

with LeseSpeziesbelegung;

package AllgemeinesSeitenleisteGrafik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;
   use type SpeziesDatentypen.Spezies_Enum;

   function AllgemeineInformationen
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Enum;
      TextpositionsinformationenExtern : in GrafikRecords.TextpositionLeerzeilenRecord;
      MaximaleTextbreiteExtern : in Float)
      return GrafikRecords.TextpositionLeerzeilenRecord
     with
       Pre => (
                 TextpositionsinformationenExtern.Textpositionsinformationen.x > 0.00
               and
                 TextpositionsinformationenExtern.Textpositionsinformationen.y > 0.00
               and
                 TextpositionsinformationenExtern.Textpositionsinformationen.z > 0.00
               and
                 (if SpeziesExtern /= SpeziesKonstanten.LeerSpezies then LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) = SpeziesDatentypen.Mensch_Spieler_Enum)
              ),
         
       Post => (
                  AllgemeineInformationen'Result.Textpositionsinformationen.x > 0.00
                and
                  AllgemeineInformationen'Result.Textpositionsinformationen.y > 0.00
                and
                  AllgemeineInformationen'Result.Textpositionsinformationen.z > 0.00
               );
   
private
   use type KartengrundDatentypen.Basisgrund_Enum;
   
   Leerzeilen : Natural;
      
   Textbreite : Float;
   
   Zwischenspeicher : Unbounded_Wide_Wide_String;

   AktuelleKoordinaten : KartenRecords.AchsenKartenfeldNaturalRecord;
   
   Textposition : Sf.System.Vector2.sfVector2f;
   Skalierung : Sf.System.Vector2.sfVector2f;
   
   AnzuzeigenderText : TextArrays.AllgemeinesTextArray (TextaccessVariablen.KarteAllgemeinesAccess'Range);
   
   
   
   function Gesamtgrund
     (GesamtgrundExtern : in KartenRecords.KartengrundRecord)
      return Unbounded_Wide_Wide_String
     with
       Pre => (
                 GesamtgrundExtern.Basisgrund /= KartengrundDatentypen.Leer_Basisgrund_Enum
              ),
         
       Post => (
                  To_Wide_Wide_String (Source => Gesamtgrund'Result)'Length > 0
               );
   
   -- Die Contracts hier noch hinzufügen. äöü
   function Ressource
     (RessourceExtern : in KartenextraDatentypen.Ressourcen_Enum)
      return Unbounded_Wide_Wide_String;
   
   function Verbesserung
     (VerbesserungExtern : in KartenverbesserungDatentypen.Verbesserung_Enum)
      return Unbounded_Wide_Wide_String;
   
   function Weg
     (WegExtern : in KartenverbesserungDatentypen.Weg_Enum)
      return Unbounded_Wide_Wide_String;
   
   function Fluss
     (FlussExtern : in KartenextraDatentypen.Fluss_Enum)
      return Unbounded_Wide_Wide_String;
   
   function Feldeffekte
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Unbounded_Wide_Wide_String;
   
end AllgemeinesSeitenleisteGrafik;

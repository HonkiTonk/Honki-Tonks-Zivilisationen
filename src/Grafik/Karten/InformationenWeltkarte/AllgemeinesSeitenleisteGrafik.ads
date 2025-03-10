private with Ada.Strings.Wide_Wide_Unbounded;

with Sf.System.Vector2;

private with ArraysHTSEB;

with SpeziesDatentypen;
with SpeziesKonstanten;

private with KartenRecords;
private with KartenverbesserungDatentypen;
private with TextaccessVariablen;
private with KartenextraDatentypen;
private with KartengrundDatentypen;

with LeseSpeziesbelegung;

package AllgemeinesSeitenleisteGrafik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;
   use type SpeziesDatentypen.Spezies_Enum;

   function AllgemeineInformationen
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Enum;
      TextpositionExtern : in Sf.System.Vector2.sfVector2f;
      MaximaleTextbreiteExtern : in Float)
      return Float
     with
       Pre => (
               (if SpeziesExtern /= SpeziesKonstanten.LeerSpezies then LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) = SpeziesDatentypen.Mensch_Spieler_Enum)
               and
                 TextpositionExtern.x > 0.00
               and
                 TextpositionExtern.y > 0.00
              ),
         
       Post => (
                  AllgemeineInformationen'Result > 0.00
               );
   
private
   use Ada.Strings.Wide_Wide_Unbounded;
   use type KartengrundDatentypen.Basisgrund_Enum;
   
   Leerzeilen : Natural;
      
   YTextposition : Float;
   
   Zwischenspeicher : Unbounded_Wide_Wide_String;

   AktuelleKoordinaten : KartenRecords.KartenfeldNaturalRecord;
   
   AnzuzeigenderText : ArraysHTSEB.AllgemeinesTextArray (TextaccessVariablen.KarteAllgemeinesAccess'Range);
   
   
   
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
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord)
      return Unbounded_Wide_Wide_String;
   
end AllgemeinesSeitenleisteGrafik;

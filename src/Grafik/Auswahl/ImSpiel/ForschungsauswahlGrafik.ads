private with Ada.Strings.Wide_Wide_Unbounded;

private with Sf.System.Vector2;

with SpeziesDatentypen;

private with ForschungenDatentypen;
private with GrafikRecordKonstanten;
private with ProduktionDatentypen;

with LeseSpeziesbelegung;

package ForschungsauswahlGrafik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;

   procedure ForschungAnzeige
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      AktuelleAuswahlExtern : in Natural)
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) = SpeziesDatentypen.Mensch_Spieler_Enum
              );
   
private
   use Ada.Strings.Wide_Wide_Unbounded;
   
   AktuelleAuswahl : ForschungenDatentypen.ForschungID;
   AktuellesForschungsprojekt : ForschungenDatentypen.ForschungID;
   
   Forschungswert : ForschungenDatentypen.ForschungIDUnmöglich;
   
   Forschungszeit : ProduktionDatentypen.Lagermenge;
      
   AktuelleTextbreite : Float;
      
   Text : Unbounded_Wide_Wide_String;
   
   Textposition : Sf.System.Vector2.sfVector2f;
   
   type ViewflächenArray is array (GrafikRecordKonstanten.Forschungsbereich'Range) of Sf.System.Vector2.sfVector2f;
   Viewfläche : ViewflächenArray := (others => GrafikRecordKonstanten.StartView);
   
   procedure Auswahlmöglichkeiten
     (AuswahlExtern : in Natural;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) = SpeziesDatentypen.Mensch_Spieler_Enum
              );
   
   procedure Beschreibung
     (ZusatztextExtern : in ForschungenDatentypen.ForschungID;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) = SpeziesDatentypen.Mensch_Spieler_Enum
              );
   
   procedure Ermöglicht
     (ZusatztextExtern : in ForschungenDatentypen.ForschungID;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum  
              );
   
   procedure Aktuell
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum  
              );
   
end ForschungsauswahlGrafik;

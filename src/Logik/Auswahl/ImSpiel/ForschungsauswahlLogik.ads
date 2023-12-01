with SpeziesDatentypen;

private with ForschungenDatentypen;
private with ForschungKonstanten;

with LeseSpeziesbelegung;

package ForschungsauswahlLogik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;

   procedure Forschung
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   procedure Forschungserfolg
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) = SpeziesDatentypen.Mensch_Spieler_Enum
              );
   
private
   
   AktuelleAuswahl : ForschungenDatentypen.ForschungID := ForschungKonstanten.LeerAnforderung;
   NeuesForschungsprojekt : ForschungenDatentypen.ForschungID;
   GewählteForschung : ForschungenDatentypen.ForschungID;

   Auswahl : Positive;

   function Forschungsmöglichkeiten
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
      return ForschungenDatentypen.ForschungID
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) = SpeziesDatentypen.Mensch_Spieler_Enum
              );

   function Forschungsauswahl
     (AktuellesForschungsprojektExtern : in ForschungenDatentypen.ForschungID)
      return ForschungenDatentypen.ForschungID;

end ForschungsauswahlLogik;

with SpeziesDatentypen;
with ForschungenDatentypen;

with LeseSpeziesbelegung;

package ForschungstestsLogik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;

   function ForschungAnforderungErfüllt
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      ForschungIDExtern : in ForschungenDatentypen.ForschungIDVorhanden)
      return Boolean
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );

   function TechnologieVorhanden
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      TechnologieExtern : in ForschungenDatentypen.ForschungIDUnmöglich)
      return Boolean
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );

private

   Forschungsanforderungen : ForschungenDatentypen.ForschungIDUnmöglich;

end ForschungstestsLogik;

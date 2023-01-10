with SpeziesDatentypen;
with ForschungenDatentypen;

with LeseSpeziesbelegung;

package ForschungstestsLogik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;

   function ForschungAnforderungErfüllt
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      ForschungIDExtern : in ForschungenDatentypen.ForschungID)
      return Boolean
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );

   function TechnologieVorhanden
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      TechnologieExtern : in ForschungenDatentypen.ForschungIDNichtMöglich)
      return Boolean
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );

private

   Forschungsanforderungen : ForschungenDatentypen.ForschungIDNichtMöglich;

end ForschungstestsLogik;

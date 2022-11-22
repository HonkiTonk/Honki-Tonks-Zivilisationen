with RassenDatentypen;
with ForschungenDatentypen;

with LeseRassenbelegung;

package ForschungstestsLogik is
   pragma Elaborate_Body;
   use type RassenDatentypen.Spieler_Enum;

   function ForschungAnforderungErfüllt
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      ForschungIDExtern : in ForschungenDatentypen.ForschungID)
      return Boolean
     with
       Pre => (
                 LeseRassenbelegung.Belegung (RasseExtern => RasseExtern) /= RassenDatentypen.Leer_Spieler_Enum
              );

   function TechnologieVorhanden
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      TechnologieExtern : in ForschungenDatentypen.ForschungIDNichtMöglich)
      return Boolean
     with
       Pre => (
                 LeseRassenbelegung.Belegung (RasseExtern => RasseExtern) /= RassenDatentypen.Leer_Spieler_Enum
              );

private

   Forschungsanforderungen : ForschungenDatentypen.ForschungIDNichtMöglich;

end ForschungstestsLogik;

with RassenDatentypen;
with ForschungenDatentypen;
with ProduktionDatentypen;
with AufgabenDatentypen;
with SystemDatentypen;
with BefehleDatentypen;

with LeseRassenbelegung;

package LeseForschungenDatenbank is
   pragma Elaborate_Body;
   use type RassenDatentypen.Spieler_Enum;

   function Kosten
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in ForschungenDatentypen.ForschungIDMitNullWert)
      return ProduktionDatentypen.Lagermenge
     with
       Pre => (
                 LeseRassenbelegung.Belegung (RasseExtern => RasseExtern) /= RassenDatentypen.Leer_Spieler_Enum
              );

   function AnforderungForschung
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in ForschungenDatentypen.ForschungIDMitNullWert;
      WelcheAnforderungExtern : in ForschungenDatentypen.Forschung_Anforderung_Enum)
      return ForschungenDatentypen.ForschungIDNichtMöglich
     with
       Pre => (
                 LeseRassenbelegung.Belegung (RasseExtern => RasseExtern) /= RassenDatentypen.Leer_Spieler_Enum
              );

   function Verbesserungen
     (VerbesserungExtern : in BefehleDatentypen.Siedler_Verbesserung_Enum;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return ForschungenDatentypen.ForschungIDNichtMöglich
     with
       Pre => (
                 LeseRassenbelegung.Belegung (RasseExtern => RasseExtern) /= RassenDatentypen.Leer_Spieler_Enum
              );

   function Wege
     (WegExtern : in AufgabenDatentypen.Einheitenbefehle_Wege_Enum;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return ForschungenDatentypen.ForschungIDNichtMöglich
     with
       Pre => (
                 LeseRassenbelegung.Belegung (RasseExtern => RasseExtern) /= RassenDatentypen.Leer_Spieler_Enum
              );

   function Umgebung
     (AnfangEndeExtern : in SystemDatentypen.Anfang_Ende_Enum;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return ForschungenDatentypen.ForschungIDNichtMöglich
     with
       Pre => (
                 LeseRassenbelegung.Belegung (RasseExtern => RasseExtern) /= RassenDatentypen.Leer_Spieler_Enum
              );

end LeseForschungenDatenbank;

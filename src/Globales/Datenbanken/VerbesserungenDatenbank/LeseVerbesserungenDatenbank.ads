with RassenDatentypen;
with EinheitenDatentypen;
with KartenverbesserungDatentypen;
with ProduktionDatentypen;
with KampfDatentypen;

with LeseRassenbelegung;

package LeseVerbesserungenDatenbank is
   pragma Elaborate_Body;
   use type RassenDatentypen.Spieler_Enum;
   
   function PassierbarkeitWeg
     (WegExtern : in KartenverbesserungDatentypen.Karten_Weg_Enum;
      WelcheUmgebungExtern : in EinheitenDatentypen.Passierbarkeit_Enum)
      return Boolean;
   
   function BewegungWeg
     (WegExtern : in KartenverbesserungDatentypen.Karten_Weg_Enum;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return EinheitenDatentypen.Bewegungspunkte
     with
       Pre => (
                 LeseRassenbelegung.Belegung (RasseExtern => RasseExtern) /= RassenDatentypen.Leer_Spieler_Enum
              );
   
   function WirtschaftVerbesserung
     (VerbesserungExtern : in KartenverbesserungDatentypen.Karten_Verbesserung_Enum;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      WelcherWertExtern : in ProduktionDatentypen.Wirtschaft_Enum)
      return ProduktionDatentypen.Einzelproduktion
     with
       Pre => (
                 LeseRassenbelegung.Belegung (RasseExtern => RasseExtern) /= RassenDatentypen.Leer_Spieler_Enum
              );
   
   function WirtschaftWeg
     (WegExtern : in KartenverbesserungDatentypen.Karten_Weg_Enum;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      WelcherWertExtern : in ProduktionDatentypen.Wirtschaft_Enum)
      return ProduktionDatentypen.Einzelproduktion
     with
       Pre => (
                 LeseRassenbelegung.Belegung (RasseExtern => RasseExtern) /= RassenDatentypen.Leer_Spieler_Enum
              );
   
   function KampfVerbesserung
     (VerbesserungExtern : in KartenverbesserungDatentypen.Karten_Verbesserung_Enum;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      WelcherWertExtern : in KampfDatentypen.Kampf_Enum)
      return KampfDatentypen.KampfwerteAllgemein
     with
       Pre => (
                 LeseRassenbelegung.Belegung (RasseExtern => RasseExtern) /= RassenDatentypen.Leer_Spieler_Enum
              );
   
   function KampfWeg
     (WegExtern : in KartenverbesserungDatentypen.Karten_Weg_Enum;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      WelcherWertExtern : in KampfDatentypen.Kampf_Enum)
      return KampfDatentypen.KampfwerteAllgemein
     with
       Pre => (
                 LeseRassenbelegung.Belegung (RasseExtern => RasseExtern) /= RassenDatentypen.Leer_Spieler_Enum
              );

end LeseVerbesserungenDatenbank;

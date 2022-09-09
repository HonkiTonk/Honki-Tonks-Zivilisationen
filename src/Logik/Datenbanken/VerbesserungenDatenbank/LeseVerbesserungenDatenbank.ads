pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RassenDatentypen; use RassenDatentypen;
with SpielVariablen;
with KartenDatentypen;
with EinheitenDatentypen;
with KartenverbesserungDatentypen;
with ProduktionDatentypen;
with KampfDatentypen;

package LeseVerbesserungenDatenbank is

   function PassierbarkeitVerbesserung
     (VerbesserungExtern : in KartenverbesserungDatentypen.Karten_Verbesserung_Vorhanden_Enum;
      WelcheUmgebungExtern : in EinheitenDatentypen.Passierbarkeit_Vorhanden_Enum)
      return Boolean;
   
   function PassierbarkeitWeg
     (WegExtern : in KartenverbesserungDatentypen.Karten_Weg_Vorhanden_Enum;
      WelcheUmgebungExtern : in EinheitenDatentypen.Passierbarkeit_Vorhanden_Enum)
      return Boolean;
   
   function BewertungVerbesserung
     (VerbesserungExtern : in KartenverbesserungDatentypen.Karten_Verbesserung_Vorhanden_Enum;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return KartenDatentypen.Einzelbewertung
     with
       Pre => (
                 SpielVariablen.Rassenbelegung (RasseExtern).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );
   
   function BewertungWeg
     (WegExtern : in KartenverbesserungDatentypen.Karten_Weg_Vorhanden_Enum;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return KartenDatentypen.Einzelbewertung
     with
       Pre => (
                 SpielVariablen.Rassenbelegung (RasseExtern).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );
   
   function WirtschaftVerbesserung
     (VerbesserungExtern : in KartenverbesserungDatentypen.Karten_Verbesserung_Vorhanden_Enum;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      WelcherWertExtern : in KartenDatentypen.Wirtschaft_Enum)
      return ProduktionDatentypen.Einzelproduktion
     with
       Pre => (
                 SpielVariablen.Rassenbelegung (RasseExtern).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );
   
   function WirtschaftWeg
     (WegExtern : in KartenverbesserungDatentypen.Karten_Weg_Vorhanden_Enum;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      WelcherWertExtern : in KartenDatentypen.Wirtschaft_Enum)
      return ProduktionDatentypen.Einzelproduktion
     with
       Pre => (
                 SpielVariablen.Rassenbelegung (RasseExtern).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );
   
   function KampfVerbesserung
     (VerbesserungExtern : in KartenverbesserungDatentypen.Karten_Verbesserung_Vorhanden_Enum;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      WelcherWertExtern : in KartenDatentypen.Kampf_Enum)
      return KampfDatentypen.KampfwerteAllgemein
     with
       Pre => (
                 SpielVariablen.Rassenbelegung (RasseExtern).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );
   
   function KampfWeg
     (WegExtern : in KartenverbesserungDatentypen.Karten_Weg_Vorhanden_Enum;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      WelcherWertExtern : in KartenDatentypen.Kampf_Enum)
      return KampfDatentypen.KampfwerteAllgemein
     with
       Pre => (
                 SpielVariablen.Rassenbelegung (RasseExtern).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );

end LeseVerbesserungenDatenbank;

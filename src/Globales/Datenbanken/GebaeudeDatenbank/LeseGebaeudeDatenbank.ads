pragma Warnings (Off, "*array aggregate*");

with RassenDatentypen; use RassenDatentypen;
with KartenDatentypen;
with SpielVariablen;
with StadtDatentypen;
with KartengrundDatentypen;
with ForschungenDatentypen;
with ProduktionDatentypen;
with KampfDatentypen;
with KartenverbesserungDatentypen;

package LeseGebaeudeDatenbank is
   pragma Elaborate_Body;

   function PreisGeld
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in StadtDatentypen.GebäudeID)
      return ProduktionDatentypen.Produktion
     with
       Pre => (
                 SpielVariablen.Rassenbelegung (RasseExtern).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );
   
   function Produktionskosten
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in StadtDatentypen.GebäudeID)
      return ProduktionDatentypen.Produktion
     with
       Pre => (
                 SpielVariablen.Rassenbelegung (RasseExtern).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );
   
   function PermanenteKosten
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in StadtDatentypen.GebäudeID;
      WelcheKostenExtern : in ProduktionDatentypen.Permanente_Kosten_Verwendet_Enum)
      return ProduktionDatentypen.Stadtproduktion
     with
       Pre => (
                 SpielVariablen.Rassenbelegung (RasseExtern).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );
      
   function Anforderungen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in StadtDatentypen.GebäudeID)
      return ForschungenDatentypen.ForschungIDNichtMöglich
     with
       Pre => (
                 SpielVariablen.Rassenbelegung (RasseExtern).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );
   
   function WirtschaftBonus
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in StadtDatentypen.GebäudeID;
      WirtschaftBonusExtern : in ProduktionDatentypen.Wirtschaft_Enum)
      return ProduktionDatentypen.Feldproduktion
     with
       Pre => (
                 SpielVariablen.Rassenbelegung (RasseExtern).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );
         
   function KampfBonus
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in StadtDatentypen.GebäudeID;
      KampfBonusExtern : in KampfDatentypen.Kampf_Enum)
      return KampfDatentypen.KampfwerteEinheiten
     with
       Pre => (
                 SpielVariablen.Rassenbelegung (RasseExtern).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );
      
   function BasisgrundBenötigt
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in StadtDatentypen.GebäudeID)
      return KartengrundDatentypen.Basisgrund_Enum
     with
       Pre => (
                 SpielVariablen.Rassenbelegung (RasseExtern).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );
      
   function FlussBenötigt
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in StadtDatentypen.GebäudeID)
      return Boolean
     with
       Pre => (
                 SpielVariablen.Rassenbelegung (RasseExtern).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );
      
   function RessourceBenötigt
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in StadtDatentypen.GebäudeID)
      return KartengrundDatentypen.Kartenressourcen_Enum
     with
       Pre => (
                 SpielVariablen.Rassenbelegung (RasseExtern).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );
   
   function VerbesserungBenötigt
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in StadtDatentypen.GebäudeID)
      return KartenverbesserungDatentypen.Karten_Verbesserung_Enum
     with
       Pre => (
                 SpielVariablen.Rassenbelegung (RasseExtern).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );
     
   function GebäudeBenötigt
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in StadtDatentypen.GebäudeID)
      return StadtDatentypen.GebäudeIDMitNullwert
     with
       Pre => (
                 SpielVariablen.Rassenbelegung (RasseExtern).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );
   
   function FalscheEbene
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in StadtDatentypen.GebäudeID;
      EbeneExtern : in KartenDatentypen.EbeneVorhanden)
      return Boolean
     with
       Pre => (
                 SpielVariablen.Rassenbelegung (RasseExtern).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );
   
   function GebäudeSpezielleEigenschaft
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in StadtDatentypen.GebäudeID)
      return StadtDatentypen.Gebäude_Spezielle_Eigenschaften_Enum
     with
       Pre => (
                 SpielVariablen.Rassenbelegung (RasseExtern).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );

end LeseGebaeudeDatenbank;

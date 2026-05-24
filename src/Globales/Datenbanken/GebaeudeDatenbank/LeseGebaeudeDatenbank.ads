with SpeziesDatentypen;
with KartenDatentypen;
with StadtDatentypen;
with KartengrundDatentypen;
with ForschungenDatentypen;
with ProduktionDatentypen;
with KampfDatentypen;
with KartenverbesserungDatentypen;
with KartenextraDatentypen;

with LeseSpeziesbelegung;

package LeseGebaeudeDatenbank is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;

   function PreisGeld
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      IDExtern : in StadtDatentypen.GebäudeIDBasis)
      return ProduktionDatentypen.Produktion
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   function Produktionskosten
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      IDExtern : in StadtDatentypen.GebäudeIDBasis)
      return ProduktionDatentypen.Produktion
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   function PermanenteKosten
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      IDExtern : in StadtDatentypen.GebäudeIDBasis;
      WelcheKostenExtern : in ProduktionDatentypen.Permanente_Kosten_Vorhanden_Enum)
      return ProduktionDatentypen.Stadtproduktion
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
      
   function Anforderungen
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      IDExtern : in StadtDatentypen.GebäudeIDBasis)
      return ForschungenDatentypen.ForschungIDUnmöglich
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   function Produktionsbonus
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      IDExtern : in StadtDatentypen.GebäudeIDBasis;
      ProduktionsbonusExtern : in ProduktionDatentypen.Produktion_Enum)
      return ProduktionDatentypen.Feldproduktion
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
         
   function KampfBonus
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      IDExtern : in StadtDatentypen.GebäudeIDBasis;
      KampfBonusExtern : in KampfDatentypen.Kampf_Enum)
      return KampfDatentypen.Kampfbonus
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
      
   function BasisgrundBenötigt
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      IDExtern : in StadtDatentypen.GebäudeIDBasis;
      GrundExtern : in KartengrundDatentypen.Basisgrund_Vorhanden_Enum)
      return Boolean
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
      
   function ZusatzgrundBenötigt
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      IDExtern : in StadtDatentypen.GebäudeIDBasis;
      GrundExtern : in KartengrundDatentypen.Zusatzgrund_Vorhanden_Enum)
      return Boolean
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
      
   function FlussBenötigt
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      IDExtern : in StadtDatentypen.GebäudeIDBasis;
      FlussartExtern : in KartenextraDatentypen.Fluss_Vorhanden_Enum)
      return Boolean
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
      
   function RessourceBenötigt
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      IDExtern : in StadtDatentypen.GebäudeIDBasis;
      RessourceExtern : in KartenextraDatentypen.Ressourcen_Vorhanden_Enum)
      return Boolean
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   function VerbesserungBenötigt
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      IDExtern : in StadtDatentypen.GebäudeIDBasis;
      VerbesserungExtern : in KartenverbesserungDatentypen.Verbesserung_Vorhanden_Enum)
      return Boolean
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   function WegBenötigt
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      IDExtern : in StadtDatentypen.GebäudeIDBasis;
      WegExtern : in KartenverbesserungDatentypen.Weg_Vorhanden_Enum)
      return Boolean
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   function GebäudeBenötigt
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      IDExtern : in StadtDatentypen.GebäudeIDBasis;
      WelchesGebäudeExtern : in StadtDatentypen.GebäudeIDVorhanden)
      return Boolean
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   function FalscheEbene
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      IDExtern : in StadtDatentypen.GebäudeIDBasis;
      EbeneExtern : in KartenDatentypen.EbeneVorhanden)
      return Boolean
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   function GebäudeSpezielleEigenschaft
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      IDExtern : in StadtDatentypen.GebäudeIDBasis)
      return StadtDatentypen.Gebäude_Spezielle_Eigenschaften_Enum
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );

end LeseGebaeudeDatenbank;

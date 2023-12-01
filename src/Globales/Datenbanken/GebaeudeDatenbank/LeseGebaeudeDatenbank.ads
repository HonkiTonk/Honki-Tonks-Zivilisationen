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
      IDExtern : in StadtDatentypen.GebäudeID)
      return ProduktionDatentypen.Produktion
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   function Produktionskosten
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      IDExtern : in StadtDatentypen.GebäudeID)
      return ProduktionDatentypen.Produktion
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   function PermanenteKosten
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      IDExtern : in StadtDatentypen.GebäudeID;
      WelcheKostenExtern : in ProduktionDatentypen.Permanente_Kosten_Vorhanden_Enum)
      return ProduktionDatentypen.Stadtproduktion
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
      
   function Anforderungen
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      IDExtern : in StadtDatentypen.GebäudeID)
      return ForschungenDatentypen.ForschungIDUnmöglich
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   function Produktionsbonus
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      IDExtern : in StadtDatentypen.GebäudeID;
      ProduktionsbonusExtern : in ProduktionDatentypen.Produktion_Enum)
      return ProduktionDatentypen.Feldproduktion
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
         
   function KampfBonus
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      IDExtern : in StadtDatentypen.GebäudeID;
      KampfBonusExtern : in KampfDatentypen.Kampf_Enum)
      return KampfDatentypen.Kampfbonus
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
      
   function BasisgrundBenötigt
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      IDExtern : in StadtDatentypen.GebäudeID;
      GrundExtern : in KartengrundDatentypen.Basisgrund_Vorhanden_Enum)
      return Boolean
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
      
   function ZusatzgrundBenötigt
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      IDExtern : in StadtDatentypen.GebäudeID;
      GrundExtern : in KartengrundDatentypen.Zusatzgrund_Vorhanden_Enum)
      return Boolean
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
      
   function FlussBenötigt
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      IDExtern : in StadtDatentypen.GebäudeID;
      FlussartExtern : in KartenextraDatentypen.Fluss_Vorhanden_Enum)
      return Boolean
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
      
   function RessourceBenötigt
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      IDExtern : in StadtDatentypen.GebäudeID;
      RessourceExtern : in KartenextraDatentypen.Ressourcen_Vorhanden_Enum)
      return Boolean
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   function VerbesserungBenötigt
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      IDExtern : in StadtDatentypen.GebäudeID;
      VerbesserungExtern : in KartenverbesserungDatentypen.Verbesserung_Vorhanden_Enum)
      return Boolean
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   function WegBenötigt
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      IDExtern : in StadtDatentypen.GebäudeID;
      WegExtern : in KartenverbesserungDatentypen.Weg_Vorhanden_Enum)
      return Boolean
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   function GebäudeBenötigt
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      IDExtern : in StadtDatentypen.GebäudeID;
      WelchesGebäudeExtern : in StadtDatentypen.GebäudeIDVorhanden)
      return Boolean
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   function FalscheEbene
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      IDExtern : in StadtDatentypen.GebäudeID;
      EbeneExtern : in KartenDatentypen.EbeneVorhanden)
      return Boolean
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   function GebäudeSpezielleEigenschaft
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      IDExtern : in StadtDatentypen.GebäudeID)
      return StadtDatentypen.Gebäude_Spezielle_Eigenschaften_Enum
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );

end LeseGebaeudeDatenbank;

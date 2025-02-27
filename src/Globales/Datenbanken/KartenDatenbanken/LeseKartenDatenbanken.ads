with SpeziesDatentypen;
with EinheitenDatentypen;
with KartengrundDatentypen;
with ProduktionDatentypen;
with KampfDatentypen;
with ZufallsgeneratorenDatentypenHTSEB;
with KartenextraDatentypen;

with LeseSpeziesbelegung;

package LeseKartenDatenbanken is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;

   function PassierbarkeitBasisgrund
     (GrundExtern : in KartengrundDatentypen.Basisgrund_Enum;
      WelcheUmgebungExtern : in EinheitenDatentypen.Passierbarkeit_Enum)
      return Boolean;
   
   function BewertungBasisgrund
     (GrundExtern : in KartengrundDatentypen.Basisgrund_Enum;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
      return ZufallsgeneratorenDatentypenHTSEB.Bewertung_Enum
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) = SpeziesDatentypen.KI_Spieler_Enum
              );
   
   function BewertungZusatzgrund
     (GrundExtern : in KartengrundDatentypen.Zusatzgrund_Enum;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
      return ZufallsgeneratorenDatentypenHTSEB.Bewertung_Enum
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) = SpeziesDatentypen.KI_Spieler_Enum
              );
   
   function BewegungBasisgrund
     (GrundExtern : in KartengrundDatentypen.Basisgrund_Enum;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
      return EinheitenDatentypen.BewegungspunkteVorhanden
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
     
   function BewegungZusatzgrund
     (GrundExtern : in KartengrundDatentypen.Zusatzgrund_Enum;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
      return EinheitenDatentypen.BewegungspunkteVorhanden
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   function BewertungFluss
     (FlussExtern : in KartenextraDatentypen.Fluss_Enum;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
      return Boolean
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   function BewertungRessource
     (RessourceExtern : in KartenextraDatentypen.Ressourcen_Enum;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
      return Boolean
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   function ProduktionBasisgrund
     (GrundExtern : in KartengrundDatentypen.Basisgrund_Enum;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      ProduktionsartExtern : in ProduktionDatentypen.Produktion_Enum)
      return ProduktionDatentypen.Einzelproduktion
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   function ProduktionZusatzgrund
     (GrundExtern : in KartengrundDatentypen.Zusatzgrund_Enum;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      ProduktionsartExtern : in ProduktionDatentypen.Produktion_Enum)
      return ProduktionDatentypen.Einzelproduktion
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   function ProduktionFluss
     (FlussExtern : in KartenextraDatentypen.Fluss_Enum;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      ProduktionsartExtern : in ProduktionDatentypen.Produktion_Enum)
      return ProduktionDatentypen.Produktionsbonus
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   function ProduktionRessourcen
     (RessourceExtern : in KartenextraDatentypen.Ressourcen_Enum;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      ProduktionsartExtern : in ProduktionDatentypen.Produktion_Enum)
      return ProduktionDatentypen.Produktionsbonus
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   function KampfBasisgrund
     (GrundExtern : in KartengrundDatentypen.Basisgrund_Enum;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      KampfartExtern : in KampfDatentypen.Kampf_Enum)
      return KampfDatentypen.Kampfbonus
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   function KampfZusatzgrund
     (GrundExtern : in KartengrundDatentypen.Zusatzgrund_Enum;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      KampfartExtern : in KampfDatentypen.Kampf_Enum)
      return KampfDatentypen.Kampfbonus
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   function KampfFluss
     (FlussExtern : in KartenextraDatentypen.Fluss_Enum;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      KampfartExtern : in KampfDatentypen.Kampf_Enum)
      return KampfDatentypen.Kampfbonus
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   function KampfRessource
     (RessourceExtern : in KartenextraDatentypen.Ressourcen_Enum;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      KampfartExtern : in KampfDatentypen.Kampf_Enum)
      return KampfDatentypen.Kampfbonus
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );

end LeseKartenDatenbanken;

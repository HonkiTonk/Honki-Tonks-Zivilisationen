with SpeziesDatentypen;
with EinheitenDatentypen;
with KartengrundDatentypen;
with ProduktionDatentypen;
with KampfDatentypen;
with BewertungDatentypen;
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
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return BewertungDatentypen.Bewertung_Enum
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) = SpeziesDatentypen.KI_Spieler_Enum
              );
   
   function BewertungZusatzgrund
     (GrundExtern : in KartengrundDatentypen.Zusatzgrund_Enum;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return BewertungDatentypen.Bewertung_Enum
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) = SpeziesDatentypen.KI_Spieler_Enum
              );
   
   function BewegungBasisgrund
     (GrundExtern : in KartengrundDatentypen.Basisgrund_Enum;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return EinheitenDatentypen.VorhandeneBewegungspunkte
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
     
   function BewegungZusatzgrund
     (GrundExtern : in KartengrundDatentypen.Zusatzgrund_Enum;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return EinheitenDatentypen.VorhandeneBewegungspunkte
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   function BewertungFluss
     (FlussExtern : in KartenextraDatentypen.Fluss_Enum;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return BewertungDatentypen.Bewertung_Enum
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   function BewertungRessource
     (RessourceExtern : in KartenextraDatentypen.Ressourcen_Enum;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return BewertungDatentypen.Bewertung_Enum
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   function WirtschaftBasisgrund
     (GrundExtern : in KartengrundDatentypen.Basisgrund_Enum;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      WirtschaftArtExtern : in ProduktionDatentypen.Wirtschaft_Enum)
      return ProduktionDatentypen.Einzelproduktion
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   function WirtschaftZusatzgrund
     (GrundExtern : in KartengrundDatentypen.Zusatzgrund_Enum;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      WirtschaftArtExtern : in ProduktionDatentypen.Wirtschaft_Enum)
      return ProduktionDatentypen.Einzelproduktion
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   function WirtschaftFluss
     (FlussExtern : in KartenextraDatentypen.Fluss_Enum;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      WirtschaftArtExtern : in ProduktionDatentypen.Wirtschaft_Enum)
      return ProduktionDatentypen.Einzelproduktion
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   function WirtschaftRessourcen
     (RessourceExtern : in KartenextraDatentypen.Ressourcen_Enum;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      WirtschaftArtExtern : in ProduktionDatentypen.Wirtschaft_Enum)
      return ProduktionDatentypen.Einzelproduktion
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   function KampfBasisgrund
     (GrundExtern : in KartengrundDatentypen.Basisgrund_Enum;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      KampfArtExtern : in KampfDatentypen.Kampf_Enum)
      return KampfDatentypen.KampfwerteAllgemein
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   function KampfZusatzgrund
     (GrundExtern : in KartengrundDatentypen.Zusatzgrund_Enum;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      KampfArtExtern : in KampfDatentypen.Kampf_Enum)
      return KampfDatentypen.KampfwerteAllgemein
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   function KampfFluss
     (FlussExtern : in KartenextraDatentypen.Fluss_Enum;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      KampfArtExtern : in KampfDatentypen.Kampf_Enum)
      return KampfDatentypen.KampfwerteAllgemein
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   function KampfRessource
     (RessourceExtern : in KartenextraDatentypen.Ressourcen_Enum;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      KampfArtExtern : in KampfDatentypen.Kampf_Enum)
      return KampfDatentypen.KampfwerteAllgemein
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );

end LeseKartenDatenbanken;

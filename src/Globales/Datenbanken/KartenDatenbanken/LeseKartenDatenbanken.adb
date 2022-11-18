with KartenDatenbank;
with KampfKonstanten;

package body LeseKartenDatenbanken is

   function PassierbarkeitBasisgrund
     (GrundExtern : in KartengrundDatentypen.Basisgrund_Vorhanden_Enum;
      WelcheUmgebungExtern : in EinheitenDatentypen.Passierbarkeit_Enum)
      return Boolean
   is begin
      
      return KartenDatenbank.Basisgrundliste (GrundExtern).Passierbarkeit (WelcheUmgebungExtern);
      
   end PassierbarkeitBasisgrund;
   
   
   
   function BewertungBasisgrund
     (GrundExtern : in KartengrundDatentypen.Basisgrund_Vorhanden_Enum;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return BewertungDatentypen.Bewertung_Enum
   is begin
      
      return KartenDatenbank.Basisgrundliste (GrundExtern).Bewertung (RasseExtern);
      
   end BewertungBasisgrund;
   
   
   
   function BewertungZusatzgrund
     (GrundExtern : in KartengrundDatentypen.Zusatzgrund_Enum;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return BewertungDatentypen.Bewertung_Enum
   is begin
      
      case
        GrundExtern
      is
         when KartengrundDatentypen.Leer_Zusatzgrund_Enum =>
            return BewertungDatentypen.Bewertung_Eins_Enum;
              
         when others =>
            return KartenDatenbank.Zusatzgrundliste (GrundExtern).Bewertung (RasseExtern);
      end case;
      
   end BewertungZusatzgrund;
   
   
   
   function BewegungBasisgrund
     (GrundExtern : in KartengrundDatentypen.Basisgrund_Vorhanden_Enum;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return EinheitenDatentypen.VorhandeneBewegungspunkte
   is begin
      
      return KartenDatenbank.Basisgrundliste (GrundExtern).Bewegung (RasseExtern);
      
   end BewegungBasisgrund;
   
   
   
   function BewegungZusatzgrund
     (GrundExtern : in KartengrundDatentypen.Zusatzgrund_Enum;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return EinheitenDatentypen.VorhandeneBewegungspunkte
   is begin
      
      case
        GrundExtern
      is
         when KartengrundDatentypen.Leer_Zusatzgrund_Enum =>
            return 0;
              
         when others =>
            return KartenDatenbank.Zusatzgrundliste (GrundExtern).Bewegung (RasseExtern);
      end case;
      
   end BewegungZusatzgrund;
     
      
   
   function BewertungFluss
     (FlussExtern : in KartengrundDatentypen.Kartenfluss_Vorhanden_Enum;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return BewertungDatentypen.Bewertung_Enum
   is begin
      
      return KartenDatenbank.Kartenflussliste (FlussExtern).Bewertung (RasseExtern);
      
   end BewertungFluss;
   
   
   
   function BewertungRessource
     (RessourceExtern : in KartengrundDatentypen.Kartenressourcen_Vorhanden_Enum;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return BewertungDatentypen.Bewertung_Enum
   is begin
      
      return KartenDatenbank.Kartenressourcenliste (RessourceExtern).Bewertung (RasseExtern);
      
   end BewertungRessource;
   
   
   
   function WirtschaftBasisgrund
     (GrundExtern : in KartengrundDatentypen.Basisgrund_Vorhanden_Enum;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      WirtschaftArtExtern : in ProduktionDatentypen.Wirtschaft_Enum)
      return ProduktionDatentypen.Einzelproduktion
   is begin
      
      return KartenDatenbank.Basisgrundliste (GrundExtern).Wirtschaft (RasseExtern, WirtschaftArtExtern);
      
   end WirtschaftBasisgrund;
   
   
   
   function WirtschaftZusatzgrund
     (GrundExtern : in KartengrundDatentypen.Zusatzgrund_Enum;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      WirtschaftArtExtern : in ProduktionDatentypen.Wirtschaft_Enum)
      return ProduktionDatentypen.Einzelproduktion
   is begin
      
      case
        GrundExtern
      is
         when KartengrundDatentypen.Leer_Zusatzgrund_Enum =>
            return ProduktionDatentypen.Einzelproduktion'First;
            
         when others =>
            return KartenDatenbank.Zusatzgrundliste (GrundExtern).Wirtschaft (RasseExtern, WirtschaftArtExtern);
      end case;
      
   end WirtschaftZusatzgrund;
   
   
   
   function WirtschaftFluss
     (FlussExtern : in KartengrundDatentypen.Kartenfluss_Vorhanden_Enum;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      WirtschaftArtExtern : in ProduktionDatentypen.Wirtschaft_Enum)
      return ProduktionDatentypen.Einzelproduktion
   is begin
      
      return KartenDatenbank.Kartenflussliste (FlussExtern).Wirtschaft (RasseExtern, WirtschaftArtExtern);
      
   end WirtschaftFluss;
   
   
   
   function WirtschaftRessourcen
     (RessourceExtern : in KartengrundDatentypen.Kartenressourcen_Vorhanden_Enum;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      WirtschaftArtExtern : in ProduktionDatentypen.Wirtschaft_Enum)
      return ProduktionDatentypen.Einzelproduktion
   is begin
      
      return KartenDatenbank.Kartenressourcenliste (RessourceExtern).Wirtschaft (RasseExtern, WirtschaftArtExtern);
      
   end WirtschaftRessourcen;
   
   
   
   function KampfBasisgrund
     (GrundExtern : in KartengrundDatentypen.Basisgrund_Vorhanden_Enum;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      KampfArtExtern : in KampfDatentypen.Kampf_Enum)
      return KampfDatentypen.KampfwerteAllgemein
   is begin
      
      return KartenDatenbank.Basisgrundliste (GrundExtern).Kampf (RasseExtern, KampfArtExtern);
      
   end KampfBasisgrund;
   
   
   
   function KampfZusatzgrund
     (GrundExtern : in KartengrundDatentypen.Zusatzgrund_Enum;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      KampfArtExtern : in KampfDatentypen.Kampf_Enum)
      return KampfDatentypen.KampfwerteAllgemein
   is begin
      
      case
        GrundExtern
      is
         when KartengrundDatentypen.Leer_Zusatzgrund_Enum =>
            return KampfKonstanten.LeerKampfwert;
            
         when others =>
            return KartenDatenbank.Zusatzgrundliste (GrundExtern).Kampf (RasseExtern, KampfArtExtern);
      end case;
      
   end KampfZusatzgrund;
   
   
   
   function KampfFluss
     (FlussExtern : in KartengrundDatentypen.Kartenfluss_Vorhanden_Enum;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      KampfArtExtern : in KampfDatentypen.Kampf_Enum)
      return KampfDatentypen.KampfwerteAllgemein
   is begin
      
      return KartenDatenbank.Kartenflussliste (FlussExtern).Kampf (RasseExtern, KampfArtExtern);
      
   end KampfFluss;
   
   
   
   function KampfRessource
     (RessourceExtern : in KartengrundDatentypen.Kartenressourcen_Vorhanden_Enum;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      KampfArtExtern : in KampfDatentypen.Kampf_Enum)
      return KampfDatentypen.KampfwerteAllgemein
   is begin
      
      return KartenDatenbank.Kartenressourcenliste (RessourceExtern).Kampf (RasseExtern, KampfArtExtern);
      
   end KampfRessource;

end LeseKartenDatenbanken;

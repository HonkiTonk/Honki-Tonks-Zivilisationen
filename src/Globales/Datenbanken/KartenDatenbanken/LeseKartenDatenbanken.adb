with KartenDatenbank;
with KampfKonstanten;
with EinheitenKonstanten;
with ProduktionKonstanten;
with KartenKonstanten;

with Fehlermeldungssystem;

package body LeseKartenDatenbanken is

   function PassierbarkeitBasisgrund
     (GrundExtern : in KartengrundDatentypen.Basisgrund_Enum;
      WelcheUmgebungExtern : in EinheitenDatentypen.Passierbarkeit_Enum)
      return Boolean
   is begin
      
      case
        GrundExtern
      is
         when KartengrundDatentypen.Leer_Basisgrund_Enum =>
            Fehlermeldungssystem.Logik (FehlermeldungExtern => "LeseKartenDatenbanken.PassierbarkeitBasisgrund - Grund ist Leer.");
            return False;
            
         when others =>
            return KartenDatenbank.Basisgrundliste (GrundExtern).Passierbarkeit (WelcheUmgebungExtern);
      end case;
      
   end PassierbarkeitBasisgrund;
   
   
   
   function BewertungBasisgrund
     (GrundExtern : in KartengrundDatentypen.Basisgrund_Enum;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return BewertungDatentypen.Bewertung_Enum
   is begin
      
      case
        GrundExtern
      is
         when KartengrundDatentypen.Leer_Basisgrund_Enum =>
            Fehlermeldungssystem.Logik (FehlermeldungExtern => "LeseKartenDatenbanken.BewertungBasisgrund - Grund ist Leer. Rasse: " & RasseExtern'Wide_Wide_Image);
            return BewertungDatentypen.Bewertung_Eins_Enum;
            
         when others =>
            return KartenDatenbank.Basisgrundliste (GrundExtern).Bewertung (RasseExtern);
      end case;
      
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
     (GrundExtern : in KartengrundDatentypen.Basisgrund_Enum;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return EinheitenDatentypen.VorhandeneBewegungspunkte
   is begin
      
      case
        GrundExtern
      is
         when KartengrundDatentypen.Leer_Basisgrund_Enum =>
            Fehlermeldungssystem.Logik (FehlermeldungExtern => "LeseKartenDatenbanken.BewegungBasisgrund - Grund ist Leer. Rasse: " & RasseExtern'Wide_Wide_Image);
            return EinheitenKonstanten.LeerBewegungspunkte;
            
         when others =>
            return KartenDatenbank.Basisgrundliste (GrundExtern).Bewegung (RasseExtern);
      end case;
      
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
            return EinheitenKonstanten.LeerBewegungspunkte;
              
         when others =>
            return KartenDatenbank.Zusatzgrundliste (GrundExtern).Bewegung (RasseExtern);
      end case;
      
   end BewegungZusatzgrund;
     
      
   
   function BewertungFluss
     (FlussExtern : in KartengrundDatentypen.Kartenfluss_Enum;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return BewertungDatentypen.Bewertung_Enum
   is begin
      
      case
        FlussExtern
      is
         when KartengrundDatentypen.Leer_Fluss_Enum =>
            return KartenKonstanten.LeerBewertung;
            
         when others =>
            return KartenDatenbank.Kartenflussliste (FlussExtern).Bewertung (RasseExtern);
      end case;
      
   end BewertungFluss;
   
   
   
   function BewertungRessource
     (RessourceExtern : in KartengrundDatentypen.Kartenressourcen_Enum;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return BewertungDatentypen.Bewertung_Enum
   is begin
      
      case
        RessourceExtern
      is
         when KartengrundDatentypen.Leer_Ressource_Enum =>
            return KartenKonstanten.LeerBewertung;
            
         when others =>
            return KartenDatenbank.Kartenressourcenliste (RessourceExtern).Bewertung (RasseExtern);
      end case;
      
   end BewertungRessource;
   
   
   
   function WirtschaftBasisgrund
     (GrundExtern : in KartengrundDatentypen.Basisgrund_Enum;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      WirtschaftArtExtern : in ProduktionDatentypen.Wirtschaft_Enum)
      return ProduktionDatentypen.Einzelproduktion
   is begin
      
      case
        GrundExtern
      is
         when KartengrundDatentypen.Leer_Basisgrund_Enum =>
            Fehlermeldungssystem.Logik (FehlermeldungExtern => "LeseKartenDatenbanken.WirtschaftBasisgrund - Grund ist Leer. Rasse: " & RasseExtern'Wide_Wide_Image);
            return ProduktionKonstanten.LeerProduktion;
            
         when others =>
            return KartenDatenbank.Basisgrundliste (GrundExtern).Wirtschaft (RasseExtern, WirtschaftArtExtern);
      end case;
      
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
            return ProduktionKonstanten.LeerProduktion;
            
         when others =>
            return KartenDatenbank.Zusatzgrundliste (GrundExtern).Wirtschaft (RasseExtern, WirtschaftArtExtern);
      end case;
      
   end WirtschaftZusatzgrund;
   
   
   
   function WirtschaftFluss
     (FlussExtern : in KartengrundDatentypen.Kartenfluss_Enum;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      WirtschaftArtExtern : in ProduktionDatentypen.Wirtschaft_Enum)
      return ProduktionDatentypen.Einzelproduktion
   is begin
      
      case
        FlussExtern
      is
         when KartengrundDatentypen.Leer_Fluss_Enum =>
            return ProduktionKonstanten.LeerProduktion;
            
         when others =>
            return KartenDatenbank.Kartenflussliste (FlussExtern).Wirtschaft (RasseExtern, WirtschaftArtExtern);
      end case;
      
   end WirtschaftFluss;
   
   
   
   function WirtschaftRessourcen
     (RessourceExtern : in KartengrundDatentypen.Kartenressourcen_Enum;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      WirtschaftArtExtern : in ProduktionDatentypen.Wirtschaft_Enum)
      return ProduktionDatentypen.Einzelproduktion
   is begin
      
      case
        RessourceExtern
      is
         when KartengrundDatentypen.Leer_Ressource_Enum =>
            return ProduktionKonstanten.LeerProduktion;
            
         when others =>
            return KartenDatenbank.Kartenressourcenliste (RessourceExtern).Wirtschaft (RasseExtern, WirtschaftArtExtern);
      end case;
      
   end WirtschaftRessourcen;
   
   
   
   function KampfBasisgrund
     (GrundExtern : in KartengrundDatentypen.Basisgrund_Enum;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      KampfArtExtern : in KampfDatentypen.Kampf_Enum)
      return KampfDatentypen.KampfwerteAllgemein
   is begin
      
      case
        GrundExtern
      is
         when KartengrundDatentypen.Leer_Basisgrund_Enum =>
            Fehlermeldungssystem.Logik (FehlermeldungExtern => "LeseKartenDatenbanken.KampfBasisgrund - Grund ist Leer. Rasse: " & RasseExtern'Wide_Wide_Image);
            return KampfKonstanten.LeerKampfwert;
            
         when others =>
            return KartenDatenbank.Basisgrundliste (GrundExtern).Kampf (RasseExtern, KampfArtExtern);
      end case;
      
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
     (FlussExtern : in KartengrundDatentypen.Kartenfluss_Enum;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      KampfArtExtern : in KampfDatentypen.Kampf_Enum)
      return KampfDatentypen.KampfwerteAllgemein
   is begin
      
      case
        FlussExtern
      is
         when KartengrundDatentypen.Leer_Fluss_Enum =>
            return KampfKonstanten.LeerKampfwert;
            
         when others =>
            return KartenDatenbank.Kartenflussliste (FlussExtern).Kampf (RasseExtern, KampfArtExtern);
      end case;
      
   end KampfFluss;
   
   
   
   function KampfRessource
     (RessourceExtern : in KartengrundDatentypen.Kartenressourcen_Enum;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      KampfArtExtern : in KampfDatentypen.Kampf_Enum)
      return KampfDatentypen.KampfwerteAllgemein
   is begin
      
      case
        RessourceExtern
      is
         when KartengrundDatentypen.Leer_Ressource_Enum =>
            return KampfKonstanten.LeerKampfwert;
            
         when others =>
            return KartenDatenbank.Kartenressourcenliste (RessourceExtern).Kampf (RasseExtern, KampfArtExtern);
      end case;
      
   end KampfRessource;

end LeseKartenDatenbanken;

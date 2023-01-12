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
            Fehlermeldungssystem.Logik (FehlermeldungExtern => "LeseKartenDatenbanken.PassierbarkeitBasisgrund: Leerer Grund");
            return False;
            
         when others =>
            return KartenDatenbank.Basisgrundliste (GrundExtern).Passierbarkeit (WelcheUmgebungExtern);
      end case;
      
   end PassierbarkeitBasisgrund;
   
   
   
   function BewertungBasisgrund
     (GrundExtern : in KartengrundDatentypen.Basisgrund_Enum;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return BewertungDatentypen.Bewertung_Enum
   is begin
      
      case
        GrundExtern
      is
         when KartengrundDatentypen.Leer_Basisgrund_Enum =>
            Fehlermeldungssystem.Logik (FehlermeldungExtern => "LeseKartenDatenbanken.BewertungBasisgrund: Leerer Grund, Spezies: " & SpeziesExtern'Wide_Wide_Image);
            return BewertungDatentypen.Bewertung_Eins_Enum;
            
         when others =>
            return KartenDatenbank.Basisgrundliste (GrundExtern).Bewertung (SpeziesExtern);
      end case;
      
   end BewertungBasisgrund;
   
   
   
   function BewertungZusatzgrund
     (GrundExtern : in KartengrundDatentypen.Zusatzgrund_Enum;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return BewertungDatentypen.Bewertung_Enum
   is begin
      
      case
        GrundExtern
      is
         when KartengrundDatentypen.Leer_Zusatzgrund_Enum =>
            return BewertungDatentypen.Bewertung_Eins_Enum;
              
         when others =>
            return KartenDatenbank.Zusatzgrundliste (GrundExtern).Bewertung (SpeziesExtern);
      end case;
      
   end BewertungZusatzgrund;
   
   
   
   function BewegungBasisgrund
     (GrundExtern : in KartengrundDatentypen.Basisgrund_Enum;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return EinheitenDatentypen.VorhandeneBewegungspunkte
   is begin
      
      case
        GrundExtern
      is
         when KartengrundDatentypen.Leer_Basisgrund_Enum =>
            Fehlermeldungssystem.Logik (FehlermeldungExtern => "LeseKartenDatenbanken.BewegungBasisgrund: Leerer Grund, Spezies: " & SpeziesExtern'Wide_Wide_Image);
            return EinheitenKonstanten.LeerBewegungspunkte;
            
         when others =>
            return KartenDatenbank.Basisgrundliste (GrundExtern).Bewegung (SpeziesExtern);
      end case;
      
   end BewegungBasisgrund;
   
   
   
   function BewegungZusatzgrund
     (GrundExtern : in KartengrundDatentypen.Zusatzgrund_Enum;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return EinheitenDatentypen.VorhandeneBewegungspunkte
   is begin
      
      case
        GrundExtern
      is
         when KartengrundDatentypen.Leer_Zusatzgrund_Enum =>
            return EinheitenKonstanten.LeerBewegungspunkte;
              
         when others =>
            return KartenDatenbank.Zusatzgrundliste (GrundExtern).Bewegung (SpeziesExtern);
      end case;
      
   end BewegungZusatzgrund;
     
      
   
   function BewertungFluss
     (FlussExtern : in KartenextraDatentypen.Fluss_Enum;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return BewertungDatentypen.Bewertung_Enum
   is begin
      
      case
        FlussExtern
      is
         when KartenextraDatentypen.Leer_Fluss_Enum =>
            return KartenKonstanten.LeerBewertung;
            
         when others =>
            return KartenDatenbank.Kartenflussliste (FlussExtern).Bewertung (SpeziesExtern);
      end case;
      
   end BewertungFluss;
   
   
   
   function BewertungRessource
     (RessourceExtern : in KartenextraDatentypen.Ressourcen_Enum;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return BewertungDatentypen.Bewertung_Enum
   is begin
      
      case
        RessourceExtern
      is
         when KartenextraDatentypen.Leer_Ressource_Enum =>
            return KartenKonstanten.LeerBewertung;
            
         when others =>
            return KartenDatenbank.Kartenressourcenliste (RessourceExtern).Bewertung (SpeziesExtern);
      end case;
      
   end BewertungRessource;
   
   
   
   function WirtschaftBasisgrund
     (GrundExtern : in KartengrundDatentypen.Basisgrund_Enum;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      WirtschaftArtExtern : in ProduktionDatentypen.Wirtschaft_Enum)
      return ProduktionDatentypen.Einzelproduktion
   is begin
      
      case
        GrundExtern
      is
         when KartengrundDatentypen.Leer_Basisgrund_Enum =>
            Fehlermeldungssystem.Logik (FehlermeldungExtern => "LeseKartenDatenbanken.WirtschaftBasisgrund: Leerer Grund, Spezies: " & SpeziesExtern'Wide_Wide_Image);
            return ProduktionKonstanten.LeerProduktion;
            
         when others =>
            return KartenDatenbank.Basisgrundliste (GrundExtern).Wirtschaft (SpeziesExtern, WirtschaftArtExtern);
      end case;
      
   end WirtschaftBasisgrund;
   
   
   
   function WirtschaftZusatzgrund
     (GrundExtern : in KartengrundDatentypen.Zusatzgrund_Enum;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      WirtschaftArtExtern : in ProduktionDatentypen.Wirtschaft_Enum)
      return ProduktionDatentypen.Einzelproduktion
   is begin
      
      case
        GrundExtern
      is
         when KartengrundDatentypen.Leer_Zusatzgrund_Enum =>
            return ProduktionKonstanten.LeerProduktion;
            
         when others =>
            return KartenDatenbank.Zusatzgrundliste (GrundExtern).Wirtschaft (SpeziesExtern, WirtschaftArtExtern);
      end case;
      
   end WirtschaftZusatzgrund;
   
   
   
   function WirtschaftFluss
     (FlussExtern : in KartenextraDatentypen.Fluss_Enum;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      WirtschaftArtExtern : in ProduktionDatentypen.Wirtschaft_Enum)
      return ProduktionDatentypen.Einzelproduktion
   is begin
      
      case
        FlussExtern
      is
         when KartenextraDatentypen.Leer_Fluss_Enum =>
            return ProduktionKonstanten.LeerProduktion;
            
         when others =>
            return KartenDatenbank.Kartenflussliste (FlussExtern).Wirtschaft (SpeziesExtern, WirtschaftArtExtern);
      end case;
      
   end WirtschaftFluss;
   
   
   
   function WirtschaftRessourcen
     (RessourceExtern : in KartenextraDatentypen.Ressourcen_Enum;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      WirtschaftArtExtern : in ProduktionDatentypen.Wirtschaft_Enum)
      return ProduktionDatentypen.Einzelproduktion
   is begin
      
      case
        RessourceExtern
      is
         when KartenextraDatentypen.Leer_Ressource_Enum =>
            return ProduktionKonstanten.LeerProduktion;
            
         when others =>
            return KartenDatenbank.Kartenressourcenliste (RessourceExtern).Wirtschaft (SpeziesExtern, WirtschaftArtExtern);
      end case;
      
   end WirtschaftRessourcen;
   
   
   
   function KampfBasisgrund
     (GrundExtern : in KartengrundDatentypen.Basisgrund_Enum;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      KampfArtExtern : in KampfDatentypen.Kampf_Enum)
      return KampfDatentypen.KampfwerteAllgemein
   is begin
      
      case
        GrundExtern
      is
         when KartengrundDatentypen.Leer_Basisgrund_Enum =>
            Fehlermeldungssystem.Logik (FehlermeldungExtern => "LeseKartenDatenbanken.KampfBasisgrund: Leerer Grund, Spezies: " & SpeziesExtern'Wide_Wide_Image);
            return KampfKonstanten.LeerKampfwert;
            
         when others =>
            return KartenDatenbank.Basisgrundliste (GrundExtern).Kampf (SpeziesExtern, KampfArtExtern);
      end case;
      
   end KampfBasisgrund;
   
   
   
   function KampfZusatzgrund
     (GrundExtern : in KartengrundDatentypen.Zusatzgrund_Enum;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      KampfArtExtern : in KampfDatentypen.Kampf_Enum)
      return KampfDatentypen.KampfwerteAllgemein
   is begin
      
      case
        GrundExtern
      is
         when KartengrundDatentypen.Leer_Zusatzgrund_Enum =>
            return KampfKonstanten.LeerKampfwert;
            
         when others =>
            return KartenDatenbank.Zusatzgrundliste (GrundExtern).Kampf (SpeziesExtern, KampfArtExtern);
      end case;
      
   end KampfZusatzgrund;
   
   
   
   function KampfFluss
     (FlussExtern : in KartenextraDatentypen.Fluss_Enum;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      KampfArtExtern : in KampfDatentypen.Kampf_Enum)
      return KampfDatentypen.KampfwerteAllgemein
   is begin
      
      case
        FlussExtern
      is
         when KartenextraDatentypen.Leer_Fluss_Enum =>
            return KampfKonstanten.LeerKampfwert;
            
         when others =>
            return KartenDatenbank.Kartenflussliste (FlussExtern).Kampf (SpeziesExtern, KampfArtExtern);
      end case;
      
   end KampfFluss;
   
   
   
   function KampfRessource
     (RessourceExtern : in KartenextraDatentypen.Ressourcen_Enum;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      KampfArtExtern : in KampfDatentypen.Kampf_Enum)
      return KampfDatentypen.KampfwerteAllgemein
   is begin
      
      case
        RessourceExtern
      is
         when KartenextraDatentypen.Leer_Ressource_Enum =>
            return KampfKonstanten.LeerKampfwert;
            
         when others =>
            return KartenDatenbank.Kartenressourcenliste (RessourceExtern).Kampf (SpeziesExtern, KampfArtExtern);
      end case;
      
   end KampfRessource;

end LeseKartenDatenbanken;

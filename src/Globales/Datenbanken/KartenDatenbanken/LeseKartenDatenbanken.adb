with KartenDatenbank;
with KampfKonstanten;
with EinheitenKonstanten;
with ProduktionKonstanten;

with MeldungssystemHTSEB;

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
            MeldungssystemHTSEB.Logik (MeldungExtern => "LeseKartenDatenbanken.PassierbarkeitBasisgrund: Leerer Grund");
            return False;
            
         when others =>
            return KartenDatenbank.Basisgrundliste (GrundExtern).Passierbarkeit (WelcheUmgebungExtern);
      end case;
      
   end PassierbarkeitBasisgrund;
   
   
   
   function BewertungBasisgrund
     (GrundExtern : in KartengrundDatentypen.Basisgrund_Enum;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
      return ZufallsgeneratorenDatentypenHTSEB.Bewertung_Enum
   is begin
      
      case
        GrundExtern
      is
         when KartengrundDatentypen.Leer_Basisgrund_Enum =>
            MeldungssystemHTSEB.Logik (MeldungExtern => "LeseKartenDatenbanken.BewertungBasisgrund: Leerer Grund, Spezies: " & SpeziesExtern'Wide_Wide_Image);
            return ZufallsgeneratorenDatentypenHTSEB.Bewertung_Eins_Enum;
            
         when others =>
            return KartenDatenbank.Basisgrundliste (GrundExtern).Bewertung (SpeziesExtern);
      end case;
      
   end BewertungBasisgrund;
   
   
   
   function BewertungZusatzgrund
     (GrundExtern : in KartengrundDatentypen.Zusatzgrund_Enum;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
      return ZufallsgeneratorenDatentypenHTSEB.Bewertung_Enum
   is begin
      
      case
        GrundExtern
      is
         when KartengrundDatentypen.Leer_Zusatzgrund_Enum =>
            return ZufallsgeneratorenDatentypenHTSEB.Bewertung_Eins_Enum;
              
         when others =>
            return KartenDatenbank.Zusatzgrundliste (GrundExtern).Bewertung (SpeziesExtern);
      end case;
      
   end BewertungZusatzgrund;
   
   
   
   function BewegungBasisgrund
     (GrundExtern : in KartengrundDatentypen.Basisgrund_Enum;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
      return EinheitenDatentypen.BewegungspunkteVorhanden
   is begin
      
      case
        GrundExtern
      is
         when KartengrundDatentypen.Leer_Basisgrund_Enum =>
            MeldungssystemHTSEB.Logik (MeldungExtern => "LeseKartenDatenbanken.BewegungBasisgrund: Leerer Grund, Spezies: " & SpeziesExtern'Wide_Wide_Image);
            return EinheitenKonstanten.LeerBewegungspunkte;
            
         when others =>
            return KartenDatenbank.Basisgrundliste (GrundExtern).Bewegung (SpeziesExtern);
      end case;
      
   end BewegungBasisgrund;
   
   
   
   function BewegungZusatzgrund
     (GrundExtern : in KartengrundDatentypen.Zusatzgrund_Enum;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
      return EinheitenDatentypen.BewegungspunkteVorhanden
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
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
      return Boolean
   is begin
      
      case
        FlussExtern
      is
         when KartenextraDatentypen.Leer_Fluss_Enum =>
            return False;
            
         when others =>
            return KartenDatenbank.Kartenflussliste (FlussExtern).Bewertung (SpeziesExtern);
      end case;
      
   end BewertungFluss;
   
   
   
   function BewertungRessource
     (RessourceExtern : in KartenextraDatentypen.Ressourcen_Enum;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
      return Boolean
   is begin
      
      case
        RessourceExtern
      is
         when KartenextraDatentypen.Leer_Ressource_Enum =>
            return False;
            
         when others =>
            return KartenDatenbank.Kartenressourcenliste (RessourceExtern).Bewertung (SpeziesExtern);
      end case;
      
   end BewertungRessource;
   
   
   
   function ProduktionBasisgrund
     (GrundExtern : in KartengrundDatentypen.Basisgrund_Enum;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      ProduktionsartExtern : in ProduktionDatentypen.Produktion_Enum)
      return ProduktionDatentypen.Einzelproduktion
   is begin
      
      case
        GrundExtern
      is
         when KartengrundDatentypen.Leer_Basisgrund_Enum =>
            MeldungssystemHTSEB.Logik (MeldungExtern => "LeseKartenDatenbanken.ProduktionBasisgrund: Leerer Grund, Spezies: " & SpeziesExtern'Wide_Wide_Image);
            return ProduktionKonstanten.LeerProduktion;
            
         when others =>
            return KartenDatenbank.Basisgrundliste (GrundExtern).Wirtschaft (ProduktionsartExtern, SpeziesExtern);
      end case;
      
   end ProduktionBasisgrund;
   
   
   
   function ProduktionZusatzgrund
     (GrundExtern : in KartengrundDatentypen.Zusatzgrund_Enum;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      ProduktionsartExtern : in ProduktionDatentypen.Produktion_Enum)
      return ProduktionDatentypen.Einzelproduktion
   is begin
      
      case
        GrundExtern
      is
         when KartengrundDatentypen.Leer_Zusatzgrund_Enum =>
            return ProduktionKonstanten.LeerProduktion;
            
         when others =>
            return KartenDatenbank.Zusatzgrundliste (GrundExtern).Wirtschaft (ProduktionsartExtern, SpeziesExtern);
      end case;
      
   end ProduktionZusatzgrund;
   
   
   
   function ProduktionFluss
     (FlussExtern : in KartenextraDatentypen.Fluss_Enum;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      ProduktionsartExtern : in ProduktionDatentypen.Produktion_Enum)
      return ProduktionDatentypen.Produktionsbonus
   is begin
      
      case
        FlussExtern
      is
         when KartenextraDatentypen.Leer_Fluss_Enum =>
            return ProduktionKonstanten.LeerBonus;
            
         when others =>
            return KartenDatenbank.Kartenflussliste (FlussExtern).Wirtschaft (ProduktionsartExtern, SpeziesExtern);
      end case;
      
   end ProduktionFluss;
   
   
   
   function ProduktionRessourcen
     (RessourceExtern : in KartenextraDatentypen.Ressourcen_Enum;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      ProduktionsartExtern : in ProduktionDatentypen.Produktion_Enum)
      return ProduktionDatentypen.Produktionsbonus
   is begin
      
      case
        RessourceExtern
      is
         when KartenextraDatentypen.Leer_Ressource_Enum =>
            return ProduktionKonstanten.LeerBonus;
            
         when others =>
            return KartenDatenbank.Kartenressourcenliste (RessourceExtern).Wirtschaft (ProduktionsartExtern, SpeziesExtern);
      end case;
      
   end ProduktionRessourcen;
   
   
   
   function KampfBasisgrund
     (GrundExtern : in KartengrundDatentypen.Basisgrund_Enum;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      KampfartExtern : in KampfDatentypen.Kampf_Enum)
      return KampfDatentypen.Kampfbonus
   is begin
      
      case
        GrundExtern
      is
         when KartengrundDatentypen.Leer_Basisgrund_Enum =>
            MeldungssystemHTSEB.Logik (MeldungExtern => "LeseKartenDatenbanken.KampfBasisgrund: Leerer Grund, Spezies: " & SpeziesExtern'Wide_Wide_Image);
            return KampfKonstanten.LeerBonus;
            
         when others =>
            return KartenDatenbank.Basisgrundliste (GrundExtern).Kampf (KampfartExtern, SpeziesExtern);
      end case;
      
   end KampfBasisgrund;
   
   
   
   function KampfZusatzgrund
     (GrundExtern : in KartengrundDatentypen.Zusatzgrund_Enum;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      KampfartExtern : in KampfDatentypen.Kampf_Enum)
      return KampfDatentypen.Kampfbonus
   is begin
      
      case
        GrundExtern
      is
         when KartengrundDatentypen.Leer_Zusatzgrund_Enum =>
            return KampfKonstanten.LeerBonus;
            
         when others =>
            return KartenDatenbank.Zusatzgrundliste (GrundExtern).Kampf (KampfartExtern, SpeziesExtern);
      end case;
      
   end KampfZusatzgrund;
   
   
   
   function KampfFluss
     (FlussExtern : in KartenextraDatentypen.Fluss_Enum;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      KampfartExtern : in KampfDatentypen.Kampf_Enum)
      return KampfDatentypen.Kampfbonus
   is begin
      
      case
        FlussExtern
      is
         when KartenextraDatentypen.Leer_Fluss_Enum =>
            return KampfKonstanten.LeerBonus;
            
         when others =>
            return KartenDatenbank.Kartenflussliste (FlussExtern).Kampf (KampfartExtern, SpeziesExtern);
      end case;
      
   end KampfFluss;
   
   
   
   function KampfRessource
     (RessourceExtern : in KartenextraDatentypen.Ressourcen_Enum;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      KampfartExtern : in KampfDatentypen.Kampf_Enum)
      return KampfDatentypen.Kampfbonus
   is begin
      
      case
        RessourceExtern
      is
         when KartenextraDatentypen.Leer_Ressource_Enum =>
            return KampfKonstanten.LeerBonus;
            
         when others =>
            return KartenDatenbank.Kartenressourcenliste (RessourceExtern).Kampf (KampfartExtern, SpeziesExtern);
      end case;
      
   end KampfRessource;

end LeseKartenDatenbanken;

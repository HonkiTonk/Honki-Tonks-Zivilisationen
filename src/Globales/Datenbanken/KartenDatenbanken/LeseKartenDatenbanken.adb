pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatenbank;

package body LeseKartenDatenbanken is

   function Passierbarkeit
     (GrundExtern : in KartengrundDatentypen.Kartengrund_Vorhanden_Enum;
      WelcheUmgebungExtern : in EinheitenDatentypen.Passierbarkeit_Enum)
      return Boolean
   is begin
      
      return KartenDatenbank.Kartengrundliste (GrundExtern).Passierbarkeit (WelcheUmgebungExtern);
      
   end Passierbarkeit;
   
   
   
   function BewertungGrund
     (GrundExtern : in KartengrundDatentypen.Kartengrund_Vorhanden_Enum;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return KartenDatentypen.Einzelbewertung
   is begin
      
      return KartenDatenbank.Kartengrundliste (GrundExtern).Bewertung (RasseExtern);
      
   end BewertungGrund;
   
   
   
   function BewertungFluss
     (FlussExtern : in KartengrundDatentypen.Kartenfluss_Vorhanden_Enum;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return KartenDatentypen.Einzelbewertung
   is begin
      
      return KartenDatenbank.Kartenflussliste (FlussExtern).Bewertung (RasseExtern);
      
   end BewertungFluss;
   
   
   
   function BewertungRessource
     (RessourceExtern : in KartengrundDatentypen.Kartenressourcen_Vorhanden_Enum;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return KartenDatentypen.Einzelbewertung
   is begin
      
      return KartenDatenbank.Kartenressourcenliste (RessourceExtern).Bewertung (RasseExtern);
      
   end BewertungRessource;
   
   
   
   function WirtschaftGrund
     (GrundExtern : in KartengrundDatentypen.Kartengrund_Vorhanden_Enum;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      WirtschaftArtExtern : in KartenDatentypen.Wirtschaft_Enum)
      return ProduktionDatentypen.Einzelproduktion
   is begin
      
      return KartenDatenbank.Kartengrundliste (GrundExtern).Wirtschaft (RasseExtern, WirtschaftArtExtern);
      
   end WirtschaftGrund;
   
   
   
   function WirtschaftFluss
     (FlussExtern : in KartengrundDatentypen.Kartenfluss_Vorhanden_Enum;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      WirtschaftArtExtern : in KartenDatentypen.Wirtschaft_Enum)
      return ProduktionDatentypen.Einzelproduktion
   is begin
      
      return KartenDatenbank.Kartenflussliste (FlussExtern).Wirtschaft (RasseExtern, WirtschaftArtExtern);
      
   end WirtschaftFluss;
   
   
   
   function WirtschaftRessourcen
     (RessourceExtern : in KartengrundDatentypen.Kartenressourcen_Vorhanden_Enum;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      WirtschaftArtExtern : in KartenDatentypen.Wirtschaft_Enum)
      return ProduktionDatentypen.Einzelproduktion
   is begin
      
      return KartenDatenbank.Kartenressourcenliste (RessourceExtern).Wirtschaft (RasseExtern, WirtschaftArtExtern);
      
   end WirtschaftRessourcen;
   
   
   
   function KampfGrund
     (GrundExtern : in KartengrundDatentypen.Kartengrund_Vorhanden_Enum;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      KampfArtExtern : in KartenDatentypen.Kampf_Enum)
      return KampfDatentypen.KampfwerteAllgemein
   is begin
      
      return KartenDatenbank.Kartengrundliste (GrundExtern).Kampf (RasseExtern, KampfArtExtern);
      
   end KampfGrund;
   
   
   
   function KampfFluss
     (FlussExtern : in KartengrundDatentypen.Kartenfluss_Vorhanden_Enum;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      KampfArtExtern : in KartenDatentypen.Kampf_Enum)
      return KampfDatentypen.KampfwerteAllgemein
   is begin
      
      return KartenDatenbank.Kartenflussliste (FlussExtern).Kampf (RasseExtern, KampfArtExtern);
      
   end KampfFluss;
   
   
   
   function KampfRessource
     (RessourceExtern : in KartengrundDatentypen.Kartenressourcen_Vorhanden_Enum;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      KampfArtExtern : in KartenDatentypen.Kampf_Enum)
      return KampfDatentypen.KampfwerteAllgemein
   is begin
      
      return KartenDatenbank.Kartenressourcenliste (RessourceExtern).Kampf (RasseExtern, KampfArtExtern);
      
   end KampfRessource;

end LeseKartenDatenbanken;

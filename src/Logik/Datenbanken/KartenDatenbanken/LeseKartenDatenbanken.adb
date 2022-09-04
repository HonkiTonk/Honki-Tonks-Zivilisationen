pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartengrundDatenbank;
with KartenflussDatenbank;
with KartenressourcenDatenbank;

package body LeseKartenDatenbanken is

   function Passierbarkeit
     (GrundExtern : in KartengrundDatentypen.Kartengrund_Vorhanden_Enum;
      WelcheUmgebungExtern : in EinheitenDatentypen.Passierbarkeit_Vorhanden_Enum)
      return Boolean
   is begin
      
      return KartengrundDatenbank.Kartengrundliste (GrundExtern).Passierbarkeit (WelcheUmgebungExtern);
      
   end Passierbarkeit;
   
   
   
   function BewertungGrund
     (GrundExtern : in KartengrundDatentypen.Kartengrund_Vorhanden_Enum;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return KartenDatentypen.Einzelbewertung
   is begin
      
      return KartengrundDatenbank.Kartengrundliste (GrundExtern).Bewertung (RasseExtern);
      
   end BewertungGrund;
   
   
   
   function BewertungFluss
     (FlussExtern : in KartengrundDatentypen.Kartenfluss_Vorhanden_Enum;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return KartenDatentypen.Einzelbewertung
   is begin
      
      return KartenflussDatenbank.Kartenflussliste (FlussExtern).Bewertung (RasseExtern);
      
   end BewertungFluss;
   
   
   
   function BewertungRessource
     (RessourceExtern : in KartengrundDatentypen.Kartenressourcen_Vorhanden_Enum;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return KartenDatentypen.Einzelbewertung
   is begin
      
      return KartenressourcenDatenbank.Kartenressourcenliste (RessourceExtern).Bewertung (RasseExtern);
      
   end BewertungRessource;
   
   
   
   function WirtschaftGrund
     (GrundExtern : in KartengrundDatentypen.Kartengrund_Vorhanden_Enum;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      WirtschaftArtExtern : in KartenDatentypen.Wirtschaft_Enum)
      return ProduktionDatentypen.Einzelproduktion
   is begin
      
      return KartengrundDatenbank.Kartengrundliste (GrundExtern).Wirtschaft (RasseExtern, WirtschaftArtExtern);
      
   end WirtschaftGrund;
   
   
   
   function WirtschaftFluss
     (FlussExtern : in KartengrundDatentypen.Kartenfluss_Vorhanden_Enum;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      WirtschaftArtExtern : in KartenDatentypen.Wirtschaft_Enum)
      return ProduktionDatentypen.Einzelproduktion
   is begin
      
      return KartenflussDatenbank.Kartenflussliste (FlussExtern).Wirtschaft (RasseExtern, WirtschaftArtExtern);
      
   end WirtschaftFluss;
   
   
   
   function WirtschaftRessourcen
     (RessourceExtern : in KartengrundDatentypen.Kartenressourcen_Vorhanden_Enum;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      WirtschaftArtExtern : in KartenDatentypen.Wirtschaft_Enum)
      return ProduktionDatentypen.Einzelproduktion
   is begin
      
      return KartenressourcenDatenbank.Kartenressourcenliste (RessourceExtern).Wirtschaft (RasseExtern, WirtschaftArtExtern);
      
   end WirtschaftRessourcen;
   
   
   
   function KampfGrund
     (GrundExtern : in KartengrundDatentypen.Kartengrund_Vorhanden_Enum;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      KampfArtExtern : in KartenDatentypen.Kampf_Enum)
      return KampfDatentypen.KampfwerteAllgemein
   is begin
      
      return KartengrundDatenbank.Kartengrundliste (GrundExtern).Kampf (RasseExtern, KampfArtExtern);
      
   end KampfGrund;
   
   
   
   function KampfFluss
     (FlussExtern : in KartengrundDatentypen.Kartenfluss_Vorhanden_Enum;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      KampfArtExtern : in KartenDatentypen.Kampf_Enum)
      return KampfDatentypen.KampfwerteAllgemein
   is begin
      
      return KartenflussDatenbank.Kartenflussliste (FlussExtern).Kampf (RasseExtern, KampfArtExtern);
      
   end KampfFluss;
   
   
   
   function KampfRessource
     (RessourceExtern : in KartengrundDatentypen.Kartenressourcen_Vorhanden_Enum;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      KampfArtExtern : in KartenDatentypen.Kampf_Enum)
      return KampfDatentypen.KampfwerteAllgemein
   is begin
      
      return KartenressourcenDatenbank.Kartenressourcenliste (RessourceExtern).Kampf (RasseExtern, KampfArtExtern);
      
   end KampfRessource;

end LeseKartenDatenbanken;

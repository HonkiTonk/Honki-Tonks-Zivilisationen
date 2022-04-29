pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatenbank;

package body LeseKartenDatenbank is

   function Passierbarkeit
     (GrundExtern : in KartengrundDatentypen.Kartengrund_Vorhanden_Enum;
      WelcheUmgebungExtern : in EinheitStadtDatentypen.Passierbarkeit_Vorhanden_Enum)
      return Boolean
   is begin
      
      return KartenDatenbank.Kartengrundliste (GrundExtern).Passierbarkeit (WelcheUmgebungExtern);
      
   end Passierbarkeit;
   
   
   
   function BewertungGrund
     (GrundExtern : in KartengrundDatentypen.Kartengrund_Vorhanden_Enum;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return KartenDatentypen.BewertungFeld
   is begin
      
      return KartenDatenbank.Kartengrundliste (GrundExtern).Bewertung (RasseExtern);
      
   end BewertungGrund;
   
   
   
   function BewertungFluss
     (FlussExtern : in KartengrundDatentypen.Kartenfluss_Vorhanden_Enum;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return KartenDatentypen.BewertungFeld
   is begin
      
      return KartenDatenbank.Kartenflussliste (FlussExtern).Bewertung (RasseExtern);
      
   end BewertungFluss;
   
   
   
   function BewertungRessource
     (RessourceExtern : in KartengrundDatentypen.Karten_Ressourcen_Vorhanden_Enum;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return KartenDatentypen.BewertungFeld
   is begin
      
      return KartenDatenbank.KartenRessourcenListe (RessourceExtern).Bewertung (RasseExtern);
      
   end BewertungRessource;
   
   
   
   function WirtschaftGrund
     (GrundExtern : in KartengrundDatentypen.Kartengrund_Vorhanden_Enum;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      WirtschaftArtExtern : in KartenDatentypen.Wirtschaft_Enum)
      return EinheitStadtDatentypen.ProduktionElement
   is begin
      
      return KartenDatenbank.Kartengrundliste (GrundExtern).Wirtschaft (RasseExtern, WirtschaftArtExtern);
      
   end WirtschaftGrund;
   
   
   
   function WirtschaftFluss
     (FlussExtern : in KartengrundDatentypen.Kartenfluss_Vorhanden_Enum;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      WirtschaftArtExtern : in KartenDatentypen.Wirtschaft_Enum)
      return EinheitStadtDatentypen.ProduktionElement
   is begin
      
      return KartenDatenbank.Kartenflussliste (FlussExtern).Wirtschaft (RasseExtern, WirtschaftArtExtern);
      
   end WirtschaftFluss;
   
   
   
   function WirtschaftRessourcen
     (RessourceExtern : in KartengrundDatentypen.Karten_Ressourcen_Vorhanden_Enum;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      WirtschaftArtExtern : in KartenDatentypen.Wirtschaft_Enum)
      return EinheitStadtDatentypen.ProduktionElement
   is begin
      
      return KartenDatenbank.KartenRessourcenListe (RessourceExtern).Wirtschaft (RasseExtern, WirtschaftArtExtern);
      
   end WirtschaftRessourcen;
   
   
   
   function KampfGrund
     (GrundExtern : in KartengrundDatentypen.Kartengrund_Vorhanden_Enum;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      KampfArtExtern : in KartenDatentypen.Kampf_Enum)
      return EinheitStadtDatentypen.KampfwerteAllgemein
   is begin
      
      return KartenDatenbank.Kartengrundliste (GrundExtern).Kampf (RasseExtern, KampfArtExtern);
      
   end KampfGrund;
   
   
   
   function KampfFluss
     (FlussExtern : in KartengrundDatentypen.Kartenfluss_Vorhanden_Enum;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      KampfArtExtern : in KartenDatentypen.Kampf_Enum)
      return EinheitStadtDatentypen.KampfwerteAllgemein
   is begin
      
      return KartenDatenbank.Kartenflussliste (FlussExtern).Kampf (RasseExtern, KampfArtExtern);
      
   end KampfFluss;
   
   
   
   function KampfRessource
     (RessourceExtern : in KartengrundDatentypen.Karten_Ressourcen_Vorhanden_Enum;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      KampfArtExtern : in KartenDatentypen.Kampf_Enum)
      return EinheitStadtDatentypen.KampfwerteAllgemein
   is begin
      
      return KartenDatenbank.KartenRessourcenListe (RessourceExtern).Kampf (RasseExtern, KampfArtExtern);
      
   end KampfRessource;
   
   
   
   function GanzerEintragGrund
     (GrundExtern : in KartengrundDatentypen.Kartengrund_Vorhanden_Enum)
      return DatenbankRecords.KartengrundlisteRecord
   is begin
      
      return KartenDatenbank.Kartengrundliste (GrundExtern);
      
   end GanzerEintragGrund;
   
   
   
   function GanzerEintragFluss
     (FlussExtern : in KartengrundDatentypen.Kartenfluss_Vorhanden_Enum)
      return DatenbankRecords.KartenlisteRecord
   is begin
      
      return KartenDatenbank.Kartenflussliste (FlussExtern);
      
   end GanzerEintragFluss;
   
   
   
   function GanzerEintragRessource
     (RessourceExtern : in KartengrundDatentypen.Karten_Ressourcen_Vorhanden_Enum)
      return DatenbankRecords.KartenlisteRecord
   is begin
      
      return KartenDatenbank.KartenRessourcenListe (RessourceExtern);
      
   end GanzerEintragRessource;

end LeseKartenDatenbank;

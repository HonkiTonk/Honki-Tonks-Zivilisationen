pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatenbank;

package body LeseKartenDatenbank is

   function Passierbarkeit
     (GrundExtern : in KartenGrundDatentypen.Karten_Grund_Vorhanden_Enum;
      WelcheUmgebungExtern : in EinheitStadtDatentypen.Passierbarkeit_Vorhanden_Enum)
      return Boolean
   is begin
      
      return KartenDatenbank.KartenGrundListe (GrundExtern).Passierbarkeit (WelcheUmgebungExtern);
      
   end Passierbarkeit;
   
   
   
   function BewertungGrund
     (GrundExtern : in KartenGrundDatentypen.Karten_Grund_Vorhanden_Enum;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return KartenDatentypen.BewertungFeld
   is begin
      
      return KartenDatenbank.KartenGrundListe (GrundExtern).Bewertung (RasseExtern);
      
   end BewertungGrund;
   
   
   
   function BewertungFluss
     (FlussExtern : in KartenGrundDatentypen.Karten_Alle_Flüsse_Vorhanden_Enum;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return KartenDatentypen.BewertungFeld
   is begin
      
      return KartenDatenbank.KartenFlussListe (FlussExtern).Bewertung (RasseExtern);
      
   end BewertungFluss;
   
   
   
   function BewertungRessource
     (RessourceExtern : in KartenGrundDatentypen.Karten_Ressourcen_Vorhanden_Enum;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return KartenDatentypen.BewertungFeld
   is begin
      
      return KartenDatenbank.KartenRessourcenListe (RessourceExtern).Bewertung (RasseExtern);
      
   end BewertungRessource;
   
   
   
   function WirtschaftGrund
     (GrundExtern : in KartenGrundDatentypen.Karten_Grund_Vorhanden_Enum;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      WirtschaftArtExtern : in KartenDatentypen.Wirtschaft_Enum)
      return EinheitStadtDatentypen.ProduktionElement
   is begin
      
      return KartenDatenbank.KartenGrundListe (GrundExtern).Wirtschaft (RasseExtern, WirtschaftArtExtern);
      
   end WirtschaftGrund;
   
   
   
   function WirtschaftFluss
     (FlussExtern : in KartenGrundDatentypen.Karten_Alle_Flüsse_Vorhanden_Enum;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      WirtschaftArtExtern : in KartenDatentypen.Wirtschaft_Enum)
      return EinheitStadtDatentypen.ProduktionElement
   is begin
      
      return KartenDatenbank.KartenFlussListe (FlussExtern).Wirtschaft (RasseExtern, WirtschaftArtExtern);
      
   end WirtschaftFluss;
   
   
   
   function WirtschaftRessourcen
     (RessourceExtern : in KartenGrundDatentypen.Karten_Ressourcen_Vorhanden_Enum;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      WirtschaftArtExtern : in KartenDatentypen.Wirtschaft_Enum)
      return EinheitStadtDatentypen.ProduktionElement
   is begin
      
      return KartenDatenbank.KartenRessourcenListe (RessourceExtern).Wirtschaft (RasseExtern, WirtschaftArtExtern);
      
   end WirtschaftRessourcen;
   
   
   
   function KampfGrund
     (GrundExtern : in KartenGrundDatentypen.Karten_Grund_Vorhanden_Enum;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      KampfArtExtern : in KartenDatentypen.Kampf_Enum)
      return EinheitStadtDatentypen.KampfwerteAllgemein
   is begin
      
      return KartenDatenbank.KartenGrundListe (GrundExtern).Kampf (RasseExtern, KampfArtExtern);
      
   end KampfGrund;
   
   
   
   function KampfFluss
     (FlussExtern : in KartenGrundDatentypen.Karten_Alle_Flüsse_Vorhanden_Enum;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      KampfArtExtern : in KartenDatentypen.Kampf_Enum)
      return EinheitStadtDatentypen.KampfwerteAllgemein
   is begin
      
      return KartenDatenbank.KartenFlussListe (FlussExtern).Kampf (RasseExtern, KampfArtExtern);
      
   end KampfFluss;
   
   
   
   function KampfRessource
     (RessourceExtern : in KartenGrundDatentypen.Karten_Ressourcen_Vorhanden_Enum;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      KampfArtExtern : in KartenDatentypen.Kampf_Enum)
      return EinheitStadtDatentypen.KampfwerteAllgemein
   is begin
      
      return KartenDatenbank.KartenRessourcenListe (RessourceExtern).Kampf (RasseExtern, KampfArtExtern);
      
   end KampfRessource;
   
   
   
   function GanzerEintragGrund
     (GrundExtern : in KartenGrundDatentypen.Karten_Grund_Vorhanden_Enum)
      return DatenbankRecords.KartenGrundListeRecord
   is begin
      
      return KartenDatenbank.KartenGrundListe (GrundExtern);
      
   end GanzerEintragGrund;
   
   
   
   function GanzerEintragFluss
     (FlussExtern : in KartenGrundDatentypen.Karten_Alle_Flüsse_Vorhanden_Enum)
      return DatenbankRecords.KartenListeRecord
   is begin
      
      return KartenDatenbank.KartenFlussListe (FlussExtern);
      
   end GanzerEintragFluss;
   
   
   
   function GanzerEintragRessource
     (RessourceExtern : in KartenGrundDatentypen.Karten_Ressourcen_Vorhanden_Enum)
      return DatenbankRecords.KartenListeRecord
   is begin
      
      return KartenDatenbank.KartenRessourcenListe (RessourceExtern);
      
   end GanzerEintragRessource;

end LeseKartenDatenbank;

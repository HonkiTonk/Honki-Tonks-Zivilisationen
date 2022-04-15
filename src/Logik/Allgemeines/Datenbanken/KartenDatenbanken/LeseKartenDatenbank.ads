pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RassenDatentypen; use RassenDatentypen;
with GlobaleVariablen;
with KartenDatentypen;
with EinheitStadtDatentypen;
with KartenGrundDatentypen;

with DatenbankRecords;

package LeseKartenDatenbank is

   function Passierbarkeit
     (GrundExtern : in KartenGrundDatentypen.Karten_Grund_Vorhanden_Enum;
      WelcheUmgebungExtern : in EinheitStadtDatentypen.Passierbarkeit_Vorhanden_Enum)
      return Boolean;
   
   function BewertungGrund
     (GrundExtern : in KartenGrundDatentypen.Karten_Grund_Vorhanden_Enum;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return KartenDatentypen.BewertungFeld
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= RassenDatentypen.Leer_Spieler_Enum);
   
   function BewertungFluss
     (FlussExtern : in KartenGrundDatentypen.Karten_Alle_Flüsse_Vorhanden_Enum;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return KartenDatentypen.BewertungFeld
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= RassenDatentypen.Leer_Spieler_Enum);
   
   function BewertungRessource
     (RessourceExtern : in KartenGrundDatentypen.Karten_Ressourcen_Vorhanden_Enum;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return KartenDatentypen.BewertungFeld
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= RassenDatentypen.Leer_Spieler_Enum);
   
   function WirtschaftGrund
     (GrundExtern : in KartenGrundDatentypen.Karten_Grund_Vorhanden_Enum;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      WirtschaftArtExtern : in KartenDatentypen.Wirtschaft_Enum)
      return EinheitStadtDatentypen.ProduktionElement
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= RassenDatentypen.Leer_Spieler_Enum);
   
   function WirtschaftFluss
     (FlussExtern : in KartenGrundDatentypen.Karten_Alle_Flüsse_Vorhanden_Enum;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      WirtschaftArtExtern : in KartenDatentypen.Wirtschaft_Enum)
      return EinheitStadtDatentypen.ProduktionElement
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= RassenDatentypen.Leer_Spieler_Enum);
   
   function WirtschaftRessourcen
     (RessourceExtern : in KartenGrundDatentypen.Karten_Ressourcen_Vorhanden_Enum;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      WirtschaftArtExtern : in KartenDatentypen.Wirtschaft_Enum)
      return EinheitStadtDatentypen.ProduktionElement
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= RassenDatentypen.Leer_Spieler_Enum);
   
   function KampfGrund
     (GrundExtern : in KartenGrundDatentypen.Karten_Grund_Vorhanden_Enum;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      KampfArtExtern : in KartenDatentypen.Kampf_Enum)
      return EinheitStadtDatentypen.KampfwerteAllgemein
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= RassenDatentypen.Leer_Spieler_Enum);
   
   function KampfFluss
     (FlussExtern : in KartenGrundDatentypen.Karten_Alle_Flüsse_Vorhanden_Enum;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      KampfArtExtern : in KartenDatentypen.Kampf_Enum)
      return EinheitStadtDatentypen.KampfwerteAllgemein
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= RassenDatentypen.Leer_Spieler_Enum);
   
   function KampfRessource
     (RessourceExtern : in KartenGrundDatentypen.Karten_Ressourcen_Vorhanden_Enum;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      KampfArtExtern : in KartenDatentypen.Kampf_Enum)
      return EinheitStadtDatentypen.KampfwerteAllgemein
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= RassenDatentypen.Leer_Spieler_Enum);
   
   function GanzerEintragGrund
     (GrundExtern : in KartenGrundDatentypen.Karten_Grund_Vorhanden_Enum)
      return DatenbankRecords.KartenGrundListeRecord;
         
   function GanzerEintragFluss
     (FlussExtern : in KartenGrundDatentypen.Karten_Alle_Flüsse_Vorhanden_Enum)
      return DatenbankRecords.KartenListeRecord;
         
   function GanzerEintragRessource
     (RessourceExtern : in KartenGrundDatentypen.Karten_Ressourcen_Vorhanden_Enum)
      return DatenbankRecords.KartenListeRecord;

end LeseKartenDatenbank;

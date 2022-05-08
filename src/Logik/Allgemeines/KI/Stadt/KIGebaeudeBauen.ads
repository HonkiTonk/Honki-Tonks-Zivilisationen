pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RassenDatentypen; use RassenDatentypen;
with EinheitStadtRecords;
with SonstigeVariablen;
with EinheitStadtDatentypen;

with KIDatentypen;
with KIRecords;

package KIGebaeudeBauen is

   function GebäudeBauen
     (StadtRasseNummerExtern : in EinheitStadtRecords.RasseEinheitnummerRecord)
      return KIRecords.GebäudeIDBewertungRecord
     with
       Pre =>
         (StadtRasseNummerExtern.Nummer in EinheitStadtDatentypen.MaximaleStädte'Range
          and
            SonstigeVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) = RassenDatentypen.Spieler_KI_Enum);
   
private
   
   Gesamtwertung : KIDatentypen.BauenBewertung;
   
   GebäudeBewertet : KIRecords.GebäudeIDBewertungRecord;
   
   procedure GebäudeBewerten
     (StadtRasseNummerExtern : in EinheitStadtRecords.RasseEinheitnummerRecord;
      IDExtern : in EinheitStadtDatentypen.GebäudeID)
     with
       Pre =>
         (StadtRasseNummerExtern.Nummer in EinheitStadtDatentypen.MaximaleStädte'Range
          and
            SonstigeVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) = RassenDatentypen.Spieler_KI_Enum);
   
   
   
   function NahrungsproduktionBewerten
     (StadtRasseNummerExtern : in EinheitStadtRecords.RasseEinheitnummerRecord;
      IDExtern : in EinheitStadtDatentypen.GebäudeID)
      return KIDatentypen.BauenBewertung
     with
       Pre =>
         (StadtRasseNummerExtern.Nummer in EinheitStadtDatentypen.MaximaleStädte'Range
          and
            SonstigeVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) = RassenDatentypen.Spieler_KI_Enum);
   
   function GeldproduktionBewerten
     (StadtRasseNummerExtern : in EinheitStadtRecords.RasseEinheitnummerRecord;
      IDExtern : in EinheitStadtDatentypen.GebäudeID)
      return KIDatentypen.BauenBewertung
     with
       Pre =>
         (StadtRasseNummerExtern.Nummer in EinheitStadtDatentypen.MaximaleStädte'Range
          and
            SonstigeVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) = RassenDatentypen.Spieler_KI_Enum);
     
   function WissensgewinnBewerten
     (StadtRasseNummerExtern : in EinheitStadtRecords.RasseEinheitnummerRecord;
      IDExtern : in EinheitStadtDatentypen.GebäudeID)
      return KIDatentypen.BauenBewertung
     with
       Pre =>
         (StadtRasseNummerExtern.Nummer in EinheitStadtDatentypen.MaximaleStädte'Range
          and
            SonstigeVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) = RassenDatentypen.Spieler_KI_Enum);
          
   function RessourcenproduktionBewerten
     (StadtRasseNummerExtern : in EinheitStadtRecords.RasseEinheitnummerRecord;
      IDExtern : in EinheitStadtDatentypen.GebäudeID)
      return KIDatentypen.BauenBewertung
     with
       Pre =>
         (StadtRasseNummerExtern.Nummer in EinheitStadtDatentypen.MaximaleStädte'Range
          and
            SonstigeVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) = RassenDatentypen.Spieler_KI_Enum);
     
   function VerteidigungBewerten
     (StadtRasseNummerExtern : in EinheitStadtRecords.RasseEinheitnummerRecord;
      IDExtern : in EinheitStadtDatentypen.GebäudeID)
      return KIDatentypen.BauenBewertung
     with
       Pre =>
         (StadtRasseNummerExtern.Nummer in EinheitStadtDatentypen.MaximaleStädte'Range
          and
            SonstigeVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) = RassenDatentypen.Spieler_KI_Enum);
     
   function AngriffBewerten
     (StadtRasseNummerExtern : in EinheitStadtRecords.RasseEinheitnummerRecord;
      IDExtern : in EinheitStadtDatentypen.GebäudeID)
      return KIDatentypen.BauenBewertung
     with
       Pre =>
         (StadtRasseNummerExtern.Nummer in EinheitStadtDatentypen.MaximaleStädte'Range
          and
            SonstigeVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) = RassenDatentypen.Spieler_KI_Enum);
     
   function KostenBewerten
     (StadtRasseNummerExtern : in EinheitStadtRecords.RasseEinheitnummerRecord;
      IDExtern : in EinheitStadtDatentypen.GebäudeID)
      return KIDatentypen.BauenBewertung
     with
       Pre =>
         (StadtRasseNummerExtern.Nummer in EinheitStadtDatentypen.MaximaleStädte'Range
          and
            SonstigeVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) = RassenDatentypen.Spieler_KI_Enum);

end KIGebaeudeBauen;

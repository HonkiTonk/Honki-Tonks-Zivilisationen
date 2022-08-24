pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RassenDatentypen; use RassenDatentypen;
with StadtRecords;
with SpielVariablen;

private with StadtDatentypen;

with KIRecords;

private with KIDatentypen;

package KIGebaeudeBauen is

   function GebäudeBauen
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
      return KIRecords.GebäudeIDBewertungRecord
     with
       Pre => (
                 StadtRasseNummerExtern.Nummer in SpielVariablen.StadtGebautArray'First (2) .. SpielVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
               and
                 SpielVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) = RassenDatentypen.KI_Spieler_Enum
              );
   
private
   
   Gesamtwertung : KIDatentypen.BauenBewertung;
   Gebäudewertung : KIDatentypen.BauenBewertung;
   
   GebäudeBewertet : KIRecords.GebäudeIDBewertungRecord;
   
   
   
   function GebäudeBewerten
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      IDExtern : in StadtDatentypen.GebäudeID)
      return KIDatentypen.BauenBewertung
     with
       Pre => (
                 StadtRasseNummerExtern.Nummer in SpielVariablen.StadtGebautArray'First (2) .. SpielVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
               and
                 SpielVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) = RassenDatentypen.KI_Spieler_Enum
              );
   
   function NahrungsproduktionBewerten
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      IDExtern : in StadtDatentypen.GebäudeID)
      return KIDatentypen.BauenBewertung
     with
       Pre => (
                 StadtRasseNummerExtern.Nummer in SpielVariablen.StadtGebautArray'First (2) .. SpielVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
               and
                 SpielVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) = RassenDatentypen.KI_Spieler_Enum
              );
   
   function GeldproduktionBewerten
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      IDExtern : in StadtDatentypen.GebäudeID)
      return KIDatentypen.BauenBewertung
     with
       Pre => (
                 StadtRasseNummerExtern.Nummer in SpielVariablen.StadtGebautArray'First (2) .. SpielVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
               and
                 SpielVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) = RassenDatentypen.KI_Spieler_Enum
              );
     
   function WissensgewinnBewerten
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      IDExtern : in StadtDatentypen.GebäudeID)
      return KIDatentypen.BauenBewertung
     with
       Pre => (
                 StadtRasseNummerExtern.Nummer in SpielVariablen.StadtGebautArray'First (2) .. SpielVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
               and
                 SpielVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) = RassenDatentypen.KI_Spieler_Enum
              );
          
   function RessourcenproduktionBewerten
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      IDExtern : in StadtDatentypen.GebäudeID)
      return KIDatentypen.BauenBewertung
     with
       Pre => (
                 StadtRasseNummerExtern.Nummer in SpielVariablen.StadtGebautArray'First (2) .. SpielVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
               and
                 SpielVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) = RassenDatentypen.KI_Spieler_Enum
              );
     
   function VerteidigungBewerten
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      IDExtern : in StadtDatentypen.GebäudeID)
      return KIDatentypen.BauenBewertung
     with
       Pre => (
                 StadtRasseNummerExtern.Nummer in SpielVariablen.StadtGebautArray'First (2) .. SpielVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
               and
                 SpielVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) = RassenDatentypen.KI_Spieler_Enum
              );
     
   function AngriffBewerten
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      IDExtern : in StadtDatentypen.GebäudeID)
      return KIDatentypen.BauenBewertung
     with
       Pre => (
                 StadtRasseNummerExtern.Nummer in SpielVariablen.StadtGebautArray'First (2) .. SpielVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
               and
                 SpielVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) = RassenDatentypen.KI_Spieler_Enum
              );
     
   function KostenBewerten
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      IDExtern : in StadtDatentypen.GebäudeID)
      return KIDatentypen.BauenBewertung
     with
       Pre => (
                 StadtRasseNummerExtern.Nummer in SpielVariablen.StadtGebautArray'First (2) .. SpielVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
               and
                 SpielVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) = RassenDatentypen.KI_Spieler_Enum
              );

end KIGebaeudeBauen;

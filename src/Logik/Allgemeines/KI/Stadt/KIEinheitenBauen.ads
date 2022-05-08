pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RassenDatentypen; use RassenDatentypen;
with EinheitStadtRecords;
with SonstigeVariablen;
with EinheitStadtDatentypen;

with KIDatentypen;
with KIRecords;

package KIEinheitenBauen is

   function EinheitenBauen
     (StadtRasseNummerExtern : in EinheitStadtRecords.RasseEinheitnummerRecord)
      return KIRecords.EinheitIDBewertungRecord
     with
       Pre =>
         (StadtRasseNummerExtern.Nummer in EinheitStadtDatentypen.MaximaleStädte'Range
          and
            SonstigeVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) = RassenDatentypen.Spieler_KI_Enum);
   
private
      
   AnzahlStädte : EinheitStadtDatentypen.MaximaleStädteMitNullWert;
   
   Gesamtwertung : KIDatentypen.BauenBewertung;
   
   MinimaleSiedlerMenge : constant EinheitStadtDatentypen.MaximaleStädte := 2;
   
   MengeVorhanden : EinheitStadtDatentypen.MaximaleEinheitenMitNullWert;
   MengeImBau : EinheitStadtDatentypen.MaximaleStädteMitNullWert;
   
   EinheitBewertet : KIRecords.EinheitIDBewertungRecord;
   
   procedure EinheitBewerten
     (StadtRasseNummerExtern : in EinheitStadtRecords.RasseEinheitnummerRecord;
      IDExtern : in EinheitStadtDatentypen.EinheitenID)
     with
       Pre =>
         (StadtRasseNummerExtern.Nummer in EinheitStadtDatentypen.MaximaleStädte'Range
          and
            SonstigeVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) = RassenDatentypen.Spieler_KI_Enum);
     
     
   
   function ArbeiterBewerten
     (StadtRasseNummerExtern : in EinheitStadtRecords.RasseEinheitnummerRecord;
      EinheitenIDExtern : in EinheitStadtDatentypen.EinheitenID)
      return KIDatentypen.BauenBewertung
     with
       Pre =>
         (StadtRasseNummerExtern.Nummer in EinheitStadtDatentypen.MaximaleStädte'Range
          and
            SonstigeVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) = RassenDatentypen.Spieler_KI_Enum);
   
   function NahkämpferBewerten
     (StadtRasseNummerExtern : in EinheitStadtRecords.RasseEinheitnummerRecord;
      EinheitenIDExtern : in EinheitStadtDatentypen.EinheitenID)
      return KIDatentypen.BauenBewertung
     with
       Pre =>
         (StadtRasseNummerExtern.Nummer in EinheitStadtDatentypen.MaximaleStädte'Range
          and
            SonstigeVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) = RassenDatentypen.Spieler_KI_Enum);
   
   function FernkämpferBewerten
     (StadtRasseNummerExtern : in EinheitStadtRecords.RasseEinheitnummerRecord;
      EinheitenIDExtern : in EinheitStadtDatentypen.EinheitenID)
      return KIDatentypen.BauenBewertung
     with
       Pre =>
         (StadtRasseNummerExtern.Nummer in EinheitStadtDatentypen.MaximaleStädte'Range
          and
            SonstigeVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) = RassenDatentypen.Spieler_KI_Enum);
   
   function KostenBewerten
     (StadtRasseNummerExtern : in EinheitStadtRecords.RasseEinheitnummerRecord;
      EinheitenIDExtern : in EinheitStadtDatentypen.EinheitenID)
      return KIDatentypen.BauenBewertung
     with
       Pre =>
         (StadtRasseNummerExtern.Nummer in EinheitStadtDatentypen.MaximaleStädte'Range
          and
            SonstigeVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) = RassenDatentypen.Spieler_KI_Enum);
     
   function GeldKostenBewerten
     (StadtRasseNummerExtern : in EinheitStadtRecords.RasseEinheitnummerRecord;
      EinheitenIDExtern : in EinheitStadtDatentypen.EinheitenID)
      return KIDatentypen.BauenBewertung
     with
       Pre =>
         (StadtRasseNummerExtern.Nummer in EinheitStadtDatentypen.MaximaleStädte'Range
          and
            SonstigeVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) = RassenDatentypen.Spieler_KI_Enum);
   
   function NahrungKostenBewerten
     (StadtRasseNummerExtern : in EinheitStadtRecords.RasseEinheitnummerRecord;
      EinheitenIDExtern : in EinheitStadtDatentypen.EinheitenID)
      return KIDatentypen.BauenBewertung
     with
       Pre =>
         (StadtRasseNummerExtern.Nummer in EinheitStadtDatentypen.MaximaleStädte'Range
          and
            SonstigeVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) = RassenDatentypen.Spieler_KI_Enum);
     
   function RessourcenKostenBewerten
     (StadtRasseNummerExtern : in EinheitStadtRecords.RasseEinheitnummerRecord;
      EinheitenIDExtern : in EinheitStadtDatentypen.EinheitenID)
      return KIDatentypen.BauenBewertung
     with
       Pre =>
         (StadtRasseNummerExtern.Nummer in EinheitStadtDatentypen.MaximaleStädte'Range
          and
            SonstigeVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) = RassenDatentypen.Spieler_KI_Enum);
   
   function EinheitenDurchgehen
     (StadtRasseNummerExtern : in EinheitStadtRecords.RasseEinheitnummerRecord)
      return KIRecords.EinheitIDBewertungRecord;
   
   function SpezielleEinheitBewerten
     (StadtRasseNummerExtern : in EinheitStadtRecords.RasseEinheitnummerRecord;
      IDExtern : in EinheitStadtDatentypen.EinheitenID)
      return KIDatentypen.BauenBewertung;

end KIEinheitenBauen;

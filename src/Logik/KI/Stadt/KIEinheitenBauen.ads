pragma SPARK_Mode (On);

with SystemDatentypen; use SystemDatentypen;
with EinheitStadtRecords;
with GlobaleVariablen;
with EinheitStadtDatentypen;
with SystemKonstanten;

with KIDatentypen;
with KIRecords;

package KIEinheitenBauen is

   function EinheitenBauen
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return KIRecords.EinheitIDBewertungRecord
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer in EinheitStadtDatentypen.MaximaleStädte'Range
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) = SystemKonstanten.SpielerKIKonstante);
   
private
      
   AnzahlStädte : EinheitStadtDatentypen.MaximaleStädteMitNullWert;
   
   Gesamtwertung : KIDatentypen.BauenBewertung;
   
   MinimaleSiedlerMenge : constant EinheitStadtDatentypen.MaximaleStädte := 2;
   
   MengeVorhanden : EinheitStadtDatentypen.MaximaleEinheitenMitNullWert;
   MengeImBau : EinheitStadtDatentypen.MaximaleStädteMitNullWert;
   
   EinheitBewertet : KIRecords.EinheitIDBewertungRecord;
   
   procedure EinheitBewerten
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      IDExtern : in EinheitStadtDatentypen.EinheitenID)
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer in EinheitStadtDatentypen.MaximaleStädte'Range
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) = SystemKonstanten.SpielerKIKonstante);
     
     
   
   function ArbeiterBewerten
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      EinheitenIDExtern : in EinheitStadtDatentypen.EinheitenID)
      return KIDatentypen.BauenBewertung
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer in EinheitStadtDatentypen.MaximaleStädte'Range
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) = SystemKonstanten.SpielerKIKonstante);
   
   function NahkämpferBewerten
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      EinheitenIDExtern : in EinheitStadtDatentypen.EinheitenID)
      return KIDatentypen.BauenBewertung
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer in EinheitStadtDatentypen.MaximaleStädte'Range
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) = SystemKonstanten.SpielerKIKonstante);
   
   function FernkämpferBewerten
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      EinheitenIDExtern : in EinheitStadtDatentypen.EinheitenID)
      return KIDatentypen.BauenBewertung
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer in EinheitStadtDatentypen.MaximaleStädte'Range
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) = SystemKonstanten.SpielerKIKonstante);
   
   function KostenBewerten
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      EinheitenIDExtern : in EinheitStadtDatentypen.EinheitenID)
      return KIDatentypen.BauenBewertung
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer in EinheitStadtDatentypen.MaximaleStädte'Range
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) = SystemKonstanten.SpielerKIKonstante);
     
   function GeldKostenBewerten
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      EinheitenIDExtern : in EinheitStadtDatentypen.EinheitenID)
      return KIDatentypen.BauenBewertung
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer in EinheitStadtDatentypen.MaximaleStädte'Range
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) = SystemKonstanten.SpielerKIKonstante);
   
   function NahrungKostenBewerten
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      EinheitenIDExtern : in EinheitStadtDatentypen.EinheitenID)
      return KIDatentypen.BauenBewertung
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer in EinheitStadtDatentypen.MaximaleStädte'Range
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) = SystemKonstanten.SpielerKIKonstante);
     
   function RessourcenKostenBewerten
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      EinheitenIDExtern : in EinheitStadtDatentypen.EinheitenID)
      return KIDatentypen.BauenBewertung
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer in EinheitStadtDatentypen.MaximaleStädte'Range
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) = SystemKonstanten.SpielerKIKonstante);
   
   function EinheitenDurchgehen
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return KIRecords.EinheitIDBewertungRecord;
   
   function SpezielleEinheitBewerten
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      IDExtern : in EinheitStadtDatentypen.EinheitenID)
      return KIDatentypen.BauenBewertung;

end KIEinheitenBauen;

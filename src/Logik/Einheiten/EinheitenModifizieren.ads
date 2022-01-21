pragma SPARK_Mode (On);

with SystemDatentypen; use SystemDatentypen;
with KartenDatentypen; use KartenDatentypen;
with EinheitStadtRecords;
with GlobaleVariablen;
with EinheitStadtDatentypen;

package EinheitenModifizieren is

   procedure HeilungBewegungspunkteNeueRundeErmitteln;
   
   procedure HeimatstadtÄndern
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= SystemDatentypen.Leer);
   
   procedure PermanenteKostenÄndern
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      VorzeichenWechselExtern : in KartenDatentypen.LoopRangeMinusEinsZuEins)
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= SystemDatentypen.Leer
          and
            VorzeichenWechselExtern /= 0);
   
   
   
   function EinheitAnforderungenErfüllt
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      IDExtern : in EinheitStadtDatentypen.EinheitenID)
      return Boolean
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer in GlobaleVariablen.StadtGebautArray'First (2) .. GlobaleVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) /= SystemDatentypen.Leer);

private
   
   AktuelleID : EinheitStadtDatentypen.EinheitenID;
   
   AktuelleBeschäftigung : SystemDatentypen.Tastenbelegung_Enum;
   
   Heimatstadt : EinheitStadtDatentypen.MaximaleStädteMitNullWert;
   StadtNummerNeu : EinheitStadtDatentypen.MaximaleStädteMitNullWert;
   
   Heilungsrate : constant EinheitStadtDatentypen.LebenspunkteVorhanden := 10;
   ErhalteneErfahrungspunkte : EinheitStadtDatentypen.MaximaleStädte;
      
   EinheitNummer : EinheitStadtDatentypen.MaximaleEinheitenMitNullWert;

   procedure HeilungBewegungspunkteNeueRundeSetzen
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= SystemDatentypen.Leer);

end EinheitenModifizieren;

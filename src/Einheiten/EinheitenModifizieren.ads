pragma SPARK_Mode (On);

with SonstigeDatentypen; use SonstigeDatentypen;
with KartenDatentypen; use KartenDatentypen;
with EinheitStadtRecords;
with GlobaleVariablen;
with SystemDatentypen;
with EinheitStadtDatentypen;

package EinheitenModifizieren is

   procedure HeilungBewegungspunkteNeueRundeErmitteln;
   
   procedure HeimatstadtÄndern
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= SonstigeDatentypen.Leer);
   
   procedure PermanenteKostenÄndern
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      VorzeichenWechselExtern : in KartenDatentypen.LoopRangeMinusEinsZuEins)
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= SonstigeDatentypen.Leer
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
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) /= SonstigeDatentypen.Leer);

private
   
   AktuelleID : EinheitStadtDatentypen.EinheitenID;
   
   AktuelleBeschäftigung : SystemDatentypen.Tastenbelegung_Enum;
   
   Heimatstadt : EinheitStadtDatentypen.MaximaleStädteMitNullWert;
   StadtNummerNeu : EinheitStadtDatentypen.MaximaleStädteMitNullWert;
   
   Heilungsrate : constant EinheitStadtDatentypen.MaximaleStädte := 10;
   ErhalteneErfahrungspunkte : EinheitStadtDatentypen.MaximaleStädte;
      
   EinheitNummer : EinheitStadtDatentypen.MaximaleEinheitenMitNullWert;

   procedure HeilungBewegungspunkteNeueRundeSetzen
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= SonstigeDatentypen.Leer);

end EinheitenModifizieren;

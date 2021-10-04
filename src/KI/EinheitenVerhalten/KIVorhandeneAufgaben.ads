pragma SPARK_Mode (On);

with EinheitStadtRecords, GlobaleDatentypen, GlobaleVariablen;
use GlobaleDatentypen;

package KIVorhandeneAufgaben is

   function SichHeilen
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return GlobaleDatentypen.ProduktionSonstiges
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = SonstigeDatentypen.Spieler_KI);
   
   function SichVerbessern
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return GlobaleDatentypen.ProduktionSonstiges
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = SonstigeDatentypen.Spieler_KI);
   
   function EinheitAuflösen
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return GlobaleDatentypen.ProduktionSonstiges
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = SonstigeDatentypen.Spieler_KI);
   
   function Fliehen
     return GlobaleDatentypen.ProduktionSonstiges;

   function NeueStadtBauenGehen
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return GlobaleDatentypen.ProduktionSonstiges
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = SonstigeDatentypen.Spieler_KI);

   function StadtUmgebungVerbessern
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return GlobaleDatentypen.ProduktionSonstiges
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = SonstigeDatentypen.Spieler_KI);

   function StadtBewachen
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return GlobaleDatentypen.ProduktionSonstiges
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = SonstigeDatentypen.Spieler_KI);

   function StadtUmgebungZerstören
     return GlobaleDatentypen.ProduktionSonstiges;

   function Angreifen
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return GlobaleDatentypen.ProduktionSonstiges;

   function Erkunden
     return GlobaleDatentypen.ProduktionSonstiges;
   
   function SichBefestigen
     return GlobaleDatentypen.ProduktionSonstiges;
   
   function NichtsTun
     return GlobaleDatentypen.ProduktionSonstiges;
   
private
   
   NotwendigeTechnologie : EinheitStadtDatentypen.ForschungIDMitNullWert;
   
   EinheitID : EinheitStadtDatentypen.EinheitenID;
   
   VorhandeneStädte : EinheitStadtDatentypen.MaximaleStädteMitNullWert;
   
   EinheitNummer : EinheitStadtDatentypen.MaximaleEinheitenMitNullWert;
   
   GewählteAufgabe : GlobaleDatentypen.ProduktionSonstiges;

end KIVorhandeneAufgaben;

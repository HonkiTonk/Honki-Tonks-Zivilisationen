pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleVariablen, GlobaleRecords, KIDatentypen;
use GlobaleDatentypen, KIDatentypen;

package KISiedler is

   procedure KISiedler
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer >= GlobaleVariablen.EinheitenGebautArray'First (2)
          and
            EinheitRasseNummerExtern.Rasse in GlobaleDatentypen.Rassen
          and
            (if EinheitRasseNummerExtern.Rasse > 0 then GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = 2));

private
   
   StadtErfolgreichGebaut : Boolean;
   Gefahr : Boolean;
   UmgebungVerbessern : Boolean;
   Verbessern : Boolean;
   Vernichten : Boolean;
   StadtBauenRückgabeWert : Boolean;
   
   Aufgabe : KIDatentypen.Einheit_Befehl_Ermitteln_Enum;
   
   VorhandeneStädte : Natural;
   VorhandeneSiedler : Natural;
   SicherheitsZähler : Natural;

   function StadtUmgebungVerbessern
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return Boolean
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer >= GlobaleVariablen.EinheitenGebautArray'First (2)
          and
            EinheitRasseNummerExtern.Rasse in GlobaleDatentypen.Rassen
          and
            (if EinheitRasseNummerExtern.Rasse > 0 then GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = 2));

   function NeueStadtBauenGehen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return KIDatentypen.Einheit_Befehl_Ermitteln_Enum
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer >= GlobaleVariablen.EinheitenGebautArray'First (2)
          and
            EinheitRasseNummerExtern.Rasse in GlobaleDatentypen.Rassen
          and
            (if EinheitRasseNummerExtern.Rasse > 0 then GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = 2));

   function StadtBauenPrüfung
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return Boolean
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer >= GlobaleVariablen.EinheitenGebautArray'First (2)
          and
            EinheitRasseNummerExtern.Rasse in GlobaleDatentypen.Rassen
          and
            (if EinheitRasseNummerExtern.Rasse > 0 then GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = 2));

end KISiedler;

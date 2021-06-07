pragma SPARK_Mode (On);

with GlobaleRecords, GlobaleDatentypen, GlobaleVariablen;
use GlobaleDatentypen, GlobaleRecords;

with KIDatentypen;
use KIDatentypen;

with Karten;

package KIAufgabenVerteilt is

   function AufgabenVerteilt
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      AufgabeExtern : in KIDatentypen.Einheit_Aufgabe_Enum)
      return Natural
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer >= GlobaleVariablen.EinheitenGebautArray'First (2)
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = 2);
   
   function EinheitAufgabeZiel
     (AufgabeExtern : in KIDatentypen.Einheit_Aufgabe_Enum;
      RasseExtern : in GlobaleDatentypen.Rassen;
      ZielKoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return Boolean
     with
       Pre =>
         (ZielKoordinatenExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            ZielKoordinatenExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
          and
            GlobaleVariablen.RassenImSpiel (RasseExtern) = 2);
   
private
     
   GleicheAufgabe : Natural;

end KIAufgabenVerteilt;

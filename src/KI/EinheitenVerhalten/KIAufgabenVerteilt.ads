pragma SPARK_Mode (On);

with EinheitStadtRecords, SonstigeDatentypen, GlobaleVariablen, KartenRecords, KartenDatentypen;
use SonstigeDatentypen, KartenRecords, KartenDatentypen;

with KIDatentypen;
use KIDatentypen;

with Karten;

package KIAufgabenVerteilt is

   function AufgabenVerteilt
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      AufgabeExtern : in KIDatentypen.Einheit_Aufgabe_Enum)
      return Natural
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = SonstigeDatentypen.Spieler_KI);
   
   function EinheitAufgabeZiel
     (AufgabeExtern : in KIDatentypen.Einheit_Aufgabe_Enum;
      RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum;
      ZielKoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord)
      return Boolean
     with
       Pre =>
         (ZielKoordinatenExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            ZielKoordinatenExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
          and
            GlobaleVariablen.RassenImSpiel (RasseExtern) = SonstigeDatentypen.Spieler_KI);
   
   function EinheitZiel
     (RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum;
      ZielKoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord)
      return Boolean
     with
       Pre =>
         (ZielKoordinatenExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            ZielKoordinatenExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
          and
            GlobaleVariablen.RassenImSpiel (RasseExtern) = SonstigeDatentypen.Spieler_KI);
   
private
     
   GleicheAufgabe : Natural;

end KIAufgabenVerteilt;

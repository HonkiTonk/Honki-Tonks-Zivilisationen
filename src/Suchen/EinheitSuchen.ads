pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleRecords, GlobaleVariablen;
use GlobaleDatentypen, GlobaleRecords;

with Karten;

package EinheitSuchen is

   function KoordinatenEinheitMitRasseSuchen (RasseExtern : in GlobaleDatentypen.Rassen; KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord) return GlobaleDatentypen.MaximaleEinheitenMitNullWert with
     Pre => (KoordinatenExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße and KoordinatenExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
             and GlobaleVariablen.RassenImSpiel (RasseExtern) /= 0);

   function KoordinatenEinheitOhneRasseSuchen (KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord) return GlobaleRecords.RassePlatznummerRecord with
     Pre  => (KoordinatenExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße and KoordinatenExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße),
     Post => ((if KoordinatenEinheitOhneRasseSuchen'Result.Rasse > 0 then GlobaleVariablen.RassenImSpiel (KoordinatenEinheitOhneRasseSuchen'Result.Rasse) /= 0));

   function KoordinatenEinheitOhneSpezielleRasseSuchen (RasseExtern : in GlobaleDatentypen.Rassen; KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord) return GlobaleRecords.RassePlatznummerRecord with
     Pre  => (KoordinatenExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße and KoordinatenExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
              and GlobaleVariablen.RassenImSpiel (RasseExtern) /= 0),
     Post => ((if KoordinatenEinheitOhneSpezielleRasseSuchen'Result.Rasse > 0 then GlobaleVariablen.RassenImSpiel (KoordinatenEinheitOhneSpezielleRasseSuchen'Result.Rasse) /= 0));

   function EinheitAufTransporterSuchen (EinheitRassePlatznummer : in GlobaleRecords.RassePlatznummerRecord; EinheitNummer : in GlobaleDatentypen.MaximaleEinheiten) return Natural with
     Pre  => (GlobaleVariablen.RassenImSpiel (EinheitRassePlatznummer.Rasse) /= 0 and EinheitRassePlatznummer.Platznummer > 0),
     Post => (EinheitAufTransporterSuchen'Result <= GlobaleRecords.TransporterArray'Last);

   function IstEinheitAufTransporter (EinheitRassePlatznummer : in GlobaleRecords.RassePlatznummerRecord) return Boolean with
     Pre  => (GlobaleVariablen.RassenImSpiel (EinheitRassePlatznummer.Rasse) /= 0 and EinheitRassePlatznummer.Platznummer > 0);

private
   
   

end EinheitSuchen;

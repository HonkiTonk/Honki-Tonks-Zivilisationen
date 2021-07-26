pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleRecords, GlobaleVariablen;
use GlobaleDatentypen, GlobaleRecords;

with Karten, EinheitenDatenbank;

package EinheitSuchen is

   function KoordinatenEinheitMitRasseSuchen
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return GlobaleDatentypen.MaximaleEinheitenMitNullWert
     with
       Pre =>
         (KoordinatenExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            KoordinatenExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
          and
            GlobaleVariablen.RassenImSpiel (RasseExtern) /= GlobaleDatentypen.Leer);

   function KoordinatenTransporterMitRasseSuchen
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return GlobaleDatentypen.MaximaleEinheitenMitNullWert
     with
       Pre =>
         (KoordinatenExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            KoordinatenExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
          and
            GlobaleVariablen.RassenImSpiel (RasseExtern) /= GlobaleDatentypen.Leer),
         Post =>
           ((if KoordinatenTransporterMitRasseSuchen'Result > 0 then
                      EinheitenDatenbank.EinheitenListe (RasseExtern, GlobaleVariablen.EinheitenGebaut (RasseExtern, KoordinatenTransporterMitRasseSuchen'Result).ID).KannTransportieren > 0));

   function KoordinatenEinheitOhneRasseSuchen
     (KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return GlobaleRecords.RassePlatznummerRecord
     with
       Pre =>
         (KoordinatenExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            KoordinatenExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße),
         Post =>
           ((if KoordinatenEinheitOhneRasseSuchen'Result.Rasse /= GlobaleDatentypen.Leer then GlobaleVariablen.RassenImSpiel (KoordinatenEinheitOhneRasseSuchen'Result.Rasse) /= GlobaleDatentypen.Leer));

   function KoordinatenEinheitOhneSpezielleRasseSuchen
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return GlobaleRecords.RassePlatznummerRecord
     with
       Pre =>
         (KoordinatenExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            KoordinatenExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
          and
            GlobaleVariablen.RassenImSpiel (RasseExtern) /= GlobaleDatentypen.Leer),
         Post =>
           ((if KoordinatenEinheitOhneSpezielleRasseSuchen'Result.Rasse /= GlobaleDatentypen.Leer then GlobaleVariablen.RassenImSpiel (KoordinatenEinheitOhneSpezielleRasseSuchen'Result.Rasse) /= GlobaleDatentypen.Leer));

   function EinheitAufTransporterSuchen
     (TransporterExtern : in GlobaleRecords.RassePlatznummerRecord;
      LadungExtern : in GlobaleDatentypen.MaximaleEinheiten)
      return GlobaleDatentypen.MaximaleEinheitenMitNullWert
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (TransporterExtern.Rasse) /= GlobaleDatentypen.Leer
          and
            TransporterExtern.Platznummer > 0);

   function HatTransporterLadung
     (EinheitRassePlatznummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return Boolean
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (EinheitRassePlatznummerExtern.Rasse) /= GlobaleDatentypen.Leer
          and
            EinheitRassePlatznummerExtern.Platznummer > 0);
   
   function MengeEinesEinheitenTypsSuchen
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      EinheitTypExtern : in GlobaleDatentypen.Einheit_Art_Verwendet_Enum;
      GesuchteMengeExtern : in GlobaleDatentypen.MaximaleEinheitenMitNullWert)
      return GlobaleDatentypen.MaximaleEinheitenMitNullWert
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= GlobaleDatentypen.Leer);
   
   function AnzahlEinheitenSuchen
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      GesuchteMengeExtern : in GlobaleDatentypen.MaximaleEinheitenMitNullWert)
      return GlobaleDatentypen.MaximaleEinheitenMitNullWert
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= GlobaleDatentypen.Leer);

private
   
   TransporterID : GlobaleDatentypen.EinheitenIDMitNullWert;
   
   AnzahlEinheitTyp : GlobaleDatentypen.MaximaleEinheitenMitNullWert;
   AnzahlEinheiten : GlobaleDatentypen.MaximaleEinheitenMitNullWert;

end EinheitSuchen;

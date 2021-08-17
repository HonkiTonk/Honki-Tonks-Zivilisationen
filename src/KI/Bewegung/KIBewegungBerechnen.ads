pragma SPARK_Mode (On);

with GlobaleRecords, GlobaleVariablen, GlobaleDatentypen;
use GlobaleDatentypen, GlobaleRecords;

with Karten;

package KIBewegungBerechnen is
   
   function BewegungPlanen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return Boolean
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = GlobaleDatentypen.Spieler_KI);
   
private
   
   PlanungErfolgreich : Boolean;
   PlanungErfolgreichRekursiv : Boolean;
   
   BewertungPosition : Positive;
   
   YAchseKoordinatePrüfen : GlobaleDatentypen.KartenfeldPositiv;
   XAchseKoordinatePrüfen : GlobaleDatentypen.KartenfeldPositiv;
   YAchseKoordinatenSchonGeprüft : GlobaleDatentypen.KartenfeldPositivMitNullwert;
   XAchseKoordinatenSchonGeprüft : GlobaleDatentypen.KartenfeldPositivMitNullwert;
   NurWasser : GlobaleDatentypen.KartenfeldPositivMitNullwert;
   
   ZielKoordinaten : GlobaleRecords.AchsenKartenfeldPositivRecord;
   
   KartenWert : GlobaleRecords.AchsenKartenfeldPositivRecord;
   KartenWertVereinfachung : GlobaleRecords.AchsenKartenfeldPositivRecord;
   KartenWertTransporter : GlobaleRecords.AchsenKartenfeldPositivRecord;
   
   type FeldBewertungArray is array (GlobaleDatentypen.LoopRangeMinusEinsZuEins'Range, GlobaleDatentypen.LoopRangeMinusEinsZuEins'Range) of Natural;
   FeldBewertung : FeldBewertungArray;
   
   type BewertungRecord is new GlobaleRecords.AchsenKartenfeldPositivRecord with record
      
      Bewertung : Natural;
      
   end record;
   
   Sortieren : BewertungRecord;
   
   type BewertungArray is array (1 .. 9) of BewertungRecord;
   Bewertung : BewertungArray;
   
   procedure VorhandenenPlanVereinfachen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = GlobaleDatentypen.Spieler_KI);
   
   procedure VorhandenenPlanVereinfachenPrüfen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      ErsterZugExtern, ÜberNächsterZugExtern : in GlobaleDatentypen.Stadtfeld)
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = GlobaleDatentypen.Spieler_KI);
   
   
   
   function PlanenRekursiv
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      AktuelleKoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      AktuellePlanpositionExtern : in GlobaleDatentypen.Stadtfeld)
      return Boolean
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            AktuelleKoordinatenExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            AktuelleKoordinatenExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = GlobaleDatentypen.Spieler_KI);
   
   function BewertungFeldposition
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      YÄnderungExtern, XÄnderungExtern : in GlobaleDatentypen.LoopRangeMinusEinsZuEins)
      return Natural
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            KoordinatenExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            KoordinatenExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = GlobaleDatentypen.Spieler_KI);
   
   function FeldBereitsBetreten
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return Boolean
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            KoordinatenExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            KoordinatenExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = GlobaleDatentypen.Spieler_KI);
   
   function TransporterNötig
     return Boolean;

end KIBewegungBerechnen;

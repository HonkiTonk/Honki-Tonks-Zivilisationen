pragma SPARK_Mode (On);

with EinheitStadtRecords, GlobaleVariablen, GlobaleDatentypen, KartenRecords;
use GlobaleDatentypen, KartenRecords;

with Karten;

package KIBewegungBerechnen is
   
   function BewegungPlanen
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return Boolean
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = SonstigeDatentypen.Spieler_KI);
   
private
   
   PlanungErfolgreich : Boolean;
   PlanungErfolgreichRekursiv : Boolean;
   
   BewertungPosition : Positive;
   
   YAchseKoordinatePrüfen : KartenDatentypen.KartenfeldPositiv;
   XAchseKoordinatePrüfen : KartenDatentypen.KartenfeldPositiv;
   YAchseKoordinatenSchonGeprüft : KartenDatentypen.KartenfeldPositivMitNullwert;
   XAchseKoordinatenSchonGeprüft : KartenDatentypen.KartenfeldPositivMitNullwert;
   NurWasser : KartenDatentypen.KartenfeldPositivMitNullwert;
   
   ZielKoordinaten : KartenRecords.AchsenKartenfeldPositivRecord;
   
   KartenWert : KartenRecords.AchsenKartenfeldPositivRecord;
   KartenWertVereinfachung : KartenRecords.AchsenKartenfeldPositivRecord;
   KartenWertTransporter : KartenRecords.AchsenKartenfeldPositivRecord;
   
   PositionAlt : KartenRecords.AchsenKartenfeldPositivRecord;
   PositionNeu : KartenRecords.AchsenKartenfeldPositivRecord;
   
   type FeldBewertungArray is array (KartenDatentypen.LoopRangeMinusEinsZuEins'Range, KartenDatentypen.LoopRangeMinusEinsZuEins'Range) of GlobaleDatentypen.ProduktionSonstiges;
   FeldBewertung : FeldBewertungArray;
   
   type BewertungRecord is new KartenRecords.AchsenKartenfeldPositivRecord with record
      
      Bewertung : GlobaleDatentypen.ProduktionSonstiges;
      
   end record;
   
   Sortieren : BewertungRecord;
   
   type BewertungArray is array (1 .. 9) of BewertungRecord;
   Bewertung : BewertungArray;
   
   procedure VorhandenenPlanVereinfachen
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = SonstigeDatentypen.Spieler_KI);
   
   procedure VorhandenenPlanVereinfachenPrüfen
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      ErsterZugExtern : in KartenDatentypen.Stadtfeld;
      ÜberNächsterZugExtern : in KartenDatentypen.Stadtfeld)
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = SonstigeDatentypen.Spieler_KI);
   
   procedure FelderBewerten
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      AktuelleKoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord);
   
   procedure BewertungSortieren;
   
   
   
   function PlanenRekursiv
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      AktuelleKoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      AktuellePlanpositionExtern : in KartenDatentypen.Stadtfeld)
      return Boolean
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            AktuelleKoordinatenExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            AktuelleKoordinatenExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = SonstigeDatentypen.Spieler_KI);
   
   function BewertungFeldposition
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      YÄnderungExtern : in KartenDatentypen.LoopRangeMinusEinsZuEins;
      XÄnderungExtern : in KartenDatentypen.LoopRangeMinusEinsZuEins)
      return GlobaleDatentypen.ProduktionSonstiges
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            KoordinatenExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            KoordinatenExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = SonstigeDatentypen.Spieler_KI);
   
   function BerechnungBewertungPosition
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      NeueKoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord)
      return GlobaleDatentypen.ProduktionSonstiges
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            KoordinatenExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            KoordinatenExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
          and
            NeueKoordinatenExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            NeueKoordinatenExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = SonstigeDatentypen.Spieler_KI);
   
   function FeldBereitsBetreten
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord)
      return Boolean
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            KoordinatenExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            KoordinatenExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = SonstigeDatentypen.Spieler_KI);
   
   function TransporterNutzen
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord)
      return Boolean;
   
   function PlanschrittFestlegen
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      DurchlaufExtern : in Positive;
      AktuellePlanpositionExtern : in KartenDatentypen.Stadtfeld)
      return Boolean;

end KIBewegungBerechnen;

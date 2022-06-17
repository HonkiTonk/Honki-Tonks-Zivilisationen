pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RassenDatentypen; use RassenDatentypen;
with KartenDatentypen; use KartenDatentypen;
with EinheitenRecords;
with SpielVariablen;
with KartenRecords;
with SonstigeVariablen;

with KIDatentypen;

with Karten;

package KIBewegungBerechnen is
   
   function BewegungPlanen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
     with
       Pre =>
         (EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            SonstigeVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = RassenDatentypen.Spieler_KI_Enum);
   
private
   
   PlanungErfolgreich : Boolean;
   PlanungErfolgreichRekursiv : Boolean;
   
   
   BewertungPosition : Positive;
   
   YAchseKoordinatePrüfen : KartenDatentypen.KartenfeldPositiv;
   XAchseKoordinatePrüfen : KartenDatentypen.KartenfeldPositiv;
   YAchseKoordinatenSchonGeprüft : KartenDatentypen.KartenfeldNatural;
   XAchseKoordinatenSchonGeprüft : KartenDatentypen.KartenfeldNatural;
   NurWasser : KartenDatentypen.KartenfeldNatural;
   
   ZielKoordinaten : KartenRecords.AchsenKartenfeldNaturalRecord;
   
   KartenWert : KartenRecords.AchsenKartenfeldNaturalRecord;
   KartenWertVereinfachung : KartenRecords.AchsenKartenfeldNaturalRecord;
   KartenWertTransporter : KartenRecords.AchsenKartenfeldNaturalRecord;
   
   PositionAlt : KartenRecords.AchsenKartenfeldNaturalRecord;
   PositionNeu : KartenRecords.AchsenKartenfeldNaturalRecord;
   
   EÄnderung : KIDatentypen.BewegungBewertung;
   YÄnderung : KIDatentypen.BewegungBewertung;
   XÄnderung : KIDatentypen.BewegungBewertung;
   
   type FeldBewertungArray is array (KartenDatentypen.UmgebungsbereichEinsEAchse'Range, KartenDatentypen.UmgebungsbereichEins'Range, KartenDatentypen.UmgebungsbereichEins'Range) of KIDatentypen.BewegungBewertung;
   FeldBewertung : FeldBewertungArray;
   
   type BewertungRecord is new KartenRecords.AchsenKartenfeldNaturalRecord with record
      
      Bewertung : KIDatentypen.BewegungBewertung;
      
   end record;
   
   Sortieren : BewertungRecord;
   
   type BewertungArray is array (1 .. 27) of BewertungRecord;
   Bewertung : BewertungArray;
   
   procedure VorhandenenPlanVereinfachen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
     with
       Pre =>
         (EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            SonstigeVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = RassenDatentypen.Spieler_KI_Enum);
   
   procedure VorhandenenPlanVereinfachenPrüfen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      ErsterZugExtern : in KartenDatentypen.Stadtfeld;
      ÜberNächsterZugExtern : in KartenDatentypen.Stadtfeld)
     with
       Pre =>
         (EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            SonstigeVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = RassenDatentypen.Spieler_KI_Enum);
   
   procedure FelderBewerten
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      AktuelleKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
     with
       Pre =>
         (EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            SonstigeVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = RassenDatentypen.Spieler_KI_Enum
          and
            AktuelleKoordinatenExtern.YAchse <= Karten.Kartenparameter.Kartengröße.YAchse
          and
            AktuelleKoordinatenExtern.XAchse <= Karten.Kartenparameter.Kartengröße.XAchse);
   
   procedure BewertungSortieren;
   
   
   
   function PlanenRekursiv
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      AktuelleKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      AktuellePlanpositionExtern : in KartenDatentypen.Stadtfeld)
      return Boolean
     with
       Pre =>
         (EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            AktuelleKoordinatenExtern.YAchse <= Karten.Kartenparameter.Kartengröße.YAchse
          and
            AktuelleKoordinatenExtern.XAchse <= Karten.Kartenparameter.Kartengröße.XAchse
          and
            SonstigeVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = RassenDatentypen.Spieler_KI_Enum);
   
   function BewertungFeldposition
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      EÄnderungExtern : in KartenDatentypen.UmgebungsbereichEinsEAchse;
      YÄnderungExtern : in KartenDatentypen.UmgebungsbereichEins;
      XÄnderungExtern : in KartenDatentypen.UmgebungsbereichEins)
      return KIDatentypen.BewegungBewertung
     with
       Pre =>
         (EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            KoordinatenExtern.YAchse <= Karten.Kartenparameter.Kartengröße.YAchse
          and
            KoordinatenExtern.XAchse <= Karten.Kartenparameter.Kartengröße.XAchse
          and
            SonstigeVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = RassenDatentypen.Spieler_KI_Enum);
   
   function BerechnungBewertungPosition
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      NeueKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return KIDatentypen.BewegungBewertung
     with
       Pre =>
         (EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            KoordinatenExtern.YAchse <= Karten.Kartenparameter.Kartengröße.YAchse
          and
            KoordinatenExtern.XAchse <= Karten.Kartenparameter.Kartengröße.XAchse
          and
            NeueKoordinatenExtern.YAchse <= Karten.Kartenparameter.Kartengröße.YAchse
          and
            NeueKoordinatenExtern.XAchse <= Karten.Kartenparameter.Kartengröße.XAchse
          and
            SonstigeVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = RassenDatentypen.Spieler_KI_Enum);
   
   function FeldBereitsBetreten
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
     with
       Pre =>
         (EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            KoordinatenExtern.YAchse <= Karten.Kartenparameter.Kartengröße.YAchse
          and
            KoordinatenExtern.XAchse <= Karten.Kartenparameter.Kartengröße.XAchse
          and
            SonstigeVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = RassenDatentypen.Spieler_KI_Enum);
   
   function TransporterNutzen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
     with
       Pre =>
         (EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            KoordinatenExtern.YAchse <= Karten.Kartenparameter.Kartengröße.YAchse
          and
            KoordinatenExtern.XAchse <= Karten.Kartenparameter.Kartengröße.XAchse
          and
            SonstigeVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = RassenDatentypen.Spieler_KI_Enum);
   
   function PlanschrittFestlegen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      DurchlaufExtern : in Positive;
      AktuellePlanpositionExtern : in KartenDatentypen.Stadtfeld)
      return Boolean
     with
       Pre =>
         (EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            SonstigeVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = RassenDatentypen.Spieler_KI_Enum);

end KIBewegungBerechnen;

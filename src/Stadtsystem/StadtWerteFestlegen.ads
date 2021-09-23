pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleRecords, GlobaleVariablen;
use GlobaleDatentypen;

with LeseStadtGebaut;

package StadtWerteFestlegen is

   procedure BewirtschaftbareFelderBelegen
     (ZuwachsOderSchwundExtern : in Boolean;
      StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer in GlobaleVariablen.StadtGebautArray'First (2) .. GlobaleVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) /= GlobaleDatentypen.Leer);
   
   procedure StadtUmgebungGrößeFestlegenTechnologie
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= GlobaleDatentypen.Leer);

   procedure StadtUmgebungGrößeFestlegen
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer in GlobaleVariablen.StadtGebautArray'First (2) .. GlobaleVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) /= GlobaleDatentypen.Leer
          and
            LeseStadtGebaut.EinwohnerArbeiter (StadtRasseNummerExtern  => StadtRasseNummerExtern,
                                               EinwohnerArbeiterExtern => True) >= 1);

private
   
   GrößeAlt : GlobaleDatentypen.LoopRangeMinusDreiZuDrei;
   GrößeNeu : GlobaleDatentypen.LoopRangeMinusDreiZuDrei;
   
   NahrungGesamt : GlobaleDatentypen.ProduktionFeld;
   RessourcenGesamt : GlobaleDatentypen.ProduktionFeld;
   GeldGesamt : GlobaleDatentypen.ProduktionFeld;
   WissenGesamt : GlobaleDatentypen.ProduktionFeld;
   
   NutzbarerBereich : GlobaleDatentypen.Kartenfeld;
   KartenWert : GlobaleRecords.AchsenKartenfeldPositivRecord;
   
   type UmgebungRecord is record
      
      Belegt : Boolean;
      
      Gesamtbewertung : GlobaleDatentypen.GesamtproduktionStadt;
      
   end record;
   
   type UmgebungArray is array (GlobaleDatentypen.LoopRangeMinusDreiZuDrei'Range, GlobaleDatentypen.LoopRangeMinusDreiZuDrei'Range) of UmgebungRecord;
   Umgebung : UmgebungArray;
   
   type WelchesFeldRecord is record
      
      HöchsterWert : GlobaleDatentypen.GesamtproduktionStadt;
      YKoordinate : GlobaleDatentypen.LoopRangeMinusDreiZuDrei;
      XKoordinate : GlobaleDatentypen.LoopRangeMinusDreiZuDrei;
      
   end record;
   
   WelchesFeld : WelchesFeldRecord;
   
   procedure ArbeiterBelegen
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord);
   
   procedure ArbeiterEntfernen
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord);
   
   procedure GebäudeEntfernen
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord);
   
   procedure ArbeiterBelegenEntfernen
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      BelegenEntfernenExtern : in Boolean;
      ÄnderungExtern : in GlobaleDatentypen.ProduktionFeld);
   
   procedure UmgebungFestlegen
     (ZuwachsOderSchwundExtern : in Boolean;
      StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord);
   
   procedure NeueUmgebungsgrößePrüfen
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord);
   
   
   
   function FeldBewerten
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      BelegenOderEntfernen : in Boolean)
      return GlobaleDatentypen.GesamtproduktionStadt;
   
   function WissenBewertung
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      BelegenOderEntfernen : in Boolean)
      return GlobaleDatentypen.GesamtproduktionStadt;
   
   function GeldBewertung
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      BelegenOderEntfernen : in Boolean)
      return GlobaleDatentypen.GesamtproduktionStadt;
   
   function ProduktionBewertung
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      BelegenOderEntfernen : in Boolean)
      return GlobaleDatentypen.GesamtproduktionStadt;
   
   function NahrungBewertung
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      BelegenOderEntfernen : in Boolean)
      return GlobaleDatentypen.GesamtproduktionStadt;

end StadtWerteFestlegen;

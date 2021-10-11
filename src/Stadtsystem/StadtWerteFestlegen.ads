pragma SPARK_Mode (On);

with SonstigeDatentypen; use SonstigeDatentypen;
with EinheitStadtDatentypen; use EinheitStadtDatentypen;
with EinheitStadtRecords;
with GlobaleVariablen;
with KartenRecords;
with KartenDatentypen;

with LeseStadtGebaut;

package StadtWerteFestlegen is

   procedure BewirtschaftbareFelderBelegen
     (ZuwachsOderSchwundExtern : in Boolean;
      StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer in GlobaleVariablen.StadtGebautArray'First (2) .. GlobaleVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) /= SonstigeDatentypen.Leer);
   
   procedure StadtUmgebungGrößeFestlegenTechnologie
     (RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= SonstigeDatentypen.Leer);

   procedure StadtUmgebungGrößeFestlegen
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer in GlobaleVariablen.StadtGebautArray'First (2) .. GlobaleVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) /= SonstigeDatentypen.Leer
          and
            LeseStadtGebaut.EinwohnerArbeiter (StadtRasseNummerExtern  => StadtRasseNummerExtern,
                                               EinwohnerArbeiterExtern => True) >= 1);

private
   
   GrößeAlt : KartenDatentypen.LoopRangeMinusDreiZuDrei;
   GrößeNeu : KartenDatentypen.LoopRangeMinusDreiZuDrei;
   
   NahrungGesamt : EinheitStadtDatentypen.ProduktionFeld;
   RessourcenGesamt : EinheitStadtDatentypen.ProduktionFeld;
   GeldGesamt : EinheitStadtDatentypen.ProduktionFeld;
   WissenGesamt : EinheitStadtDatentypen.ProduktionFeld;
   
   NutzbarerBereich : KartenDatentypen.Kartenfeld;
   KartenWert : KartenRecords.AchsenKartenfeldPositivRecord;
   
   type UmgebungRecord is record
      
      Belegt : Boolean;
      
      Gesamtbewertung : EinheitStadtDatentypen.GesamtproduktionStadt;
      
   end record;
   
   type UmgebungArray is array (KartenDatentypen.LoopRangeMinusDreiZuDrei'Range, KartenDatentypen.LoopRangeMinusDreiZuDrei'Range) of UmgebungRecord;
   Umgebung : UmgebungArray;
   
   type WelchesFeldRecord is record
      
      HöchsterWert : EinheitStadtDatentypen.GesamtproduktionStadt;
      YKoordinate : KartenDatentypen.LoopRangeMinusDreiZuDrei;
      XKoordinate : KartenDatentypen.LoopRangeMinusDreiZuDrei;
      
   end record;
   
   WelchesFeld : WelchesFeldRecord;
   
   procedure ArbeiterBelegen
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord);
   
   procedure ArbeiterEntfernen
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord);
   
   procedure GebäudeEntfernen
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord);
   
   procedure ArbeiterBelegenEntfernen
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      BelegenEntfernenExtern : in Boolean;
      ÄnderungExtern : in EinheitStadtDatentypen.ProduktionFeld);
   
   procedure UmgebungFestlegen
     (ZuwachsOderSchwundExtern : in Boolean;
      StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord);
   
   procedure NeueUmgebungsgrößePrüfen
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord);
   
   
   
   function FeldBewerten
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      BelegenOderEntfernen : in Boolean)
      return EinheitStadtDatentypen.GesamtproduktionStadt;
   
   function WissenBewertung
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      BelegenOderEntfernen : in Boolean)
      return EinheitStadtDatentypen.GesamtproduktionStadt;
   
   function GeldBewertung
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      BelegenOderEntfernen : in Boolean)
      return EinheitStadtDatentypen.GesamtproduktionStadt;
   
   function ProduktionBewertung
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      BelegenOderEntfernen : in Boolean)
      return EinheitStadtDatentypen.GesamtproduktionStadt;
   
   function NahrungBewertung
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      BelegenOderEntfernen : in Boolean)
      return EinheitStadtDatentypen.GesamtproduktionStadt;

end StadtWerteFestlegen;
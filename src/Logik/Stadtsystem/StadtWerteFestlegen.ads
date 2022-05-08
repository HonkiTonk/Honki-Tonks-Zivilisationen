pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RassenDatentypen; use RassenDatentypen;
with ProduktionDatentypen; use ProduktionDatentypen;
with EinheitStadtRecords;
with SpielVariablen;
with KartenRecords;
with KartenDatentypen;
with SonstigeVariablen;

with LeseStadtGebaut;

package StadtWerteFestlegen is

   procedure BewirtschaftbareFelderBelegen
     (ZuwachsOderSchwundExtern : in Boolean;
      StadtRasseNummerExtern : in EinheitStadtRecords.RasseEinheitnummerRecord)
     with
       Pre =>
         (StadtRasseNummerExtern.Nummer in SpielVariablen.StadtGebautArray'First (2) .. SpielVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
          and
            SonstigeVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum);
   
   procedure StadtUmgebungGrößeFestlegenTechnologie
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (SonstigeVariablen.RassenImSpiel (RasseExtern) /= RassenDatentypen.Leer_Spieler_Enum);

   procedure StadtUmgebungGrößeFestlegen
     (StadtRasseNummerExtern : in EinheitStadtRecords.RasseEinheitnummerRecord)
     with
       Pre =>
         (StadtRasseNummerExtern.Nummer in SpielVariablen.StadtGebautArray'First (2) .. SpielVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
          and
            SonstigeVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum
          and
            LeseStadtGebaut.EinwohnerArbeiter (StadtRasseNummerExtern  => StadtRasseNummerExtern,
                                               EinwohnerArbeiterExtern => True) >= 1);

private
   
   GrößeAlt : KartenDatentypen.UmgebungsbereichDrei;
   GrößeNeu : KartenDatentypen.UmgebungsbereichDrei;
   
   NahrungGesamt : ProduktionDatentypen.ProduktionFeld;
   RessourcenGesamt : ProduktionDatentypen.ProduktionFeld;
   GeldGesamt : ProduktionDatentypen.ProduktionFeld;
   WissenGesamt : ProduktionDatentypen.ProduktionFeld;
   
   NutzbarerBereich : KartenDatentypen.Kartenfeld;
   KartenWert : KartenRecords.AchsenKartenfeldPositivRecord;
   
   type UmgebungRecord is record
      
      Belegt : Boolean;
      
      Gesamtbewertung : ProduktionDatentypen.GesamtproduktionStadt;
      
   end record;
   
   type UmgebungArray is array (KartenDatentypen.UmgebungsbereichDrei'Range, KartenDatentypen.UmgebungsbereichDrei'Range) of UmgebungRecord;
   Umgebung : UmgebungArray;
   
   type WelchesFeldRecord is record
      
      HöchsterWert : ProduktionDatentypen.GesamtproduktionStadt;
      YKoordinate : KartenDatentypen.UmgebungsbereichDrei;
      XKoordinate : KartenDatentypen.UmgebungsbereichDrei;
      
   end record;
   
   WelchesFeld : WelchesFeldRecord;
   
   procedure ArbeiterBelegen
     (StadtRasseNummerExtern : in EinheitStadtRecords.RasseEinheitnummerRecord);
   
   procedure ArbeiterEntfernen
     (StadtRasseNummerExtern : in EinheitStadtRecords.RasseEinheitnummerRecord);
   
   procedure GebäudeEntfernen
     (StadtRasseNummerExtern : in EinheitStadtRecords.RasseEinheitnummerRecord);
   
   procedure ArbeiterBelegenEntfernen
     (StadtRasseNummerExtern : in EinheitStadtRecords.RasseEinheitnummerRecord;
      BelegenEntfernenExtern : in Boolean;
      ÄnderungExtern : in ProduktionDatentypen.ProduktionFeld);
   
   procedure UmgebungFestlegen
     (ZuwachsOderSchwundExtern : in Boolean;
      StadtRasseNummerExtern : in EinheitStadtRecords.RasseEinheitnummerRecord);
   
   procedure NeueUmgebungsgrößePrüfen
     (StadtRasseNummerExtern : in EinheitStadtRecords.RasseEinheitnummerRecord);
   
   
   
   function FeldBewerten
     (StadtRasseNummerExtern : in EinheitStadtRecords.RasseEinheitnummerRecord;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      BelegenOderEntfernen : in Boolean)
      return ProduktionDatentypen.GesamtproduktionStadt;
   
   function WissenBewertung
     (StadtRasseNummerExtern : in EinheitStadtRecords.RasseEinheitnummerRecord;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      BelegenOderEntfernen : in Boolean)
      return ProduktionDatentypen.GesamtproduktionStadt;
   
   function GeldBewertung
     (StadtRasseNummerExtern : in EinheitStadtRecords.RasseEinheitnummerRecord;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      BelegenOderEntfernen : in Boolean)
      return ProduktionDatentypen.GesamtproduktionStadt;
   
   function ProduktionBewertung
     (StadtRasseNummerExtern : in EinheitStadtRecords.RasseEinheitnummerRecord;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      BelegenOderEntfernen : in Boolean)
      return ProduktionDatentypen.GesamtproduktionStadt;
   
   function NahrungBewertung
     (StadtRasseNummerExtern : in EinheitStadtRecords.RasseEinheitnummerRecord;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      BelegenOderEntfernen : in Boolean)
      return ProduktionDatentypen.GesamtproduktionStadt;

end StadtWerteFestlegen;

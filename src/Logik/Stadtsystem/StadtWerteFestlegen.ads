pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with EinheitStadtDatentypen; use EinheitStadtDatentypen;
with RassenDatentypen; use RassenDatentypen;
with EinheitStadtRecords;
with SpielVariablen;
with KartenRecords;
with KartenDatentypen;
with SonstigeVariablen;

with LeseStadtGebaut;

package StadtWerteFestlegen is

   procedure BewirtschaftbareFelderBelegen
     (ZuwachsOderSchwundExtern : in Boolean;
      StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer in SpielVariablen.StadtGebautArray'First (2) .. SpielVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
          and
            SonstigeVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum);
   
   procedure StadtUmgebungGrößeFestlegenTechnologie
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (SonstigeVariablen.RassenImSpiel (RasseExtern) /= RassenDatentypen.Leer_Spieler_Enum);

   procedure StadtUmgebungGrößeFestlegen
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer in SpielVariablen.StadtGebautArray'First (2) .. SpielVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
          and
            SonstigeVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum
          and
            LeseStadtGebaut.EinwohnerArbeiter (StadtRasseNummerExtern  => StadtRasseNummerExtern,
                                               EinwohnerArbeiterExtern => True) >= 1);

private
   
   GrößeAlt : KartenDatentypen.UmgebungsbereichDrei;
   GrößeNeu : KartenDatentypen.UmgebungsbereichDrei;
   
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
   
   type UmgebungArray is array (KartenDatentypen.UmgebungsbereichDrei'Range, KartenDatentypen.UmgebungsbereichDrei'Range) of UmgebungRecord;
   Umgebung : UmgebungArray;
   
   type WelchesFeldRecord is record
      
      HöchsterWert : EinheitStadtDatentypen.GesamtproduktionStadt;
      YKoordinate : KartenDatentypen.UmgebungsbereichDrei;
      XKoordinate : KartenDatentypen.UmgebungsbereichDrei;
      
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
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      BelegenOderEntfernen : in Boolean)
      return EinheitStadtDatentypen.GesamtproduktionStadt;
   
   function WissenBewertung
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      BelegenOderEntfernen : in Boolean)
      return EinheitStadtDatentypen.GesamtproduktionStadt;
   
   function GeldBewertung
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      BelegenOderEntfernen : in Boolean)
      return EinheitStadtDatentypen.GesamtproduktionStadt;
   
   function ProduktionBewertung
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      BelegenOderEntfernen : in Boolean)
      return EinheitStadtDatentypen.GesamtproduktionStadt;
   
   function NahrungBewertung
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      BelegenOderEntfernen : in Boolean)
      return EinheitStadtDatentypen.GesamtproduktionStadt;

end StadtWerteFestlegen;
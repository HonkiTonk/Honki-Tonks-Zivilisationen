with RassenDatentypen;
with SpielVariablen;
with StadtRecords;
with ProduktionDatentypen;

private with KartenRecords;
private with KartenDatentypen;

with LeseStadtGebaut;
with LeseGrenzen;

package StadtwerteFestlegenLogik is
   pragma Elaborate_Body;
   use type RassenDatentypen.Spieler_Enum;
   use type ProduktionDatentypen.Einwohner;

   procedure BewirtschaftbareFelderBelegen
     (ZuwachsOderSchwundExtern : in Boolean;
      StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
     with
       Pre => (
                 StadtRasseNummerExtern.Nummer in SpielVariablen.StadtGebautArray'First (2) .. LeseGrenzen.Städtegrenzen (RasseExtern => StadtRasseNummerExtern.Rasse)
               and
                 SpielVariablen.Rassenbelegung (StadtRasseNummerExtern.Rasse).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );
   
   procedure StadtUmgebungGrößeFestlegenTechnologie
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre => (
                 SpielVariablen.Rassenbelegung (RasseExtern).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );

   procedure StadtUmgebungGrößeFestlegen
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
     with
       Pre => (
                 StadtRasseNummerExtern.Nummer in SpielVariablen.StadtGebautArray'First (2) .. LeseGrenzen.Städtegrenzen (RasseExtern => StadtRasseNummerExtern.Rasse)
               and
                 SpielVariablen.Rassenbelegung (StadtRasseNummerExtern.Rasse).Belegung /= RassenDatentypen.Leer_Spieler_Enum
               and
                 LeseStadtGebaut.EinwohnerArbeiter (StadtRasseNummerExtern  => StadtRasseNummerExtern,
                                                    EinwohnerArbeiterExtern => True)
               >= 1
              );

private
   use type KartenDatentypen.Kartenfeld;
   
   GrößeAlt : KartenDatentypen.UmgebungsbereichDrei;
   GrößeNeu : KartenDatentypen.UmgebungsbereichDrei;
   
   NahrungGesamt : ProduktionDatentypen.Feldproduktion;
   RessourcenGesamt : ProduktionDatentypen.Feldproduktion;
   GeldGesamt : ProduktionDatentypen.Feldproduktion;
   WissenGesamt : ProduktionDatentypen.Feldproduktion;
   
   NutzbarerBereich : KartenDatentypen.Kartenfeld;
   
   KartenWert : KartenRecords.AchsenKartenfeldNaturalRecord;
   Stadtkoordinaten : KartenRecords.AchsenKartenfeldNaturalRecord;
   
   type UmgebungRecord is record
      
      Belegt : Boolean;
      
      Gesamtbewertung : ProduktionDatentypen.Stadtproduktion;
      
   end record;
   
   type UmgebungArray is array (KartenDatentypen.UmgebungsbereichDrei'Range, KartenDatentypen.UmgebungsbereichDrei'Range) of UmgebungRecord;
   Umgebung : UmgebungArray;
   
   type WelchesFeldRecord is record
      
      HöchsterWert : ProduktionDatentypen.Stadtproduktion;
      YKoordinate : KartenDatentypen.UmgebungsbereichDrei;
      XKoordinate : KartenDatentypen.UmgebungsbereichDrei;
      
   end record;
   
   WelchesFeld : WelchesFeldRecord;
   
   procedure ArbeiterBelegen
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
     with
       Pre => (
                 StadtRasseNummerExtern.Nummer in SpielVariablen.StadtGebautArray'First (2) .. LeseGrenzen.Städtegrenzen (RasseExtern => StadtRasseNummerExtern.Rasse)
               and
                 SpielVariablen.Rassenbelegung (StadtRasseNummerExtern.Rasse).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );
   
   procedure ArbeiterEntfernen
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
     with
       Pre => (
                 StadtRasseNummerExtern.Nummer in SpielVariablen.StadtGebautArray'First (2) .. LeseGrenzen.Städtegrenzen (RasseExtern => StadtRasseNummerExtern.Rasse)
               and
                 SpielVariablen.Rassenbelegung (StadtRasseNummerExtern.Rasse).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );
   
   procedure GebäudeEntfernen
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
     with
       Pre => (
                 StadtRasseNummerExtern.Nummer in SpielVariablen.StadtGebautArray'First (2) .. LeseGrenzen.Städtegrenzen (RasseExtern => StadtRasseNummerExtern.Rasse)
               and
                 SpielVariablen.Rassenbelegung (StadtRasseNummerExtern.Rasse).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );
   
   procedure ArbeiterBelegenEntfernen
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      BelegenEntfernenExtern : in Boolean;
      WachsenSchrumpfenExtern : in Boolean)
     with
       Pre => (
                 StadtRasseNummerExtern.Nummer in SpielVariablen.StadtGebautArray'First (2) .. LeseGrenzen.Städtegrenzen (RasseExtern => StadtRasseNummerExtern.Rasse)
               and
                 SpielVariablen.Rassenbelegung (StadtRasseNummerExtern.Rasse).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );
   
   procedure UmgebungFestlegen
     (ZuwachsOderSchwundExtern : in Boolean;
      StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
     with
       Pre => (
                 StadtRasseNummerExtern.Nummer in SpielVariablen.StadtGebautArray'First (2) .. LeseGrenzen.Städtegrenzen (RasseExtern => StadtRasseNummerExtern.Rasse)
               and
                 SpielVariablen.Rassenbelegung (StadtRasseNummerExtern.Rasse).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );
   
   procedure NeueUmgebungsgrößePrüfen
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      GrößeNeuExtern : in KartenDatentypen.UmgebungsbereichDrei;
      GrößeAltExtern : in KartenDatentypen.UmgebungsbereichDrei)
     with
       Pre => (
                 StadtRasseNummerExtern.Nummer in SpielVariablen.StadtGebautArray'First (2) .. LeseGrenzen.Städtegrenzen (RasseExtern => StadtRasseNummerExtern.Rasse)
               and
                 SpielVariablen.Rassenbelegung (StadtRasseNummerExtern.Rasse).Belegung /= RassenDatentypen.Leer_Spieler_Enum
               and
                 GrößeNeuExtern >= 1
               and
                 GrößeAltExtern >= 1
              );
   
   
   
   function FeldBewerten
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      BelegenOderEntfernen : in Boolean)
      return ProduktionDatentypen.Stadtproduktion
     with
       Pre => (
                 StadtRasseNummerExtern.Nummer in SpielVariablen.StadtGebautArray'First (2) .. LeseGrenzen.Städtegrenzen (RasseExtern => StadtRasseNummerExtern.Rasse)
               and
                 SpielVariablen.Rassenbelegung (StadtRasseNummerExtern.Rasse).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );
   
   function WissenBewertung
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      BelegenOderEntfernen : in Boolean)
      return ProduktionDatentypen.Stadtproduktion
     with
       Pre => (
                 StadtRasseNummerExtern.Nummer in SpielVariablen.StadtGebautArray'First (2) .. LeseGrenzen.Städtegrenzen (RasseExtern => StadtRasseNummerExtern.Rasse)
               and
                 SpielVariablen.Rassenbelegung (StadtRasseNummerExtern.Rasse).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );
   
   function GeldBewertung
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      BelegenOderEntfernen : in Boolean)
      return ProduktionDatentypen.Stadtproduktion
     with
       Pre => (
                 StadtRasseNummerExtern.Nummer in SpielVariablen.StadtGebautArray'First (2) .. LeseGrenzen.Städtegrenzen (RasseExtern => StadtRasseNummerExtern.Rasse)
               and
                 SpielVariablen.Rassenbelegung (StadtRasseNummerExtern.Rasse).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );
   
   function ProduktionBewertung
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      BelegenOderEntfernen : in Boolean)
      return ProduktionDatentypen.Stadtproduktion
     with
       Pre => (
                 StadtRasseNummerExtern.Nummer in SpielVariablen.StadtGebautArray'First (2) .. LeseGrenzen.Städtegrenzen (RasseExtern => StadtRasseNummerExtern.Rasse)
               and
                 SpielVariablen.Rassenbelegung (StadtRasseNummerExtern.Rasse).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );
   
   function NahrungBewertung
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      BelegenOderEntfernen : in Boolean)
      return ProduktionDatentypen.Stadtproduktion
     with
       Pre => (
                 StadtRasseNummerExtern.Nummer in SpielVariablen.StadtGebautArray'First (2) .. LeseGrenzen.Städtegrenzen (RasseExtern => StadtRasseNummerExtern.Rasse)
               and
                 SpielVariablen.Rassenbelegung (StadtRasseNummerExtern.Rasse).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );

end StadtwerteFestlegenLogik;

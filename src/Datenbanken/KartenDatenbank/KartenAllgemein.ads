pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleRecords;
use GlobaleDatentypen;

package KartenAllgemein is

   procedure Beschreibung
     (KartenGrundExtern : in GlobaleDatentypen.Karten_Grund_Enum)
     with
       Pre =>
         (KartenGrundExtern /= GlobaleDatentypen.Leer);



   function GrundNahrung
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return GlobaleDatentypen.ProduktionFeld;

   function GrundRessourcen
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return GlobaleDatentypen.ProduktionFeld;

   function GrundGeld
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return GlobaleDatentypen.ProduktionFeld;

   function GrundWissen
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return GlobaleDatentypen.ProduktionFeld;

   function GrundVerteidigung
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return GlobaleDatentypen.ProduktionFeld;

   function FlussNahrung
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return GlobaleDatentypen.ProduktionFeld;

   function FlussRessourcen
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return GlobaleDatentypen.ProduktionFeld;

   function FlussGeld
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return GlobaleDatentypen.ProduktionFeld;

   function FlussWissen
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return GlobaleDatentypen.ProduktionFeld;

   function FlussVerteidigung
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return GlobaleDatentypen.ProduktionFeld;

   function StraßeNahrung
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return GlobaleDatentypen.ProduktionFeld;

   function StraßeRessourcen
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return GlobaleDatentypen.ProduktionFeld;

   function StraßeGeld
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return GlobaleDatentypen.ProduktionFeld;

   function StraßeWissen
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return GlobaleDatentypen.ProduktionFeld;

   function StraßeVerteidigung
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return GlobaleDatentypen.ProduktionFeld;

   function VerbesserungNahrung
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return GlobaleDatentypen.ProduktionFeld;

   function VerbesserungRessourcen
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return GlobaleDatentypen.ProduktionFeld;

   function VerbesserungGeld
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return GlobaleDatentypen.ProduktionFeld;

   function VerbesserungWissen
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return GlobaleDatentypen.ProduktionFeld;

   function VerbesserungVerteidigung
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return GlobaleDatentypen.ProduktionFeld;

   function RessourceNahrung
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return GlobaleDatentypen.ProduktionFeld;

   function RessourceRessourcen
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return GlobaleDatentypen.ProduktionFeld;

   function RessourceGeld
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return GlobaleDatentypen.ProduktionFeld;

   function RessourceWissen
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return GlobaleDatentypen.ProduktionFeld;

   function RessourceVerteidigung
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return GlobaleDatentypen.ProduktionFeld;

   function FeldSichtbar
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return Boolean;

   function FeldHügel
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return Boolean;

   function FeldGrund
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return GlobaleDatentypen.Karten_Grund_Enum;

   function FeldRessource
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return GlobaleDatentypen.Karten_Grund_Enum;

   function FeldVerbesserung
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return GlobaleDatentypen.Karten_Verbesserung_Enum;

   function FeldStraße
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return GlobaleDatentypen.Karten_Verbesserung_Enum;

   function FeldFluss
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return GlobaleDatentypen.Karten_Grund_Enum;

   function PassierbarGrund
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      PassierbarkeitExtern : in GlobaleDatentypen.Passierbarkeit_Enum)
      return Boolean;

   function PassierbarVerbesserung
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      PassierbarkeitExtern : in GlobaleDatentypen.Passierbarkeit_Enum)
      return Boolean;

   function PassierbarStraße
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      PassierbarkeitExtern : in GlobaleDatentypen.Passierbarkeit_Enum)
      return Boolean;

end KartenAllgemein;

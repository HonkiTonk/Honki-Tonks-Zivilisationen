pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen; use KartenDatentypen;
with KartenRecords;
with ZahlenDatentypen;

with Karten;

package KartengeneratorStandard is

   procedure OberflächeGenerieren;

private
   
   LandHöheBreite : Boolean;
   
   type LandmassenArray is array (1 .. 4) of KartenDatentypen.KartenfeldPositiv;
   Landmassen : LandmassenArray;
   Landabstand : LandmassenArray;
   
   BeliebigerLandwert : KartenDatentypen.Auswahlbereich;
   
   Multiplikator : ZahlenDatentypen.EigenesPositive;
   
   KartenWert : KartenRecords.AchsenKartenfeldNaturalRecord;
   
   type WahrscheinlichkeitenRecord is record
      
      Anfangswert : KartenDatentypen.Auswahlbereich;
      Endwert : KartenDatentypen.Auswahlbereich;
      
   end record;
   
   ---------------------------- Später Nutzereinstellbar machen.
   WahrscheinlichkeitLandmasse : constant WahrscheinlichkeitenRecord := (25, 80);
   WahrscheinlichkeitLandInLandmasse : constant WahrscheinlichkeitenRecord := (0, 90);
   WahrscheinlichkeitWasser : constant WahrscheinlichkeitenRecord := (0, 95);

   procedure LandVorhanden
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      XAchseExtern : in KartenDatentypen.KartenfeldPositiv)
     with
       Pre =>
         (YAchseExtern <= Karten.Karteneinstellungen.Kartengröße.YAchse
          and
            XAchseExtern <= Karten.Karteneinstellungen.Kartengröße.XAchse);
   
   procedure LandmasseGenerieren
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      XAchseExtern : in KartenDatentypen.KartenfeldPositiv)
     with
       Pre =>
         (YAchseExtern <= Karten.Karteneinstellungen.Kartengröße.YAchse
          and
            XAchseExtern <= Karten.Karteneinstellungen.Kartengröße.XAchse);
   
   procedure AbstandGenerieren
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      XAchseExtern : in KartenDatentypen.KartenfeldPositiv)
     with
       Pre =>
         (YAchseExtern <= Karten.Karteneinstellungen.Kartengröße.YAchse
          and
            XAchseExtern <= Karten.Karteneinstellungen.Kartengröße.XAchse);

   procedure GrundSchreiben
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      XAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      MasseAbstandExtern : in Boolean)
     with
       Pre =>
         (YAchseExtern <= Karten.Karteneinstellungen.Kartengröße.YAchse
          and
            XAchseExtern <= Karten.Karteneinstellungen.Kartengröße.XAchse);

end KartengeneratorStandard;

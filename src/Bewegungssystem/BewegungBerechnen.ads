pragma SPARK_Mode (On);

with GlobaleRecords, GlobaleVariablen, GlobaleDatentypen;
use GlobaleDatentypen;

with Karten;

package BewegungBerechnen is

   procedure BewegungEinheitenBerechnung
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      NeuePositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            NeuePositionExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            NeuePositionExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= GlobaleDatentypen.Leer);
   
private
      
   KleinerAbzug : constant GlobaleDatentypen.BewegungFloat := 1.00;
   MittlererAbzug : constant GlobaleDatentypen.BewegungFloat := 2.00;
   GroßerAbzug : constant GlobaleDatentypen.BewegungFloat := 3.00;
   KeinAbzug : constant GlobaleDatentypen.BewegungFloat := 0.00;
   EinheitUnbewegbar : constant GlobaleDatentypen.BewegungFloat := -1.00;
   
   BewegungspunkteAbzug : GlobaleDatentypen.BewegungFloat;
      
   type Bewegungsbonuse_Enum is (Leer, Straße_Fluss, Schiene);
   
   Welchen_Bonus : Bewegungsbonuse_Enum;
   
   type BewegungsmodifikatorArray is array (Bewegungsbonuse_Enum'Range) of GlobaleDatentypen.BewegungFloat;
   Bewegungsmodifikator : constant BewegungsmodifikatorArray := (Leer         => 0.00,
                                                                 Straße_Fluss => 0.50,
                                                                 Schiene      => 1.00);
   
   function AbzugDurchBewegung
     (NeuePositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return GlobaleDatentypen.BewegungFloat
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            NeuePositionExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            NeuePositionExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= GlobaleDatentypen.Leer);
   
   function StraßeUndFlussPrüfen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      NeuePositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return Bewegungsbonuse_Enum
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            NeuePositionExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            NeuePositionExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= GlobaleDatentypen.Leer);

end BewegungBerechnen;

pragma SPARK_Mode (On);

with EinheitStadtDatentypen; use EinheitStadtDatentypen;
with KartenDatentypen; use KartenDatentypen;
with SystemDatentypen; use SystemDatentypen;
with EinheitStadtRecords;
with GlobaleVariablen;
with KartenRecords;
with SystemKonstanten;

with Karten;

package BewegungBerechnen is

   procedure BewegungEinheitenBerechnung
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      NeueKoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord)
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            NeueKoordinatenExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            NeueKoordinatenExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= SystemKonstanten.LeerSpielerKonstante);
   
private
      
   KleinerAbzug : constant EinheitStadtDatentypen.VorhandeneBewegungspunkte := 1.00;
   MittlererAbzug : constant EinheitStadtDatentypen.VorhandeneBewegungspunkte := 2.00;
   GroßerAbzug : constant EinheitStadtDatentypen.VorhandeneBewegungspunkte := 3.00;
   KeinAbzug : constant EinheitStadtDatentypen.VorhandeneBewegungspunkte := 0.00;
   EinheitUnbewegbar : constant EinheitStadtDatentypen.BewegungFloat := -1.00;
   
   BewegungspunkteAbzug : EinheitStadtDatentypen.BewegungFloat;
      
   type Bewegungsbonuse_Enum is (Leer, Straße_Fluss, Schiene);
   
   Welchen_Bonus : Bewegungsbonuse_Enum;
   
   type BewegungsmodifikatorArray is array (Bewegungsbonuse_Enum'Range) of EinheitStadtDatentypen.VorhandeneBewegungspunkte;
   Bewegungsmodifikator : constant BewegungsmodifikatorArray := (Leer         => 0.00,
                                                                 Straße_Fluss => 0.50,
                                                                 Schiene      => 1.00);
   
   procedure NachBewegung
     (NeueKoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            NeueKoordinatenExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            NeueKoordinatenExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= SystemKonstanten.LeerSpielerKonstante);
   
   
   
   function AbzugDurchBewegung
     (NeueKoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return EinheitStadtDatentypen.BewegungFloat
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            NeueKoordinatenExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            NeueKoordinatenExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= SystemKonstanten.LeerSpielerKonstante);
   
   function StraßeUndFlussPrüfen
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      NeueKoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord)
      return Bewegungsbonuse_Enum
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            NeueKoordinatenExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            NeueKoordinatenExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= SystemKonstanten.LeerSpielerKonstante);

end BewegungBerechnen;

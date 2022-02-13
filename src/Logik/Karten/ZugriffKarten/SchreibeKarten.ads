pragma SPARK_Mode (On);

with KartenDatentypen; use KartenDatentypen;
with SystemDatentypen; use SystemDatentypen;
with GlobaleVariablen;
with KartenRecords;
with SystemKonstanten;
with KartenKonstanten;

with Karten;

package SchreibeKarten is

   procedure Grund
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      GrundExtern : in KartenDatentypen.Karten_Grund_Enum)
     with
       Pre =>
         (KoordinatenExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            KoordinatenExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
          and
            GrundExtern /= KartenKonstanten.LeerGrund);
   
   procedure Hügel
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      HügelExtern : in Boolean)
     with
       Pre =>
         (KoordinatenExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            KoordinatenExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);
   
   procedure Sichtbar
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      SichtbarExtern : in Boolean)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= SystemKonstanten.LeerSpielerKonstante
          and
            KoordinatenExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            KoordinatenExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);

   procedure Fluss
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      FlussExtern : in KartenDatentypen.Karten_Grund_Enum)
     with
       Pre =>
         (KoordinatenExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            KoordinatenExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
          and
            (FlussExtern = KartenKonstanten.LeerGrund
             or
               FlussExtern in KartenDatentypen.Karten_Fluss_Enum));

   procedure VerbesserungWeg
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      WegExtern : in KartenDatentypen.Karten_Verbesserung_Enum)
     with
       Pre =>
         (KoordinatenExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            KoordinatenExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
          and
            (WegExtern = KartenKonstanten.LeerVerbesserungWeg
             or
               WegExtern in KartenDatentypen.Karten_Weg_Enum));

   procedure VerbesserungGebiet
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      VerbesserungExtern : in KartenDatentypen.Karten_Verbesserung_Enum)
     with
       Pre =>
         (KoordinatenExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            KoordinatenExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
          and
            VerbesserungExtern not in KartenDatentypen.Karten_Weg_Enum);

   procedure Ressource
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RessourceExtern : in KartenDatentypen.Karten_Grund_Enum)
     with
       Pre =>
         (KoordinatenExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            KoordinatenExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
          and
            RessourceExtern in KartenDatentypen.Karten_Grund_Ressourcen_Enum);

   procedure BelegterGrund
     (KoordinatenExtern : KartenRecords.AchsenKartenfeldPositivRecord;
      BelegterGrundExtern : in KartenRecords.BelegterGrundRecord)
     with
       Pre =>
         (KoordinatenExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            KoordinatenExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);

   procedure Bewertung
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      BewertungExtern : in KartenDatentypen.GesamtbewertungFeld)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= SystemKonstanten.LeerSpielerKonstante
          and
            KoordinatenExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            KoordinatenExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);

end SchreibeKarten;

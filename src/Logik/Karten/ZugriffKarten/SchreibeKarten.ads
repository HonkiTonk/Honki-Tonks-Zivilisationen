pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen; use KartenDatentypen;
with SystemDatentypen; use SystemDatentypen;
with KartenGrundDatentypen; use KartenGrundDatentypen;
with KartenVerbesserungDatentypen; use KartenVerbesserungDatentypen;
with GlobaleVariablen;
with KartenRecords;
with SystemKonstanten;
with KartenGrundKonstanten;
with KartenVerbesserungKonstanten;

with Karten;

package SchreibeKarten is

   procedure Grund
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      GrundExtern : in KartenGrundDatentypen.Karten_Grund_Enum)
     with
       Pre =>
         (KoordinatenExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            KoordinatenExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
          and
            GrundExtern /= KartenGrundKonstanten.LeerGrund);
   
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
      FlussExtern : in KartenGrundDatentypen.Karten_Grund_Enum)
     with
       Pre =>
         (KoordinatenExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            KoordinatenExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
          and
            (FlussExtern = KartenGrundKonstanten.LeerGrund
             or
               FlussExtern in KartenGrundDatentypen.Karten_Fluss_Enum));

   procedure VerbesserungWeg
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      WegExtern : in KartenVerbesserungDatentypen.Karten_Verbesserung_Enum)
     with
       Pre =>
         (KoordinatenExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            KoordinatenExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
          and
            (WegExtern = KartenVerbesserungKonstanten.LeerVerbesserungWeg
             or
               WegExtern in KartenVerbesserungDatentypen.Karten_Weg_Enum));

   procedure VerbesserungGebiet
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      VerbesserungExtern : in KartenVerbesserungDatentypen.Karten_Verbesserung_Enum)
     with
       Pre =>
         (KoordinatenExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            KoordinatenExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
          and
            VerbesserungExtern not in KartenVerbesserungDatentypen.Karten_Weg_Enum);

   procedure Ressource
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RessourceExtern : in KartenGrundDatentypen.Karten_Grund_Enum)
     with
       Pre =>
         (KoordinatenExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            KoordinatenExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
          and
            RessourceExtern in KartenGrundDatentypen.Karten_Grund_Ressourcen_Enum);

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

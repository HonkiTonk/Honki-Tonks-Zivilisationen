pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen; use KartenDatentypen;
with KartengrundDatentypen; use KartengrundDatentypen;
with RassenDatentypen; use RassenDatentypen;
with KartenVerbesserungDatentypen;
with SonstigeVariablen;
with KartenRecords;

with Karten;

package SchreibeKarten is

   procedure AktuellerGrund
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      GrundExtern : in KartengrundDatentypen.Kartengrund_Vorhanden_Enum)
     with
       Pre =>
         (KoordinatenExtern.YAchse <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse
          and
            KoordinatenExtern.XAchse <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchse);
   
   procedure BasisGrund
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      GrundExtern : in KartengrundDatentypen.Kartengrund_Vorhanden_Enum)
     with
       Pre =>
         (KoordinatenExtern.YAchse <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse
          and
            KoordinatenExtern.XAchse <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchse);
   
   procedure ZweimalGrund
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      GrundExtern : in KartengrundDatentypen.Kartengrund_Vorhanden_Enum)
     with
       Pre =>
         (KoordinatenExtern.YAchse <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse
          and
            KoordinatenExtern.XAchse <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchse);
   
   procedure Sichtbar
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      SichtbarExtern : in Boolean)
     with
       Pre =>
         (SonstigeVariablen.RassenImSpiel (RasseExtern) /= RassenDatentypen.Leer_Spieler_Enum
          and
            KoordinatenExtern.YAchse <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse
          and
            KoordinatenExtern.XAchse <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchse);

   procedure Fluss
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      FlussExtern : in KartengrundDatentypen.Kartenfluss_Enum)
     with
       Pre =>
         (KoordinatenExtern.YAchse <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse
          and
            KoordinatenExtern.XAchse <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchse);

   procedure Weg
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      WegExtern : in KartenVerbesserungDatentypen.Karten_Weg_Enum)
     with
       Pre =>
         (KoordinatenExtern.YAchse <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse
          and
            KoordinatenExtern.XAchse <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchse);

   procedure Verbesserung
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      VerbesserungExtern : in KartenVerbesserungDatentypen.Karten_Verbesserung_Enum)
     with
       Pre =>
         (KoordinatenExtern.YAchse <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse
          and
            KoordinatenExtern.XAchse <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchse);

   procedure Ressource
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      RessourceExtern : in KartengrundDatentypen.Kartenressourcen_Enum)
     with
       Pre =>
         (KoordinatenExtern.YAchse <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse
          and
            KoordinatenExtern.XAchse <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchse);

   procedure BelegterGrund
     (KoordinatenExtern : KartenRecords.AchsenKartenfeldNaturalRecord;
      BelegterGrundExtern : in KartenRecords.BelegterGrundRecord)
     with
       Pre =>
         (KoordinatenExtern.YAchse <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse
          and
            KoordinatenExtern.XAchse <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchse);

   procedure Bewertung
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      BewertungExtern : in KartenDatentypen.GesamtbewertungFeld)
     with
       Pre =>
         (SonstigeVariablen.RassenImSpiel (RasseExtern) /= RassenDatentypen.Leer_Spieler_Enum
          and
            KoordinatenExtern.YAchse <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse
          and
            KoordinatenExtern.XAchse <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchse);

end SchreibeKarten;

private with Sf.System.Vector2;
private with Sf.Graphics.Color;

with RassenDatentypen;
with StadtRecords;
with StadtKonstanten;

private with KartenverbesserungDatentypen;
private with KartenRecords;
private with GrafikRecordKonstanten;
private with KartenKonstanten;
private with KartenextraDatentypen;

with LeseGrenzen;
with LeseRassenbelegung;

private with LeseWeltkarteneinstellungen;

package StadtumgebungGrafik is
   pragma Elaborate_Body;
   use type RassenDatentypen.Spieler_Enum;

   procedure Stadtumgebung
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
     with
       Pre => (
                 StadtRasseNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (RasseExtern => StadtRasseNummerExtern.Rasse)
               and
                 LeseRassenbelegung.Belegung (RasseExtern => StadtRasseNummerExtern.Rasse) = RassenDatentypen.Mensch_Spieler_Enum
              );
   
private
   
   FeldBewirtschaftet : Boolean;
   
   KartenfeldRessource : KartenextraDatentypen.Ressourcen_Enum;
   
   KartenfeldFluss : KartenextraDatentypen.Fluss_Enum;
   
   Wegfeld : KartenverbesserungDatentypen.Karten_Weg_Enum;

   Stadtfeld : KartenverbesserungDatentypen.Karten_Verbesserung_Stadt_ID_Enum;
   Verbesserungsfeld : KartenverbesserungDatentypen.Karten_Verbesserung_Enum;
   
   Rahmendicke : Float;
   
   Grundbelegung : StadtRecords.RasseStadtnummerRecord;
   
   Gesamtgrund : KartenRecords.KartengrundRecord;
   
   Viewfläche : Sf.System.Vector2.sfVector2f := GrafikRecordKonstanten.StartgrößeView;

   KartenWert : KartenRecords.AchsenKartenfeldNaturalRecord;
   Stadtkoordinaten : KartenRecords.AchsenKartenfeldNaturalRecord;

   Farbe : Sf.Graphics.Color.sfColor;
   
   procedure DarstellungUmgebung
     (KarteKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f;
      StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      BewirtschaftetExtern : in Boolean)
     with
       Pre => (
                 StadtRasseNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (RasseExtern => StadtRasseNummerExtern.Rasse)
               and
                 LeseRassenbelegung.Belegung (RasseExtern => StadtRasseNummerExtern.Rasse) = RassenDatentypen.Mensch_Spieler_Enum
               and
                 KarteKoordinatenExtern.YAchse in KartenKonstanten.AnfangYAchse .. LeseWeltkarteneinstellungen.YAchse
               and
                 KarteKoordinatenExtern.XAchse in KartenKonstanten.AnfangXAchse .. LeseWeltkarteneinstellungen.XAchse
              );

   procedure AnzeigeLandschaft
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
     with
       Pre => (
                 KoordinatenExtern.YAchse in KartenKonstanten.AnfangYAchse .. LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse in KartenKonstanten.AnfangXAchse .. LeseWeltkarteneinstellungen.XAchse
              );

   procedure KartenfeldZeichnen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
     with
       Pre => (
                 KoordinatenExtern.YAchse in KartenKonstanten.AnfangYAchse .. LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse in KartenKonstanten.AnfangXAchse .. LeseWeltkarteneinstellungen.XAchse
              );

   procedure FlussZeichnen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
     with
       Pre => (
                 KoordinatenExtern.YAchse in KartenKonstanten.AnfangYAchse .. LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse in KartenKonstanten.AnfangXAchse .. LeseWeltkarteneinstellungen.XAchse
              );

   procedure RessourceZeichnen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
     with
       Pre => (
                 KoordinatenExtern.YAchse in KartenKonstanten.AnfangYAchse .. LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse in KartenKonstanten.AnfangXAchse .. LeseWeltkarteneinstellungen.XAchse
              );

   procedure WegZeichnen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
     with
       Pre => (
                 KoordinatenExtern.YAchse in KartenKonstanten.AnfangYAchse .. LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse in KartenKonstanten.AnfangXAchse .. LeseWeltkarteneinstellungen.XAchse
              );

   procedure VerbesserungZeichnen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
     with
       Pre => (
                 KoordinatenExtern.YAchse in KartenKonstanten.AnfangYAchse .. LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse in KartenKonstanten.AnfangXAchse .. LeseWeltkarteneinstellungen.XAchse
              );

end StadtumgebungGrafik;

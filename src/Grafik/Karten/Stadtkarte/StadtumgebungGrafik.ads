with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

private with Sf.System.Vector2;
private with Sf.Graphics.Color;

with SpeziesDatentypen;
with StadtKonstanten;
with StadtGrafikRecords;

private with KartenverbesserungDatentypen;
private with KartenRecords;
private with KartenKonstanten;
private with KartenextraDatentypen;
private with GrafikRecordKonstanten;
private with StadtRecords;

with LeseGrenzen;
with LeseSpeziesbelegung;

private with LeseWeltkarteneinstellungen;

package StadtumgebungGrafik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;

   procedure Stadtumgebung
     (StadtauswahlExtern : in StadtGrafikRecords.StadtumgebungGrafikRecord)
     with
       Pre => (
                 StadtauswahlExtern.SpeziesNummer.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtauswahlExtern.SpeziesNummer.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtauswahlExtern.SpeziesNummer.Spezies) = SpeziesDatentypen.Mensch_Spieler_Enum
              );
   
private
   
   FeldBewirtschaftet : Boolean;
   
   KartenfeldRessource : KartenextraDatentypen.Ressourcen_Enum;
   
   KartenfeldFluss : KartenextraDatentypen.Fluss_Enum;
   
   Wegfeld : KartenverbesserungDatentypen.Weg_Enum;

   Stadtfeld : KartenverbesserungDatentypen.Verbesserung_Stadt_ID_Enum;
   Verbesserungsfeld : KartenverbesserungDatentypen.Verbesserung_Enum;
   
   Rahmendicke : Float;
   
   Text : Unbounded_Wide_Wide_String;
   
   Grundbelegung : StadtRecords.SpeziesStadtnummerRecord;
   
   Gesamtgrund : KartenRecords.KartengrundRecord;
   
   AktuellePosition : Sf.System.Vector2.sfVector2f;
   Viewfläche : Sf.System.Vector2.sfVector2f := GrafikRecordKonstanten.StartView;
   Feldgröße : Sf.System.Vector2.sfVector2f;

   KartenWert : KartenRecords.AchsenKartenfeldNaturalRecord;

   Farbe : Sf.Graphics.Color.sfColor;
   
   procedure DarstellungUmgebung
     (KarteKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f;
      FeldgrößeExtern : in Sf.System.Vector2.sfVector2f;
      StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      BewirtschaftetExtern : in Boolean)
     with
       Pre => (
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) = SpeziesDatentypen.Mensch_Spieler_Enum
               and
                 KarteKoordinatenExtern.YAchse in KartenKonstanten.AnfangYAchse .. LeseWeltkarteneinstellungen.YAchse
               and
                 KarteKoordinatenExtern.XAchse in KartenKonstanten.AnfangXAchse .. LeseWeltkarteneinstellungen.XAchse
               and
                 PositionExtern.x >= 0.00
               and
                 PositionExtern.y >= 0.00
               and
                 FeldgrößeExtern.x >= 0.00
               and
                 FeldgrößeExtern.y >= 0.00
              );

   procedure AnzeigeLandschaft
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      FeldgrößeExtern : in Sf.System.Vector2.sfVector2f;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
     with
       Pre => (
                 KoordinatenExtern.YAchse in KartenKonstanten.AnfangYAchse .. LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse in KartenKonstanten.AnfangXAchse .. LeseWeltkarteneinstellungen.XAchse
               and
                 FeldgrößeExtern.x >= 0.00
               and
                 FeldgrößeExtern.y >= 0.00
              );

   procedure KartenfeldZeichnen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      FeldgrößeExtern : in Sf.System.Vector2.sfVector2f;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
     with
       Pre => (
                 KoordinatenExtern.YAchse in KartenKonstanten.AnfangYAchse .. LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse in KartenKonstanten.AnfangXAchse .. LeseWeltkarteneinstellungen.XAchse
               and
                 FeldgrößeExtern.x >= 0.00
               and
                 FeldgrößeExtern.y >= 0.00
              );

   procedure FlussZeichnen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      FeldgrößeExtern : in Sf.System.Vector2.sfVector2f;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
     with
       Pre => (
                 KoordinatenExtern.YAchse in KartenKonstanten.AnfangYAchse .. LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse in KartenKonstanten.AnfangXAchse .. LeseWeltkarteneinstellungen.XAchse
               and
                 FeldgrößeExtern.x >= 0.00
               and
                 FeldgrößeExtern.y >= 0.00
              );

   procedure RessourceZeichnen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      FeldgrößeExtern : in Sf.System.Vector2.sfVector2f;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
     with
       Pre => (
                 KoordinatenExtern.YAchse in KartenKonstanten.AnfangYAchse .. LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse in KartenKonstanten.AnfangXAchse .. LeseWeltkarteneinstellungen.XAchse
               and
                 FeldgrößeExtern.x >= 0.00
               and
                 FeldgrößeExtern.y >= 0.00
              );

   procedure WegZeichnen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      FeldgrößeExtern : in Sf.System.Vector2.sfVector2f;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
     with
       Pre => (
                 KoordinatenExtern.YAchse in KartenKonstanten.AnfangYAchse .. LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse in KartenKonstanten.AnfangXAchse .. LeseWeltkarteneinstellungen.XAchse
               and
                 FeldgrößeExtern.x >= 0.00
               and
                 FeldgrößeExtern.y >= 0.00
              );

   procedure VerbesserungZeichnen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      FeldgrößeExtern : in Sf.System.Vector2.sfVector2f;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
     with
       Pre => (
                 KoordinatenExtern.YAchse in KartenKonstanten.AnfangYAchse .. LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse in KartenKonstanten.AnfangXAchse .. LeseWeltkarteneinstellungen.XAchse
               and
                 FeldgrößeExtern.x >= 0.00
               and
                 FeldgrößeExtern.y >= 0.00
              );
   
   procedure FeldeffektZeichnen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      FeldgrößeExtern : in Sf.System.Vector2.sfVector2f;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
     with
       Pre => (
                 KoordinatenExtern.YAchse in KartenKonstanten.AnfangYAchse .. LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse in KartenKonstanten.AnfangXAchse .. LeseWeltkarteneinstellungen.XAchse
               and
                 FeldgrößeExtern.x >= 0.00
               and
                 FeldgrößeExtern.y >= 0.00
              );
   
   procedure Wirtschaftsinformationen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f;
      FeldgrößeExtern : in Sf.System.Vector2.sfVector2f;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) = SpeziesDatentypen.Mensch_Spieler_Enum
               and
                 KoordinatenExtern.YAchse in KartenKonstanten.AnfangYAchse .. LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse in KartenKonstanten.AnfangXAchse .. LeseWeltkarteneinstellungen.XAchse
               and
                 PositionExtern.x >= 0.00
               and
                 PositionExtern.y >= 0.00
               and
                 FeldgrößeExtern.x >= 0.00
               and
                 FeldgrößeExtern.y >= 0.00
              );

end StadtumgebungGrafik;

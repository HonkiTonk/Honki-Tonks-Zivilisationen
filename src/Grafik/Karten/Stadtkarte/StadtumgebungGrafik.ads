private with Ada.Strings.Wide_Wide_Unbounded;

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
   use Ada.Strings.Wide_Wide_Unbounded;
   
   FeldBewirtschaftet : Boolean;
   
   KartenfeldRessource : KartenextraDatentypen.Ressourcen_Enum;
   
   KartenfeldFluss : KartenextraDatentypen.Fluss_Enum;
   
   Wegfeld : KartenverbesserungDatentypen.Weg_Enum;

   Stadtfeld : KartenverbesserungDatentypen.Verbesserung_Stadt_ID_Enum;
   Verbesserungsfeld : KartenverbesserungDatentypen.Verbesserung_Enum;
   
   Schriftabstandanpassung : constant Float := 4.30;
   Rahmendicke : Float;
   
   Text : Unbounded_Wide_Wide_String;
   
   Grundbelegung : StadtRecords.SpeziesStadtnummerRecord;
   
   Gesamtgrund : KartenRecords.KartengrundRecord;
   
   AktuellePosition : Sf.System.Vector2.sfVector2f;
   Viewfläche : Sf.System.Vector2.sfVector2f := GrafikRecordKonstanten.StartView;
   Skalierung : Sf.System.Vector2.sfVector2f;
   Feldgröße : Sf.System.Vector2.sfVector2f;

   KartenWert : KartenRecords.KartenfeldNaturalRecord;

   Farbe : Sf.Graphics.Color.sfColor;
   
   procedure DarstellungUmgebung
     (KarteKoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
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
                 KarteKoordinatenExtern.Senkrechte in KartenKonstanten.AnfangSenkrechte .. LeseWeltkarteneinstellungen.Senkrechte
               and
                 KarteKoordinatenExtern.Waagerechte in KartenKonstanten.AnfangWaagerechte .. LeseWeltkarteneinstellungen.Waagerechte
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
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      FeldgrößeExtern : in Sf.System.Vector2.sfVector2f;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
     with
       Pre => (
                 KoordinatenExtern.Senkrechte in KartenKonstanten.AnfangSenkrechte .. LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte in KartenKonstanten.AnfangWaagerechte .. LeseWeltkarteneinstellungen.Waagerechte
               and
                 FeldgrößeExtern.x >= 0.00
               and
                 FeldgrößeExtern.y >= 0.00
              );

   procedure KartenfeldZeichnen
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      FeldgrößeExtern : in Sf.System.Vector2.sfVector2f;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
     with
       Pre => (
                 KoordinatenExtern.Senkrechte in KartenKonstanten.AnfangSenkrechte .. LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte in KartenKonstanten.AnfangWaagerechte .. LeseWeltkarteneinstellungen.Waagerechte
               and
                 FeldgrößeExtern.x >= 0.00
               and
                 FeldgrößeExtern.y >= 0.00
              );

   procedure FlussZeichnen
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      FeldgrößeExtern : in Sf.System.Vector2.sfVector2f;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
     with
       Pre => (
                 KoordinatenExtern.Senkrechte in KartenKonstanten.AnfangSenkrechte .. LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte in KartenKonstanten.AnfangWaagerechte .. LeseWeltkarteneinstellungen.Waagerechte
               and
                 FeldgrößeExtern.x >= 0.00
               and
                 FeldgrößeExtern.y >= 0.00
              );

   procedure RessourceZeichnen
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      FeldgrößeExtern : in Sf.System.Vector2.sfVector2f;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
     with
       Pre => (
                 KoordinatenExtern.Senkrechte in KartenKonstanten.AnfangSenkrechte .. LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte in KartenKonstanten.AnfangWaagerechte .. LeseWeltkarteneinstellungen.Waagerechte
               and
                 FeldgrößeExtern.x >= 0.00
               and
                 FeldgrößeExtern.y >= 0.00
              );

   procedure WegZeichnen
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      FeldgrößeExtern : in Sf.System.Vector2.sfVector2f;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
     with
       Pre => (
                 KoordinatenExtern.Senkrechte in KartenKonstanten.AnfangSenkrechte .. LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte in KartenKonstanten.AnfangWaagerechte .. LeseWeltkarteneinstellungen.Waagerechte
               and
                 FeldgrößeExtern.x >= 0.00
               and
                 FeldgrößeExtern.y >= 0.00
              );

   procedure VerbesserungZeichnen
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      FeldgrößeExtern : in Sf.System.Vector2.sfVector2f;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
     with
       Pre => (
                 KoordinatenExtern.Senkrechte in KartenKonstanten.AnfangSenkrechte .. LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte in KartenKonstanten.AnfangWaagerechte .. LeseWeltkarteneinstellungen.Waagerechte
               and
                 FeldgrößeExtern.x >= 0.00
               and
                 FeldgrößeExtern.y >= 0.00
              );
   
   procedure FeldeffektZeichnen
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      FeldgrößeExtern : in Sf.System.Vector2.sfVector2f;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
     with
       Pre => (
                 KoordinatenExtern.Senkrechte in KartenKonstanten.AnfangSenkrechte .. LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte in KartenKonstanten.AnfangWaagerechte .. LeseWeltkarteneinstellungen.Waagerechte
               and
                 FeldgrößeExtern.x >= 0.00
               and
                 FeldgrößeExtern.y >= 0.00
              );
   
   procedure Wirtschaftsinformationen
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f;
      FeldgrößeExtern : in Sf.System.Vector2.sfVector2f;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) = SpeziesDatentypen.Mensch_Spieler_Enum
               and
                 KoordinatenExtern.Senkrechte in KartenKonstanten.AnfangSenkrechte .. LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte in KartenKonstanten.AnfangWaagerechte .. LeseWeltkarteneinstellungen.Waagerechte
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

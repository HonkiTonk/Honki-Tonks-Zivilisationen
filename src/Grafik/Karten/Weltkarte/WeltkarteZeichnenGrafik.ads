with Ada.Calendar; use Ada.Calendar;

with Sf.System.Vector2;

private with Sf.Graphics.Color;

with KartenDatentypen;
with KartenRecords;
with EinheitenRecords;
with Weltkarte;

private with KartenartDatentypen;
private with RassenDatentypen;
private with KartengrundDatentypen;
private with KartenverbesserungDatentypen;
private with EinheitenDatentypen;
private with SpielVariablen;
private with StadtRecords;

package WeltkarteZeichnenGrafik is
   pragma Elaborate_Body;
   use type KartenDatentypen.Kartenfeld;
   
   procedure EbeneZeichnen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f;
      TransparentsExtern : in Sf.sfUint8;
      EbeneExtern : in KartenDatentypen.EbeneVorhanden)
     with
       Pre => (
                 KoordinatenExtern.YAchse <= Weltkarte.Karteneinstellungen.Kartengröße.YAchse
               and
                 KoordinatenExtern.XAchse <= Weltkarte.Karteneinstellungen.Kartengröße.XAchse
               and
                 PositionExtern.x >= 0.00
               and
                 PositionExtern.y >= 0.00
              );
   
private
   use type RassenDatentypen.Spieler_Enum;
   
   AusgewählteEinheitAnzeigen : Boolean := True;
   ZusatzgrundVorhanden : Boolean;
   
   AktuelleRasse : RassenDatentypen.Rassen_Enum;
      
   KartenfeldFluss : KartengrundDatentypen.Kartenfluss_Enum;
   
   KartenfeldRessource : KartengrundDatentypen.Kartenressourcen_Enum;
   
   Stadtart : KartenverbesserungDatentypen.Karten_Verbesserung_Stadt_ID_Enum;
   Wegfeld : KartenverbesserungDatentypen.Karten_Weg_Enum;
   Verbesserungsfeld : KartenverbesserungDatentypen.Karten_Verbesserung_Enum;
   
   FeldeinheitID : EinheitenDatentypen.EinheitenIDMitNullWert;
   AusgewählteEinheitID : EinheitenDatentypen.EinheitenIDMitNullWert;
   
   Durchsichtigkeit : Sf.sfUint8;
   
   DickeRahmen : constant Float := 5.00;
   
   Gesamtgrund : KartenRecords.KartengrundRecord;
         
   StadtRasseNummer : StadtRecords.RasseStadtnummerRecord;
   
   EinheitRasseNummer : EinheitenRecords.RasseEinheitnummerRecord;
   
   Textposition : Sf.System.Vector2.sfVector2f;
   Rahmenposition : Sf.System.Vector2.sfVector2f;
   Rahmengröße : Sf.System.Vector2.sfVector2f;
   
   KartenWertRahmen : KartenRecords.AchsenKartenfeldNaturalRecord;
   
   Farbe : Sf.Graphics.Color.sfColor;
   
   StartzeitBlinkintervall : Time := Clock;
      
   type UmgebungArray is array (KartenartDatentypen.Himmelsrichtungen_Enum'Range) of KartenRecords.AchsenKartenfeldRecord;
   Umgebung : constant UmgebungArray := (
                                         KartenartDatentypen.Norden_Enum => (0, -1, 0),
                                         KartenartDatentypen.Westen_Enum => (0, 0, -1),
                                         KartenartDatentypen.Osten_Enum  => (0, 0, 1),
                                         KartenartDatentypen.Süden_Enum  => (0, 1, 0)
                                        );
   
   procedure RahmenZeichnen
     (WelcheRichtungExtern : in KartenartDatentypen.Himmelsrichtungen_Enum;
      PositionExtern : in Sf.System.Vector2.sfVector2f;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre => (
                 SpielVariablen.Rassenbelegung (RasseExtern).Belegung /= RassenDatentypen.Leer_Spieler_Enum
               and
                 PositionExtern.x >= 0.00
               and
                 PositionExtern.y >= 0.00
              );
   
   procedure RahmenBesetztesFeld
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre => (
                 SpielVariablen.Rassenbelegung (RasseExtern).Belegung /= RassenDatentypen.Leer_Spieler_Enum
               and
                 KoordinatenExtern.YAchse <= Weltkarte.Karteneinstellungen.Kartengröße.YAchse
               and
                 KoordinatenExtern.XAchse <= Weltkarte.Karteneinstellungen.Kartengröße.XAchse
               and
                 PositionExtern.x >= 0.00
               and
                 PositionExtern.y >= 0.00
              );
   
   procedure AnzeigeEinheit
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
     with
       Pre => (
                 KoordinatenExtern.YAchse <= Weltkarte.Karteneinstellungen.Kartengröße.YAchse
               and
                 KoordinatenExtern.XAchse <= Weltkarte.Karteneinstellungen.Kartengröße.XAchse
               and
                 PositionExtern.x >= 0.00
               and
                 PositionExtern.y >= 0.00
              );
   
   procedure AnzeigeFeldbesitzer
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
     with
       Pre => (
                 KoordinatenExtern.YAchse <= Weltkarte.Karteneinstellungen.Kartengröße.YAchse
               and
                 KoordinatenExtern.XAchse <= Weltkarte.Karteneinstellungen.Kartengröße.XAchse
               and
                 PositionExtern.x >= 0.00
               and
                 PositionExtern.y >= 0.00
              );
   
   procedure KartenfeldZeichnen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f;
      DurchsichtigkeitExtern : in Sf.sfUint8)
     with
       Pre => (
                 KoordinatenExtern.YAchse <= Weltkarte.Karteneinstellungen.Kartengröße.YAchse
               and
                 KoordinatenExtern.XAchse <= Weltkarte.Karteneinstellungen.Kartengröße.XAchse
               and
                 PositionExtern.x >= 0.00
               and
                 PositionExtern.y >= 0.00
              );
   
   procedure FlussZeichnen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
     with
       Pre => (
                 KoordinatenExtern.YAchse <= Weltkarte.Karteneinstellungen.Kartengröße.YAchse
               and
                 KoordinatenExtern.XAchse <= Weltkarte.Karteneinstellungen.Kartengröße.XAchse
               and
                 PositionExtern.x >= 0.00
               and
                 PositionExtern.y >= 0.00
              );
   
   procedure RessourceZeichnen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
     with
       Pre => (
                 KoordinatenExtern.YAchse <= Weltkarte.Karteneinstellungen.Kartengröße.YAchse
               and
                 KoordinatenExtern.XAchse <= Weltkarte.Karteneinstellungen.Kartengröße.XAchse
               and
                 PositionExtern.x >= 0.00
               and
                 PositionExtern.y >= 0.00
              );
   
   procedure WegZeichnen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
     with
       Pre => (
                 KoordinatenExtern.YAchse <= Weltkarte.Karteneinstellungen.Kartengröße.YAchse
               and
                 KoordinatenExtern.XAchse <= Weltkarte.Karteneinstellungen.Kartengröße.XAchse
               and
                 PositionExtern.x >= 0.00
               and
                 PositionExtern.y >= 0.00
              );
   
   procedure VerbesserungZeichnen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      EbeneExtern : in KartenDatentypen.EbeneVorhanden;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
     with
       Pre => (
                 KoordinatenExtern.YAchse <= Weltkarte.Karteneinstellungen.Kartengröße.YAchse
               and
                 KoordinatenExtern.XAchse <= Weltkarte.Karteneinstellungen.Kartengröße.XAchse
               and
                 PositionExtern.x >= 0.00
               and
                 PositionExtern.y >= 0.00
              );
   
   procedure StadtnameAnzeigen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
     with
       Pre => (
                 KoordinatenExtern.YAchse <= Weltkarte.Karteneinstellungen.Kartengröße.YAchse
               and
                 KoordinatenExtern.XAchse <= Weltkarte.Karteneinstellungen.Kartengröße.XAchse
               and
                 PositionExtern.x >= 0.00
               and
                 PositionExtern.y >= 0.00
              );
   
end WeltkarteZeichnenGrafik;

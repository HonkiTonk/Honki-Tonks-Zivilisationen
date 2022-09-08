pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Calendar; use Ada.Calendar;

with Sf.System.Vector2;

with RassenDatentypen; use RassenDatentypen;
with KartenDatentypen; use KartenDatentypen;
with KartengrundDatentypen;
with KartenverbesserungDatentypen;
with EinheitenDatentypen;
with KartenRecords;
with EinheitenRecords;
with SpielVariablen;
with StadtRecords;

with Karten;

package WeltkarteZeichnenGrafik is
   
   -- Das hier mal in irgendwas Globales verschieben. äöü
   type Umgebung_Enum is (Norden, Westen, Osten, Süden);
   
   type UmgebungArray is array (Umgebung_Enum'Range) of KartenRecords.AchsenKartenfeldRecord;
   Umgebung : constant UmgebungArray := (
                                         Norden => (0, -1, 0),
                                         Westen => (0, 0, -1),
                                         Osten  => (0, 0, 1),
                                         Süden  => (0, 1, 0)
                                        );
   
   -- Für die Possitionen noch den Pre >= 0.00 anlegen? äöü
   procedure AnzeigeEinheit
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      RasseEinheitExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
     with
       Pre => (
               -- Anders als die /= RassenDatentypen.Leer_Spieler_Enum weiter unten, funktioniert das hier mit der KI weil nur die Spielerrasse übergeben wird und die KIEinheit in der Prozedur selbst gesucht wird.
                 SpielVariablen.RassenImSpiel (RasseEinheitExtern.Rasse) = RassenDatentypen.Mensch_Spieler_Enum
               and
                 KoordinatenExtern.YAchse <= Karten.Karteneinstellungen.Kartengröße.YAchse
               and
                 KoordinatenExtern.XAchse <= Karten.Karteneinstellungen.Kartengröße.XAchse
              );
   
   procedure AnzeigeFeldbesitzer
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
     with
       Pre => (
                 KoordinatenExtern.YAchse <= Karten.Karteneinstellungen.Kartengröße.YAchse
               and
                 KoordinatenExtern.XAchse <= Karten.Karteneinstellungen.Kartengröße.XAchse
              );
   
   procedure RahmenBesetztesFeld
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre => (
                 SpielVariablen.RassenImSpiel (RasseExtern) /= RassenDatentypen.Leer_Spieler_Enum
               and
                 KoordinatenExtern.YAchse <= Karten.Karteneinstellungen.Kartengröße.YAchse
               and
                 KoordinatenExtern.XAchse <= Karten.Karteneinstellungen.Kartengröße.XAchse
              );
   
   procedure RahmenZeichnen
     (WelcheRichtungExtern : in Umgebung_Enum;
      PositionExtern : in Sf.System.Vector2.sfVector2f;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre => (
                 SpielVariablen.RassenImSpiel (RasseExtern) /= RassenDatentypen.Leer_Spieler_Enum
              );
   
   procedure KartenfeldZeichnen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f;
      DurchsichtigkeitExtern : in Sf.sfUint8)
     with
       Pre => (
                 KoordinatenExtern.YAchse <= Karten.Karteneinstellungen.Kartengröße.YAchse
               and
                 KoordinatenExtern.XAchse <= Karten.Karteneinstellungen.Kartengröße.XAchse
              );
   
   procedure FlussZeichnen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
     with
       Pre => (
                 KoordinatenExtern.YAchse <= Karten.Karteneinstellungen.Kartengröße.YAchse
               and
                 KoordinatenExtern.XAchse <= Karten.Karteneinstellungen.Kartengröße.XAchse
              );
   
   procedure RessourceZeichnen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
     with
       Pre => (
                 KoordinatenExtern.YAchse <= Karten.Karteneinstellungen.Kartengröße.YAchse
               and
                 KoordinatenExtern.XAchse <= Karten.Karteneinstellungen.Kartengröße.XAchse
              );
   
   procedure WegZeichnen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
     with
       Pre => (
                 KoordinatenExtern.YAchse <= Karten.Karteneinstellungen.Kartengröße.YAchse
               and
                 KoordinatenExtern.XAchse <= Karten.Karteneinstellungen.Kartengröße.XAchse
              );
   
   procedure VerbesserungZeichnen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      EbeneExtern : in KartenDatentypen.EbeneVorhanden;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
     with
       Pre => (
                 KoordinatenExtern.YAchse <= Karten.Karteneinstellungen.Kartengröße.YAchse
               and
                 KoordinatenExtern.XAchse <= Karten.Karteneinstellungen.Kartengröße.XAchse
              );
   
   procedure StadtnameAnzeigen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
     with
       Pre => (
                 KoordinatenExtern.YAchse <= Karten.Karteneinstellungen.Kartengröße.YAchse
               and
                 KoordinatenExtern.XAchse <= Karten.Karteneinstellungen.Kartengröße.XAchse
              );
   
private
   
   AusgewählteEinheitAnzeigen : Boolean := True;
   
   AktuelleRasse : RassenDatentypen.Rassen_Enum;
   
   AktuellerKartengrund : KartengrundDatentypen.Kartengrund_Enum;
   BasisKartengrund : KartengrundDatentypen.Kartengrund_Enum;
   KartenfeldFluss : KartengrundDatentypen.Kartenfluss_Enum;
   KartenfeldRessource : KartengrundDatentypen.Kartenressourcen_Enum;
   
   Stadtart : KartenverbesserungDatentypen.Karten_Verbesserung_Stadt_ID_Enum;
   Wegfeld : KartenverbesserungDatentypen.Karten_Weg_Enum;
   Verbesserungsfeld : KartenverbesserungDatentypen.Karten_Verbesserung_Enum;
   
   EinheitID : EinheitenDatentypen.EinheitenID;
   
   DickeRahmen : constant Float := 5.00;
         
   StadtRasseNummer : StadtRecords.RasseStadtnummerRecord;
   
   EinheitRasseNummer : EinheitenRecords.RasseEinheitnummerRecord;
   
   Textposition : Sf.System.Vector2.sfVector2f;
   Rahmenposition : Sf.System.Vector2.sfVector2f;
   Rahmengröße : Sf.System.Vector2.sfVector2f;
   
   KartenWertRahmen : KartenRecords.AchsenKartenfeldNaturalRecord;
   
   StartzeitBlinkintervall : Time := Clock;
   
end WeltkarteZeichnenGrafik;

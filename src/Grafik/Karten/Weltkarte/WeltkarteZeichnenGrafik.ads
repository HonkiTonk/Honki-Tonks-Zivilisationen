with Ada.Real_Time; use Ada.Real_Time;

with Sf.System.Vector2;

private with Sf.Graphics.Color;

with KartenDatentypen;
with KartenRecords;
with EinheitenRecords;

private with KartenartDatentypen;
private with EinheitenDatentypen;
private with StadtRecords;

with LeseWeltkarteneinstellungen;

package WeltkarteZeichnenGrafik is
   pragma Elaborate_Body;
   use type KartenDatentypen.Kartenfeld;
   
   procedure EbeneZeichnen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f;
      TransparentsExtern : in Sf.sfUint8;
      EbeneExtern : in KartenDatentypen.EbeneVorhanden)
     with
       Pre => (
                 KoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
               and
                 PositionExtern.x >= 0.00
               and
                 PositionExtern.y >= 0.00
              );
   
private
   
   AusgewählteEinheitAnzeigen : Boolean := True;
   ZusatzgrundVorhanden : Boolean;
   
   
   FeldeinheitID : EinheitenDatentypen.EinheitenIDMitNullWert;
   AusgewählteEinheitID : EinheitenDatentypen.EinheitenIDMitNullWert;
   
   Durchsichtigkeit : Sf.sfUint8;
   
   DickeRahmen : constant Float := 5.00;
   Textbreite : Float;
         
   StadtSpeziesNummer : StadtRecords.SpeziesStadtnummerRecord;
   
   EinheitSpeziesNummer : EinheitenRecords.SpeziesEinheitnummerRecord;
      
   Textposition : Sf.System.Vector2.sfVector2f;
   Rahmenposition : Sf.System.Vector2.sfVector2f;
   Rahmengröße : Sf.System.Vector2.sfVector2f;
   Skalierung : Sf.System.Vector2.sfVector2f;
   
   KartenWertRahmen : KartenRecords.AchsenKartenfeldNaturalRecord;
   EinheitKoordinaten : KartenRecords.AchsenKartenfeldNaturalRecord;
   BewegungsfeldKoordinaten : KartenRecords.AchsenKartenfeldNaturalRecord;
   
   Zwischenspeicher : KartenRecords.AchsenKartenfeldRecord;
   
   Farbe : Sf.Graphics.Color.sfColor;
   
   StartzeitBlinkintervall : Time := Clock;
      
   type UmgebungArray is array (KartenartDatentypen.Himmelsrichtungen_Enum'Range) of KartenRecords.AchsenKartenfeldRecord;
   Umgebung : constant UmgebungArray := (
                                         KartenartDatentypen.Norden_Enum => (0, -1, 0),
                                         KartenartDatentypen.Westen_Enum => (0, 0, -1),
                                         KartenartDatentypen.Osten_Enum  => (0, 0, 1),
                                         KartenartDatentypen.Süden_Enum  => (0, 1, 0)
                                        );
   
   
   
   procedure AnzeigeEinheit
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
     with
       Pre => (
                 KoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
               and
                 PositionExtern.x >= 0.00
               and
                 PositionExtern.y >= 0.00
              );
   
   
   
   
   
   
   
   
   
   
   
   procedure Einheitenmarkierung
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
     with
       Pre => (
                 KoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
               and
                 PositionExtern.x >= 0.00
               and
                 PositionExtern.y >= 0.00
              );
   
   procedure AnzeigeBewegungsfeld
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
     with
       Pre => (
                 KoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
               and
                 PositionExtern.x >= 0.00
               and
                 PositionExtern.y >= 0.00
              );
   
end WeltkarteZeichnenGrafik;

with Ada.Calendar; use Ada.Calendar;

with Sf.System.Vector2;

with KartenRecords;
with EinheitenRecords;
with KartenDatentypen;

private with EinheitenDatentypen;
private with KartenartDatentypen;

with LeseWeltkarteneinstellungen;

package WeltkarteEinheitZeichnenGrafik is
   pragma Elaborate_Body;
   use type KartenDatentypen.Kartenfeld;

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
  
private
   
   AusgewählteEinheitAnzeigen : Boolean := True;
   ZusatzgrundVorhanden : Boolean;
   
   FeldeinheitID : EinheitenDatentypen.EinheitenIDMitNullWert;
   AusgewählteEinheitID : EinheitenDatentypen.EinheitenIDMitNullWert;
   
   Durchsichtigkeit : Sf.sfUint8;
   
   EinheitSpeziesNummer : EinheitenRecords.SpeziesEinheitnummerRecord;
         
   EinheitKoordinaten : KartenRecords.AchsenKartenfeldNaturalRecord;
   BewegungsfeldKoordinaten : KartenRecords.AchsenKartenfeldNaturalRecord;
   
   Zwischenspeicher : KartenRecords.AchsenKartenfeldRecord;
   
   StartzeitBlinkintervall : Time := Clock;
      
   type UmgebungArray is array (KartenartDatentypen.Himmelsrichtungen_Enum'Range) of KartenRecords.AchsenKartenfeldRecord;
   Umgebung : constant UmgebungArray := (
                                         KartenartDatentypen.Norden_Enum => (0, -1, 0),
                                         KartenartDatentypen.Westen_Enum => (0, 0, -1),
                                         KartenartDatentypen.Osten_Enum  => (0, 0, 1),
                                         KartenartDatentypen.Süden_Enum  => (0, 1, 0)
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

end WeltkarteEinheitZeichnenGrafik;

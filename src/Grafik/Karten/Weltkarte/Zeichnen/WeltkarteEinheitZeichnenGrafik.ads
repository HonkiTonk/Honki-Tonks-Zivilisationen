with Ada.Calendar; use Ada.Calendar;

with Sf.System.Vector2;

with KartenRecords;
with EinheitenRecords;
with KartenDatentypen;
with EinheitenGrafikRecords;
with EinheitenDatentypen;
with SpeziesDatentypen;

with LeseWeltkarteneinstellungen;
with LeseGrenzen;
with LeseSpeziesbelegung;

package WeltkarteEinheitZeichnenGrafik is
   pragma Elaborate_Body;
   use type KartenDatentypen.Kartenfeld;
   use type EinheitenDatentypen.MaximaleEinheitenMitNullWert;
   use type SpeziesDatentypen.Spieler_Enum;

   procedure AnzeigeEinheit
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      EinheitenauswahlExtern : in EinheitenGrafikRecords.EinheitGrafikRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
     with
       Pre => (
                 EinheitenauswahlExtern.SpeziesNummer.Nummer <= LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitenauswahlExtern.SpeziesNummer.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitenauswahlExtern.SpeziesNummer.Spezies) = SpeziesDatentypen.Mensch_Spieler_Enum
               and
                 EinheitenauswahlExtern.Koordinaten.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 EinheitenauswahlExtern.Koordinaten.XAchse <= LeseWeltkarteneinstellungen.XAchse
               and
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
   
   FeldeinheitID : EinheitenDatentypen.EinheitenIDMitNullWert;
      
   EinheitSpeziesNummer : EinheitenRecords.SpeziesEinheitnummerRecord;
   
   StartzeitBlinkintervall : Time := Clock;
            
   procedure Einheitenmarkierung
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      EinheitenauswahlExtern : in EinheitenGrafikRecords.EinheitGrafikRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
     with
       Pre => (
                 EinheitenauswahlExtern.SpeziesNummer.Nummer <= LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitenauswahlExtern.SpeziesNummer.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitenauswahlExtern.SpeziesNummer.Spezies) = SpeziesDatentypen.Mensch_Spieler_Enum
               and
                 EinheitenauswahlExtern.Koordinaten.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 EinheitenauswahlExtern.Koordinaten.XAchse <= LeseWeltkarteneinstellungen.XAchse
               and
                 KoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
               and
                 PositionExtern.x >= 0.00
               and
                 PositionExtern.y >= 0.00
              );
   
   
   
   function EinheitAnzeigen
     return Boolean;

end WeltkarteEinheitZeichnenGrafik;

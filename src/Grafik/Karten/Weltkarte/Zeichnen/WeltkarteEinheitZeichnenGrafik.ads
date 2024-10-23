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
   use type KartenDatentypen.Senkrechte;
   use type KartenDatentypen.Waagerechte;
   use type EinheitenDatentypen.Einheitenbereich;
   use type SpeziesDatentypen.Spieler_Enum;

   procedure AnzeigeEinheit
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      EinheitenauswahlExtern : in EinheitenGrafikRecords.EinheitGrafikRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
     with
       Pre => (
                 EinheitenauswahlExtern.SpeziesNummer.Nummer <= LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitenauswahlExtern.SpeziesNummer.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitenauswahlExtern.SpeziesNummer.Spezies) = SpeziesDatentypen.Mensch_Spieler_Enum
               and
                 EinheitenauswahlExtern.Koordinaten.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 EinheitenauswahlExtern.Koordinaten.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
               and
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
               and
                 PositionExtern.x >= 0.00
               and
                 PositionExtern.y >= 0.00
              );
   
   procedure AnzeigeBewegungsfeld
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
               and
                 PositionExtern.x >= 0.00
               and
                 PositionExtern.y >= 0.00
              );
  
private
   
   AusgewählteEinheitAnzeigen : Boolean := True;
   
   FeldeinheitID : EinheitenDatentypen.EinheitenID;
      
   EinheitSpeziesNummer : EinheitenRecords.SpeziesEinheitnummerRecord;
   
   StartzeitBlinkintervall : Time := Clock;
            
   procedure Einheitenmarkierung
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      EinheitenauswahlExtern : in EinheitenGrafikRecords.EinheitGrafikRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
     with
       Pre => (
                 EinheitenauswahlExtern.SpeziesNummer.Nummer <= LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitenauswahlExtern.SpeziesNummer.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitenauswahlExtern.SpeziesNummer.Spezies) = SpeziesDatentypen.Mensch_Spieler_Enum
               and
                 EinheitenauswahlExtern.Koordinaten.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 EinheitenauswahlExtern.Koordinaten.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
               and
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
               and
                 PositionExtern.x >= 0.00
               and
                 PositionExtern.y >= 0.00
              );
   
   
   
   function EinheitAnzeigen
     return Boolean;

end WeltkarteEinheitZeichnenGrafik;

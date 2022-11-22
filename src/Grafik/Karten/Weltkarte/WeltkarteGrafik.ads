private with Sf;
private with Sf.System.Vector2;

with RassenDatentypen;
with EinheitenRecords;

private with KartenRecords;
private with KartenDatentypen;

with LeseRassenbelegung;

private with LeseWeltkarteneinstellungen;

package WeltkarteGrafik is
   pragma Elaborate_Body;
   use type RassenDatentypen.Spieler_Enum;
   
   procedure WeltkarteAnzeigen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
     with
       Pre => (
                 LeseRassenbelegung.Belegung (RasseExtern => EinheitRasseNummerExtern.Rasse) = RassenDatentypen.Mensch_Spieler_Enum
              );
   
private
   use type KartenDatentypen.Kartenfeld;
   
   Transparents : Sf.sfUint8;
   
   Sichtbereich : KartenDatentypen.KartenfeldPositiv;
      
   Feldposition : Sf.System.Vector2.sfVector2f;
   
   KartenWert : KartenRecords.AchsenKartenfeldNaturalRecord;
   CursorKoordinatenAlt : KartenRecords.AchsenKartenfeldNaturalRecord;
   AktuelleKoordinaten : KartenRecords.AchsenKartenfeldNaturalRecord;
         
   procedure IstSichtbar
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
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

end WeltkarteGrafik;

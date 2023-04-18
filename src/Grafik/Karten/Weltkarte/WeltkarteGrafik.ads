private with Sf;
private with Sf.System.Vector2;

with SpeziesDatentypen;
with EinheitenGrafikRecords;
with KartenDatentypen;
with EinheitenDatentypen;

private with KartenRecords;

with LeseSpeziesbelegung;
with LeseGrenzen;
with LeseWeltkarteneinstellungen;

package WeltkarteGrafik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;
   use type KartenDatentypen.Kartenfeld;
   use type EinheitenDatentypen.MaximaleEinheitenMitNullWert;
   
   procedure WeltkarteAnzeigen
     (EinheitenauswahlExtern : in EinheitenGrafikRecords.EinheitGrafikRecord)
     with
       Pre => (
                 EinheitenauswahlExtern.SpeziesNummer.Nummer <= LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitenauswahlExtern.SpeziesNummer.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitenauswahlExtern.SpeziesNummer.Spezies) = SpeziesDatentypen.Mensch_Spieler_Enum
               and
                 EinheitenauswahlExtern.Koordinaten.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 EinheitenauswahlExtern.Koordinaten.XAchse <= LeseWeltkarteneinstellungen.XAchse
              );
   
private
      
   Transparents : Sf.sfUint8;
   
   Sichtbereich : KartenRecords.YXAchsenKartenfeldPositivRecord;
      
   Feldposition : Sf.System.Vector2.sfVector2f;
   
   KartenWert : KartenRecords.AchsenKartenfeldNaturalRecord;
   CursorKoordinatenAlt : KartenRecords.AchsenKartenfeldNaturalRecord;
   AktuelleKoordinaten : KartenRecords.AchsenKartenfeldNaturalRecord;
         
   procedure IstSichtbar
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
   
   procedure EbeneZeichnen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      EinheitenauswahlExtern : in EinheitenGrafikRecords.EinheitGrafikRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f;
      TransparentsExtern : in Sf.sfUint8;
      EbeneExtern : in KartenDatentypen.EbeneVorhanden)
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

end WeltkarteGrafik;

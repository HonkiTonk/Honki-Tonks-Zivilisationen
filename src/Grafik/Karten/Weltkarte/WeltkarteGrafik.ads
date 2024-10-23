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
   use type KartenDatentypen.Senkrechte;
   use type KartenDatentypen.Waagerechte;
   use type EinheitenDatentypen.Einheitenbereich;
   
   procedure WeltkarteAnzeigen
     (EinheitenauswahlExtern : in EinheitenGrafikRecords.EinheitGrafikRecord)
     with
       Pre => (
                 EinheitenauswahlExtern.SpeziesNummer.Nummer <= LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitenauswahlExtern.SpeziesNummer.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitenauswahlExtern.SpeziesNummer.Spezies) = SpeziesDatentypen.Mensch_Spieler_Enum
               and
                 EinheitenauswahlExtern.Koordinaten.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 EinheitenauswahlExtern.Koordinaten.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );
   
private
      
   Transparents : Sf.sfUint8;
   
   Sichtbereich : KartenRecords.KartenfeldumgebungPositivRecord;
      
   Feldposition : Sf.System.Vector2.sfVector2f;
   
   KartenWert : KartenRecords.KartenfeldNaturalRecord;
   ZeigerKoordinatenAlt : KartenRecords.KartenfeldNaturalRecord;
   AktuelleKoordinaten : KartenRecords.KartenfeldNaturalRecord;
         
   procedure IstSichtbar
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
   
   procedure EbeneZeichnen
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
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

end WeltkarteGrafik;

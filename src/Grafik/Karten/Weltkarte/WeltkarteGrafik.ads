private with Sf;
private with Sf.System.Vector2;

with SpeziesDatentypen;
with EinheitenGrafikRecords;
with KartenDatentypen;
with EinheitenDatentypen;
with KartenKonstanten;

private with KartenRecords;

with LeseSpeziesbelegung;
with LeseGrenzen;
with LeseWeltkarteneinstellungen;

package WeltkarteGrafik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;
   use type KartenDatentypen.SenkrechteBasis;
   use type KartenDatentypen.WaagerechteBasis;
   use type EinheitenDatentypen.EinheitenbereichBasis;
   use type KartenDatentypen.EbeneBasis;
   
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
               and
                 (EinheitenauswahlExtern.Koordinaten.Ebene in LeseWeltkarteneinstellungen.EbeneAnfang .. LeseWeltkarteneinstellungen.EbeneEnde
                  or
                    EinheitenauswahlExtern.Koordinaten.Ebene = KartenKonstanten.LeerEbene)
              );
   
private
   
   Transparents : Sf.sfUint8;
   
   Stadtnamenposition : Natural;
   
   Sichtbereich : KartenRecords.KartenfeldumgebungPositivRecord;
      
   Feldposition : Sf.System.Vector2.sfVector2f;
   
   KartenWert : KartenRecords.KartenfeldNaturalRecord;
   ZeigerKoordinatenAlt : KartenRecords.KartenfeldNaturalRecord;
   AktuelleKoordinaten : KartenRecords.KartenfeldNaturalRecord;
   
   -- Die Sichtbarkeit unten drunter hier nicht mit einbauen, aber eventuell später dennoch einen Knopf dafür haben? äöü
   type Weltkarte_Anzeige_Enum is (
                                   Basisgrund_Enum, Zusatzgrund_Enum, Fluss_Enum, Ressourcen_Enum, Weg_Enum, Verbesserungen_Enum,
                                   Stadtnamen_Enum, Feldbesitzer_Enum, Feldeffekte_Enum, Einheit_Enum, Bewegungsfeld_Enum
                                  );
   
   type AnzeigeArray is array (Weltkarte_Anzeige_Enum'Range) of Boolean;
   Anzeige : AnzeigeArray := (others => True);
         
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
                 (EinheitenauswahlExtern.Koordinaten.Ebene in LeseWeltkarteneinstellungen.EbeneAnfang .. LeseWeltkarteneinstellungen.EbeneEnde
                  or
                    EinheitenauswahlExtern.Koordinaten.Ebene = KartenKonstanten.LeerEbene)
               and
                 PositionExtern.x >= 0.00
               and
                 PositionExtern.y >= 0.00
              );
   
   procedure EbeneZeichnen
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      EinheitenauswahlExtern : in EinheitenGrafikRecords.EinheitGrafikRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f;
      TransparentsExtern : in Sf.sfUint8)
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
                 (EinheitenauswahlExtern.Koordinaten.Ebene in LeseWeltkarteneinstellungen.EbeneAnfang .. LeseWeltkarteneinstellungen.EbeneEnde
                  or
                    EinheitenauswahlExtern.Koordinaten.Ebene = KartenKonstanten.LeerEbene)
               and
                 PositionExtern.x >= 0.00
               and
                 PositionExtern.y >= 0.00
              );
   
   procedure Stadtnamen
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) = SpeziesDatentypen.Mensch_Spieler_Enum
              );

end WeltkarteGrafik;

with SpeziesDatentypen;
with EinheitenRecords;
with EinheitenKonstanten;

private with BefehleDatentypen;
private with KartenRecords;
private with EinheitenDatentypen;
private with KartenRecordKonstanten;

with LeseGrenzen;
with LeseSpeziesbelegung;

package EinheitenkontrollsystemLogik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;

   procedure Einheitenkontrolle
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) = SpeziesDatentypen.Mensch_Spieler_Enum
              );
   
private
      
   Mausbefehl : BefehleDatentypen.Einheitenbelegung_Enum;
   
   Bewegungspunkte : EinheitenDatentypen.BewegungspunkteVorhanden;
   NeueBewegungspunkte : EinheitenDatentypen.BewegungspunkteVorhanden;
   AktuelleBewegungspunkte : EinheitenDatentypen.BewegungspunkteVorhanden;
   
   KartenWert : KartenRecords.KartenfeldNaturalRecord;
   Bewegungsschritt : KartenRecords.KartenfeldNaturalRecord;
   
   type RichtungArray is array (BefehleDatentypen.Einheiten_Bewegung_Enum'Range) of KartenRecords.KartenfeldRecord;
   Richtung : constant RichtungArray := (
                                         BefehleDatentypen.Oben_Enum         => KartenRecordKonstanten.Nordbewegung,
                                         BefehleDatentypen.Links_Enum        => KartenRecordKonstanten.Westbewegung,
                                         BefehleDatentypen.Unten_Enum        => KartenRecordKonstanten.Südbewegung,
                                         BefehleDatentypen.Rechts_Enum       => KartenRecordKonstanten.OstBewegung,
                                         BefehleDatentypen.Links_Oben_Enum   => KartenRecordKonstanten.Nordwestbewegung,
                                         BefehleDatentypen.Rechts_Oben_Enum  => KartenRecordKonstanten.Nordostbewegung,
                                         BefehleDatentypen.Links_Unten_Enum  => KartenRecordKonstanten.Südwestbewegung,
                                         BefehleDatentypen.Rechts_Unten_Enum => KartenRecordKonstanten.Südostbewegung,
                                         
                                         BefehleDatentypen.Ebene_Hoch_Enum   => KartenRecordKonstanten.EbeneHoch,
                                         BefehleDatentypen.Ebene_Runter_Enum => KartenRecordKonstanten.EbeneRunter
                                        );
   
   
   
   function EinheitBefehle
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      BefehlExtern : in BefehleDatentypen.Einheitenbelegung_Enum)
      return Boolean
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) = SpeziesDatentypen.Mensch_Spieler_Enum
              );
   
   function BefehleMaus
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return Boolean
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) = SpeziesDatentypen.Mensch_Spieler_Enum
              );

end EinheitenkontrollsystemLogik;

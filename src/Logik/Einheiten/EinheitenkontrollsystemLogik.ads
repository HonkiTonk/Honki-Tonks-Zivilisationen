with SpeziesDatentypen;
with EinheitenRecords;
with EinheitenKonstanten;

private with BefehleDatentypen;
private with KartenDatentypen;
private with KartenRecords;
private with EinheitenDatentypen;

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
   use type KartenDatentypen.Kartenfeld;
   use type KartenDatentypen.Ebene;
      
   Mausbefehl : BefehleDatentypen.Einheitenbelegung_Enum;
   
   Bewegungspunkte : EinheitenDatentypen.VorhandeneBewegungspunkte;
   NeueBewegungspunkte : EinheitenDatentypen.VorhandeneBewegungspunkte;
   AktuelleBewegungspunkte : EinheitenDatentypen.VorhandeneBewegungspunkte;
   
   KartenWert : KartenRecords.AchsenKartenfeldNaturalRecord;
   Bewegungsschritt : KartenRecords.AchsenKartenfeldNaturalRecord;
   
   type RichtungArray is array (BefehleDatentypen.Einheiten_Bewegung_Enum'Range) of KartenRecords.AchsenKartenfeldRecord;
   Richtung : constant RichtungArray := (
                                         BefehleDatentypen.Oben_Enum         => (0, -1, 0),
                                         BefehleDatentypen.Links_Enum        => (0, 0, -1),
                                         BefehleDatentypen.Unten_Enum        => (0, 1, 0),
                                         BefehleDatentypen.Rechts_Enum       => (0, 0, 1),
                                         BefehleDatentypen.Links_Oben_Enum   => (0, -1, -1),
                                         BefehleDatentypen.Rechts_Oben_Enum  => (0, -1, 1),
                                         BefehleDatentypen.Links_Unten_Enum  => (0, 1, -1),
                                         BefehleDatentypen.Rechts_Unten_Enum => (0, 1, 1),
                                         BefehleDatentypen.Ebene_Hoch_Enum   => (1, 0, 0),
                                         BefehleDatentypen.Ebene_Runter_Enum => (-1, 0, 0)
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

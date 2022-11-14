with RassenDatentypen;
with EinheitenRecords;
with SpielVariablen;

private with BefehleDatentypen;
private with KartenDatentypen;
private with KartenRecords;

package EinheitenkontrollsystemLogik is
   pragma Elaborate_Body;
   use type RassenDatentypen.Spieler_Enum;

   procedure Einheitenkontrolle
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
               and
                 SpielVariablen.Rassenbelegung (EinheitRasseNummerExtern.Rasse).Belegung = RassenDatentypen.Mensch_Spieler_Enum
              );
   
private
   use type KartenDatentypen.Kartenfeld;
   use type KartenDatentypen.Ebene;
      
   Mausbefehl : BefehleDatentypen.Einheitenbelegung_Enum;
   
   KartenWert : KartenRecords.AchsenKartenfeldNaturalRecord;
   EinheitenKoordinaten : KartenRecords.AchsenKartenfeldNaturalRecord;
   
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
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      BefehlExtern : in BefehleDatentypen.Einheitenbelegung_Enum)
      return Boolean
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
               and
                 SpielVariablen.Rassenbelegung (EinheitRasseNummerExtern.Rasse).Belegung = RassenDatentypen.Mensch_Spieler_Enum
              );
   
   function BefehleMaus
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
               and
                 SpielVariablen.Rassenbelegung (EinheitRasseNummerExtern.Rasse).Belegung = RassenDatentypen.Mensch_Spieler_Enum
              );
   
   function AllgemeineEinheitenbewegungMaus
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
               and
                 SpielVariablen.Rassenbelegung (EinheitRasseNummerExtern.Rasse).Belegung = RassenDatentypen.Mensch_Spieler_Enum
              );
   
   function EinheitenbewegungMaus
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
               and
                 SpielVariablen.Rassenbelegung (EinheitRasseNummerExtern.Rasse).Belegung = RassenDatentypen.Mensch_Spieler_Enum
              );

end EinheitenkontrollsystemLogik;

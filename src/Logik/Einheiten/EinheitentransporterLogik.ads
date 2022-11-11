with RassenDatentypen; use RassenDatentypen;
with KartenDatentypen; use KartenDatentypen;
with SpielVariablen;
with EinheitenRecords;

private with EinheitenDatentypen;
private with Weltkarte;
private with KartenRecords;

package EinheitentransporterLogik is
   pragma Elaborate_Body;
   
   procedure TransporterEntladen
     (TransporterExtern : in EinheitenRecords.RasseEinheitnummerRecord)
     with
       Pre => (
                 TransporterExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (TransporterExtern.Rasse).Einheitengrenze
               and
                 SpielVariablen.Rassenbelegung (TransporterExtern.Rasse).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );
   
   function KannTransportiertWerden
     (LadungExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      TransporterExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
     with
       Pre => (
                 LadungExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (LadungExtern.Rasse).Einheitengrenze
               and
                 SpielVariablen.Rassenbelegung (LadungExtern.Rasse).Belegung /= RassenDatentypen.Leer_Spieler_Enum
               and
                 TransporterExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (TransporterExtern.Rasse).Einheitengrenze
               and
                 SpielVariablen.Rassenbelegung (TransporterExtern.Rasse).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );
   
private
   
   Transporterkapazität : EinheitenDatentypen.Transportplätze;
   
   TransporterID : EinheitenDatentypen.EinheitenIDMitNullWert;
   LadungID : EinheitenDatentypen.EinheitenIDMitNullWert;
   
   AktuelleLadung : EinheitenDatentypen.MaximaleEinheitenMitNullWert;
   
   EinheitVorhanden : EinheitenRecords.RasseEinheitnummerRecord;
   
   TransporterKoordinaten : KartenRecords.AchsenKartenfeldNaturalRecord;
   KartenWert : KartenRecords.AchsenKartenfeldNaturalRecord;
   
   procedure TransporterUmgebung
     (TranspoterKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      LadungExtern : in EinheitenRecords.RasseEinheitnummerRecord)
     with
       Pre => (
                 LadungExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (LadungExtern.Rasse).Einheitengrenze
               and
                 SpielVariablen.Rassenbelegung (LadungExtern.Rasse).Belegung /= RassenDatentypen.Leer_Spieler_Enum
               and
                 TranspoterKoordinatenExtern.YAchse <= Weltkarte.Karteneinstellungen.Kartengröße.YAchse
               and
                 TranspoterKoordinatenExtern.XAchse <= Weltkarte.Karteneinstellungen.Kartengröße.XAchse
              );
   
   
   
   function Entladung
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      LadungExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
     with
       Pre => (
                 LadungExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (LadungExtern.Rasse).Einheitengrenze
               and
                 SpielVariablen.Rassenbelegung (LadungExtern.Rasse).Belegung /= RassenDatentypen.Leer_Spieler_Enum
               and
                 KoordinatenExtern.YAchse <= Weltkarte.Karteneinstellungen.Kartengröße.YAchse
               and
                 KoordinatenExtern.XAchse <= Weltkarte.Karteneinstellungen.Kartengröße.XAchse
              );

end EinheitentransporterLogik;

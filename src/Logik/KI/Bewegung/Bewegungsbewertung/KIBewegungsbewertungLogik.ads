with RassenDatentypen; use RassenDatentypen;
with KartenDatentypen; use KartenDatentypen;
with SpielVariablen;
with EinheitenRecords;
with KartenRecords;
with Weltkarte;

with KIDatentypen;

package KIBewegungsbewertungLogik is
   pragma Elaborate_Body;

   function Positionsbewertung
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      AktuelleKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      NeueKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return KIDatentypen.BewegungBewertung
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
               and
                 AktuelleKoordinatenExtern.YAchse <= Weltkarte.Karteneinstellungen.Kartengröße.YAchse
               and
                 AktuelleKoordinatenExtern.XAchse <= Weltkarte.Karteneinstellungen.Kartengröße.XAchse
               and
                 NeueKoordinatenExtern.YAchse <= Weltkarte.Karteneinstellungen.Kartengröße.YAchse
               and
                 NeueKoordinatenExtern.XAchse <= Weltkarte.Karteneinstellungen.Kartengröße.XAchse
               and
                 SpielVariablen.Rassenbelegung (EinheitRasseNummerExtern.Rasse).Belegung = RassenDatentypen.KI_Spieler_Enum
              );
   
private
   
   BewertungEAchse : KIDatentypen.Achsenbewertung;
   BewertungYAchse : KIDatentypen.Achsenbewertung;
   BewertungXAchse : KIDatentypen.Achsenbewertung;
   
   Zielkoordinate : KartenRecords.AchsenKartenfeldNaturalRecord;
   
end KIBewegungsbewertungLogik;

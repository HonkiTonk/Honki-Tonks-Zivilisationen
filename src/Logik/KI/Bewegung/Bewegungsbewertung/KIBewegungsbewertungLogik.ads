with RassenDatentypen;
with KartenDatentypen; 
with SpielVariablen;
with EinheitenRecords;
with KartenRecords;

with LeseWeltkarteneinstellungen;

with KIDatentypen;

package KIBewegungsbewertungLogik is
   pragma Elaborate_Body;
   use type RassenDatentypen.Spieler_Enum;
   use type KartenDatentypen.Kartenfeld;

   function Positionsbewertung
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      AktuelleKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      NeueKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return KIDatentypen.BewegungBewertung
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
               and
                 AktuelleKoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 AktuelleKoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
               and
                 NeueKoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 NeueKoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
               and
                 SpielVariablen.Rassenbelegung (EinheitRasseNummerExtern.Rasse).Belegung = RassenDatentypen.KI_Spieler_Enum
              );
   
private
   
   BewertungEAchse : KIDatentypen.Achsenbewertung;
   BewertungYAchse : KIDatentypen.Achsenbewertung;
   BewertungXAchse : KIDatentypen.Achsenbewertung;
   
   Zielkoordinate : KartenRecords.AchsenKartenfeldNaturalRecord;
   
end KIBewegungsbewertungLogik;

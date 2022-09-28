pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RassenDatentypen; use RassenDatentypen;
with Weltkarte;
with KartenRecords;
with SpielVariablen;
with KartenDatentypen;

package QuadrantenberechnungenLogik is

   procedure QuadrantenDurchlaufen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      SichtweiteExtern : in KartenDatentypen.Sichtweite;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
     with
       Pre => (
                 KoordinatenExtern.YAchse in Weltkarte.KarteArray'First (2) .. Weltkarte.Karteneinstellungen.Kartengröße.YAchse
               and
                 KoordinatenExtern.XAchse in Weltkarte.KarteArray'First (3) .. Weltkarte.Karteneinstellungen.Kartengröße.XAchse
               and
                 SpielVariablen.Rassenbelegung (RasseExtern).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );
   
private
   
   KartenQuadrantWert : KartenRecords.AchsenKartenfeldNaturalRecord;
   
   procedure QuadrantEins
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      SichtweiteYRichtungExtern : in KartenDatentypen.SichtweiteNatural;
      SichtweiteXRichtungExtern : in KartenDatentypen.SichtweiteNatural;
      SichtweiteExtern : in KartenDatentypen.Sichtweite;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
     with
       Pre => (
                 KoordinatenExtern.YAchse in Weltkarte.KarteArray'First (2) .. Weltkarte.Karteneinstellungen.Kartengröße.YAchse
               and
                 KoordinatenExtern.XAchse in Weltkarte.KarteArray'First (3) .. Weltkarte.Karteneinstellungen.Kartengröße.XAchse
               and
                 SpielVariablen.Rassenbelegung (RasseExtern).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );

   procedure QuadrantZwei
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      SichtweiteYRichtungExtern : in KartenDatentypen.SichtweiteNatural;
      SichtweiteXRichtungExtern : in KartenDatentypen.SichtweiteNatural;
      SichtweiteExtern : in KartenDatentypen.Sichtweite;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
     with
       Pre => (
                 KoordinatenExtern.YAchse in Weltkarte.KarteArray'First (2) .. Weltkarte.Karteneinstellungen.Kartengröße.YAchse
               and
                 KoordinatenExtern.XAchse in Weltkarte.KarteArray'First (3) .. Weltkarte.Karteneinstellungen.Kartengröße.XAchse
               and
                 SpielVariablen.Rassenbelegung (RasseExtern).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );

   procedure QuadrantDrei
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      SichtweiteYRichtungExtern : in KartenDatentypen.SichtweiteNatural;
      SichtweiteXRichtungExtern : in KartenDatentypen.SichtweiteNatural;
      SichtweiteExtern : in KartenDatentypen.Sichtweite;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
     with
       Pre => (
                 KoordinatenExtern.YAchse in Weltkarte.KarteArray'First (2) .. Weltkarte.Karteneinstellungen.Kartengröße.YAchse
               and
                 KoordinatenExtern.XAchse in Weltkarte.KarteArray'First (3) .. Weltkarte.Karteneinstellungen.Kartengröße.XAchse
               and
                 SpielVariablen.Rassenbelegung (RasseExtern).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );

   procedure QuadrantVier
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      SichtweiteYRichtungExtern : in KartenDatentypen.SichtweiteNatural;
      SichtweiteXRichtungExtern : in KartenDatentypen.SichtweiteNatural;
      SichtweiteExtern : in KartenDatentypen.Sichtweite;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
     with
       Pre => (
                 KoordinatenExtern.YAchse in Weltkarte.KarteArray'First (2) .. Weltkarte.Karteneinstellungen.Kartengröße.YAchse
               and
                 KoordinatenExtern.XAchse in Weltkarte.KarteArray'First (3) .. Weltkarte.Karteneinstellungen.Kartengröße.XAchse
               and
                 SpielVariablen.Rassenbelegung (RasseExtern).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );

end QuadrantenberechnungenLogik;

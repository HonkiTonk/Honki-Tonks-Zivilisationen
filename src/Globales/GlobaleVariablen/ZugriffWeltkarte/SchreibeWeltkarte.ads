with KartenDatentypen;
with RassenDatentypen;
with KartenverbesserungDatentypen;
with KartengrundDatentypen;
with KartenRecords;
with EinheitenRecords;
with StadtRecords;
with WeltkarteRecords;

with LeseWeltkarteneinstellungen;
with LeseRassenbelegung;

package SchreibeWeltkarte is
   pragma Elaborate_Body;
   use type RassenDatentypen.Spieler_Enum;
   use type KartenDatentypen.Kartenfeld;
   
   procedure Basisgrund
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      GrundExtern : in KartengrundDatentypen.Basisgrund_Vorhanden_Enum)
     with
       Pre => (
                 KoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
              );

   procedure Zusatzgrund
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      GrundExtern : in KartengrundDatentypen.Zusatzgrund_Enum)
     with
       Pre => (
                 KoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
              );
   
   procedure Gesamtgrund
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      GrundExtern : in KartenRecords.KartengrundRecord)
     with
       Pre => (
                 KoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
              );
   
   procedure Sichtbar
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      SichtbarExtern : in Boolean)
     with
       Pre => (
                 LeseRassenbelegung.Belegung (RasseExtern => RasseExtern) /= RassenDatentypen.Leer_Spieler_Enum
               and
                 KoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
              );

   procedure Fluss
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      FlussExtern : in KartengrundDatentypen.Kartenfluss_Enum)
     with
       Pre => (
                 KoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
              );

   procedure Ressource
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      RessourceExtern : in KartengrundDatentypen.Kartenressourcen_Enum)
     with
       Pre => (
                 KoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
              );

   procedure Weg
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      WegExtern : in KartenverbesserungDatentypen.Karten_Weg_Enum)
     with
       Pre => (
                 KoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
              );

   procedure Verbesserung
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      VerbesserungExtern : in KartenverbesserungDatentypen.Karten_Verbesserung_Enum)
     with
       Pre => (
                 KoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
              );

   procedure BelegterGrund
     (KoordinatenExtern : KartenRecords.AchsenKartenfeldNaturalRecord;
      BelegterGrundExtern : in StadtRecords.RasseStadtnummerRecord)
     with
       Pre => (
                 KoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
              );
   
   procedure EinheitSchreiben
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      EinheitentauschExtern : in Boolean)
     with
       Pre => (
                 KoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
              );
   
   procedure EinheitEntfernen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
     with
       Pre => (
                 KoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
              );
   
   procedure GanzerEintrag
     (EintrageExtern : in WeltkarteRecords.WeltkarteRecord;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldVorhandenRecord);
   
   procedure Standardeinstellungen;
   
end SchreibeWeltkarte;

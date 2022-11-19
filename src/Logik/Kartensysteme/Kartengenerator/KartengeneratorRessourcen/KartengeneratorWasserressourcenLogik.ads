with KartenDatentypen;
with KartenRecords;

private with KartengrundDatentypen;
private with SystemDatentypen;

with LeseWeltkarteneinstellungen;

package KartengeneratorWasserressourcenLogik is
   pragma Elaborate_Body;
   use type KartenDatentypen.Kartenfeld;

   procedure KartengeneratorWasserressourcen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldVorhandenRecord)
     with
       Pre => (
                 KoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
              );

private

   WelcheRessource : KartengrundDatentypen.Kartenressourcen_Enum;

   type KartenressourceWahrscheinlichkeitArray is array (KartengrundDatentypen.Kartenressourcen_Oberfläche_Wasser_Enum'Range) of SystemDatentypen.NullBisHundert;
   KartenressourceWahrscheinlichkeit : KartenressourceWahrscheinlichkeitArray := (
                                                                                  KartengrundDatentypen.Fisch_Enum => 2,
                                                                                  KartengrundDatentypen.Wal_Enum   => 2
                                                                                 );
   GezogeneZahlen : KartenressourceWahrscheinlichkeitArray;

   type WelcheMöglichkeitenArray is array (KartenressourceWahrscheinlichkeitArray'Range) of Boolean;
   WelcheMöglichkeiten : WelcheMöglichkeitenArray;



   function RessourceZusatzberechnungen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldVorhandenRecord;
      RessourceExtern : in KartengrundDatentypen.Kartenressourcen_Oberfläche_Wasser_Enum)
      return KartengrundDatentypen.Kartenressourcen_Enum
     with
       Pre => (
                 KoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
              );

   function ZusatzberechnungFisch
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldVorhandenRecord;
      RessourceExtern : in KartengrundDatentypen.Kartenressourcen_Oberfläche_Wasser_Enum)
      return KartengrundDatentypen.Kartenressourcen_Enum
     with
       Pre => (
                 KoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
              );

   function ZusatzberechnungWal
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldVorhandenRecord;
      RessourceExtern : in KartengrundDatentypen.Kartenressourcen_Oberfläche_Wasser_Enum)
      return KartengrundDatentypen.Kartenressourcen_Enum
     with
       Pre => (
                 KoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
              );

end KartengeneratorWasserressourcenLogik;

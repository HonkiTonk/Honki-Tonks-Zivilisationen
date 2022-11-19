with KartenDatentypen;
with KartenRecords;

private with KartengrundDatentypen;
private with SystemDatentypen;

with LeseWeltkarteneinstellungen;

package KartengeneratorWasserweltLogik is
   pragma Elaborate_Body;
   use type KartenDatentypen.Kartenfeld;

   procedure KartengeneratorWasserwelt
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldVorhandenRecord)
     with
       Pre => (
                 KoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
              );
   
private
         
   Zusatzgrund : KartengrundDatentypen.Zusatzgrund_Enum;
   
   type ZusatzWahrscheinlichkeitenArray is array (KartengrundDatentypen.Zusatzgrund_Unterfläche_Enum'Range) of SystemDatentypen.NullBisHundert;
   ZusatzWahrscheinlichkeiten : ZusatzWahrscheinlichkeitenArray := (
                                                                    KartengrundDatentypen.Korallen_Enum    => 30,
                                                                    KartengrundDatentypen.Unterwald_Enum   => 30
                                                                   );
   ZusatzZahlen : ZusatzWahrscheinlichkeitenArray;
   
   type ZusatzMöglichkeitenArray is array (ZusatzWahrscheinlichkeitenArray'Range) of Boolean;
   ZusatzMöglichkeiten : ZusatzMöglichkeitenArray;
   
   procedure BasisgrundBestimmen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldVorhandenRecord)
     with
       Pre => (
                 KoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
              );
     
   procedure ZusatzgrundBestimmen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldVorhandenRecord)
     with
       Pre => (
                 KoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
              );
   
   
   
   function BasisExtraberechnungen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldVorhandenRecord;
      GrundExtern : in KartengrundDatentypen.Basisgrund_Unterfläche_Wasser_Enum)
      return KartengrundDatentypen.Basisgrund_Unterfläche_Wasser_Enum
     with
       Pre => (
                 KoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
              );
         
   function ZusatzExtraberechnungen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldVorhandenRecord;
      GrundExtern : in KartengrundDatentypen.Zusatzgrund_Unterfläche_Enum)
      return KartengrundDatentypen.Zusatzgrund_Enum
     with
       Pre => (
                 KoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
              );
   
   function ZusatzberechnungMeeresgrund
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldVorhandenRecord;
      GrundExtern : in KartengrundDatentypen.Basisgrund_Unterfläche_Wasser_Enum)
      return KartengrundDatentypen.Basisgrund_Unterfläche_Wasser_Enum
     with
       Pre => (
                 KoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
              );
   
   function ZusatzberechnungKorallen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldVorhandenRecord;
      GrundExtern : in KartengrundDatentypen.Zusatzgrund_Unterfläche_Enum)
      return KartengrundDatentypen.Zusatzgrund_Enum
     with
       Pre => (
                 KoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
              );
   
   function ZusatzberechnungUnterwald
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldVorhandenRecord;
      GrundExtern : in KartengrundDatentypen.Zusatzgrund_Unterfläche_Enum)
      return KartengrundDatentypen.Zusatzgrund_Enum
     with
       Pre => (
                 KoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
              );

end KartengeneratorWasserweltLogik;

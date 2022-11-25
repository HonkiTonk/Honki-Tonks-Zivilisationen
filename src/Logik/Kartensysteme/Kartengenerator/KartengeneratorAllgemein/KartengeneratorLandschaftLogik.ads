private with KartenDatentypen;
private with KartengrundDatentypen;
private with KartenRecords;
private with SystemDatentypen;

private with LeseWeltkarteneinstellungen;

package KartengeneratorLandschaftLogik is
   pragma Elaborate_Body;

   procedure GenerierungLandschaft;

private
   use type KartenDatentypen.Kartenfeld;
   
   Kartenzeitwert : KartenDatentypen.KartenfeldNatural;
      
   Basisgrund : KartengrundDatentypen.Basisgrund_Enum;
   Zusatzgrund : KartengrundDatentypen.Zusatzgrund_Enum;
   
   GezogeneZahl : SystemDatentypen.NullBisHundert;
   Zahlenspeicher : SystemDatentypen.NullBisHundert;
   WelcherGrund : SystemDatentypen.NullBisHundert;
         
   KartenWert : KartenRecords.AchsenKartenfeldNaturalRecord;
   
   type BasisWahrscheinlichkeitenArray is array (SystemDatentypen.EinsBisHundert'First .. 5) of SystemDatentypen.NullBisHundert;
   BasisWahrscheinlichkeiten : BasisWahrscheinlichkeitenArray := (
                                                                  1 => 50,
                                                                  2 => 15,
                                                                  3 => 15,
                                                                  4 => 15,
                                                                  5 => 15
                                                                 );
   
   type ZahlenNachBasisgrundArray is array (BasisWahrscheinlichkeitenArray'Range) of KartengrundDatentypen.Basisgrund_Oberfläche_Land_Enum;
   ZahlenNachBasisgrund : constant ZahlenNachBasisgrundArray := (
                                                                 1 => KartengrundDatentypen.Flachland_Enum,
                                                                 2 => KartengrundDatentypen.Wüste_Enum,
                                                                 3 => KartengrundDatentypen.Tundra_Enum,
                                                                 4 => KartengrundDatentypen.Hügel_Enum,
                                                                 5 => KartengrundDatentypen.Gebirge_Enum
                                                                );
   
   type ZusatzWahrscheinlichkeitenArray is array (SystemDatentypen.EinsBisHundert'First .. 3) of SystemDatentypen.NullBisHundert;
   ZusatzWahrscheinlichkeiten : ZusatzWahrscheinlichkeitenArray := (
                                                                    1 => 40,
                                                                    2 => 30,
                                                                    3 => 30
                                                                   );
   
   type ZahlenNachZusatzgrundArray is array (0 .. ZusatzWahrscheinlichkeitenArray'Last) of KartengrundDatentypen.Zusatzgrund_Enum;
   ZahlenNachZusatzgrund : constant ZahlenNachZusatzgrundArray := (
                                                                   0 => KartengrundDatentypen.Leer_Zusatzgrund_Enum,
                                                                   1 => KartengrundDatentypen.Wald_Enum,
                                                                   2 => KartengrundDatentypen.Dschungel_Enum,
                                                                   3 => KartengrundDatentypen.Sumpf_Enum
                                                                  );
   
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
      GrundExtern : in KartengrundDatentypen.Basisgrund_Oberfläche_Land_Enum)
      return KartengrundDatentypen.Basisgrund_Oberfläche_Land_Enum
     with
       Pre => (
                 KoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
              );
      
   function ZusatzExtraberechnungen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldVorhandenRecord;
      GrundExtern : in KartengrundDatentypen.Zusatzgrund_Oberfläche_Enum)
      return KartengrundDatentypen.Zusatzgrund_Enum
     with
       Pre => (
                 KoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
              );
   
   function ZusatzberechnungTundra
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldVorhandenRecord;
      GrundExtern : in KartengrundDatentypen.Basisgrund_Tundra_Enum)
      return KartengrundDatentypen.Basisgrund_Oberfläche_Land_Enum
     with
       Pre => (
                 KoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
              );
   
   function ZusatzberechnungWüste
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldVorhandenRecord;
      GrundExtern : in KartengrundDatentypen.Basisgrund_Wüste_Enum)
      return KartengrundDatentypen.Basisgrund_Oberfläche_Land_Enum
     with
       Pre => (
                 KoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
              );
   
   function ZusatzberechnungHügel
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldVorhandenRecord;
      GrundExtern : in KartengrundDatentypen.Basisgrund_Hügel_Enum)
      return KartengrundDatentypen.Basisgrund_Oberfläche_Land_Enum
     with
       Pre => (
                 KoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
              );
   
   function ZusatzberechnungGebirge
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldVorhandenRecord;
      GrundExtern : in KartengrundDatentypen.Basisgrund_Gebirge_Enum)
      return KartengrundDatentypen.Basisgrund_Oberfläche_Land_Enum
     with
       Pre =>
         (KoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
          and
            KoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
         );
   
   function ZusatzberechnungFlachland
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldVorhandenRecord;
      GrundExtern : in KartengrundDatentypen.Basisgrund_Flachland_Enum)
      return KartengrundDatentypen.Basisgrund_Oberfläche_Land_Enum
     with
       Pre => (
                 KoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
              );
   
   function ZusatzberechnungWald
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldVorhandenRecord;
      GrundExtern : in KartengrundDatentypen.Zusatzgrund_Wald_Enum)
      return KartengrundDatentypen.Zusatzgrund_Enum
     with
       Pre => (
                 KoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
              );
   
   function ZusatzberechnungDschungel
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldVorhandenRecord;
      GrundExtern : in KartengrundDatentypen.Zusatzgrund_Dschungel_Enum)
      return KartengrundDatentypen.Zusatzgrund_Enum
     with
       Pre => (
                 KoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
              );
   
   function ZusatzberechnungSumpf
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldVorhandenRecord;
      GrundExtern : in KartengrundDatentypen.Zusatzgrund_Sumpf_Enum)
      return KartengrundDatentypen.Zusatzgrund_Enum
     with
       Pre => (
                 KoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
              );

end KartengeneratorLandschaftLogik;

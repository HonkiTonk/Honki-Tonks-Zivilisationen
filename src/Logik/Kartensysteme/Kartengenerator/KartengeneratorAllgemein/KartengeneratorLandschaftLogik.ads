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
   
  -- BasisWahrscheinlichkeitAktuell : KartengrundDatentypen.Basisgrund_Oberfläche_Land_Enum;
   
   Gesamtgrund : KartenRecords.KartengrundRecord;
   
   KartenWert : KartenRecords.AchsenKartenfeldNaturalRecord;
   
   type BasisWahrscheinlichkeitenArray is array (KartengrundDatentypen.Basisgrund_Oberfläche_Land_Enum'Range) of SystemDatentypen.NullBisHundert;
   BasisWahrscheinlichkeiten : BasisWahrscheinlichkeitenArray := (
                                                                  KartengrundDatentypen.Flachland_Enum => 50,
                                                                  KartengrundDatentypen.Wüste_Enum     => 15,
                                                                  KartengrundDatentypen.Hügel_Enum     => 15,
                                                                  KartengrundDatentypen.Gebirge_Enum   => 15,
                                                                  KartengrundDatentypen.Tundra_Enum    => 15
                                                                 );
   
   BasisZahlen : BasisWahrscheinlichkeitenArray;
   
   type BasisMöglichkeitenArray is array (BasisWahrscheinlichkeitenArray'Range) of Boolean;
   BasisMöglichkeiten : BasisMöglichkeitenArray;
   
   
   
   type ZusatzWahrscheinlichkeitenArray is array (KartengrundDatentypen.Zusatzgrund_Oberfläche_Enum'Range) of SystemDatentypen.NullBisHundert;
   ZusatzWahrscheinlichkeiten : ZusatzWahrscheinlichkeitenArray := (
                                                                    KartengrundDatentypen.Wald_Enum      => 40,
                                                                    KartengrundDatentypen.Dschungel_Enum => 30,
                                                                    KartengrundDatentypen.Sumpf_Enum     => 30
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
      GrundExtern : in KartengrundDatentypen.Basisgrund_Oberfläche_Land_Enum)
      return KartengrundDatentypen.Basisgrund_Oberfläche_Land_Enum
     with
       Pre => (
                 KoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
              );
   
   function ZusatzberechnungWüste
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldVorhandenRecord;
      GrundExtern : in KartengrundDatentypen.Basisgrund_Oberfläche_Land_Enum)
      return KartengrundDatentypen.Basisgrund_Oberfläche_Land_Enum
     with
       Pre => (
                 KoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
              );
   
   function ZusatzberechnungHügel
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldVorhandenRecord;
      GrundExtern : in KartengrundDatentypen.Basisgrund_Oberfläche_Land_Enum)
      return KartengrundDatentypen.Basisgrund_Oberfläche_Land_Enum
     with
       Pre => (
                 KoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
              );
   
   function ZusatzberechnungGebirge
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldVorhandenRecord;
      GrundExtern : in KartengrundDatentypen.Basisgrund_Oberfläche_Land_Enum)
      return KartengrundDatentypen.Basisgrund_Oberfläche_Land_Enum
     with
       Pre =>
         (KoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
          and
            KoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
         );
   
   function ZusatzberechnungFlachland
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldVorhandenRecord;
      GrundExtern : in KartengrundDatentypen.Basisgrund_Oberfläche_Land_Enum)
      return KartengrundDatentypen.Basisgrund_Oberfläche_Land_Enum
     with
       Pre => (
                 KoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
              );
   
   function ZusatzberechnungWald
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldVorhandenRecord;
      GrundExtern : in KartengrundDatentypen.Zusatzgrund_Oberfläche_Enum)
      return KartengrundDatentypen.Zusatzgrund_Enum
     with
       Pre => (
                 KoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
              );
   
   function ZusatzberechnungDschungel
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldVorhandenRecord;
      GrundExtern : in KartengrundDatentypen.Zusatzgrund_Oberfläche_Enum)
      return KartengrundDatentypen.Zusatzgrund_Enum
     with
       Pre => (
                 KoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
              );
   
   function ZusatzberechnungSumpf
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldVorhandenRecord;
      GrundExtern : in KartengrundDatentypen.Zusatzgrund_Oberfläche_Enum)
      return KartengrundDatentypen.Zusatzgrund_Enum
     with
       Pre => (
                 KoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
              );

end KartengeneratorLandschaftLogik;

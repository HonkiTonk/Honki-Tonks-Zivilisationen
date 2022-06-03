pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen; use KartenDatentypen;
with KartengrundDatentypen;
with KartenRecords;

with Karten;

package KartengeneratorLandschaft is

   procedure GenerierungLandschaft;

private
   
   KartenWert : KartenRecords.AchsenKartenfeldNaturalRecord;
   
   WelcherGrund : KartengrundDatentypen.Kartengrund_Enum;
   BasisGrund : KartengrundDatentypen.Kartengrund_Oberfläche_Basis_Enum;
   
   BasisWahrscheinlichkeitAktuell : KartengrundDatentypen.Kartengrund_Oberfläche_Enum;
   
   type BasisWahrscheinlichkeitenArray is array (KartengrundDatentypen.Kartengrund_Oberfläche_Basis_Enum'Range) of KartenDatentypen.WahrscheinlichkeitKartengenerator;
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
   
   
   
   type ZusatzWahrscheinlichkeitenArray is array (KartengrundDatentypen.Kartengrund_Oberfläche_Zusatz_Enum'Range) of KartenDatentypen.WahrscheinlichkeitKartengenerator;
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
       Pre =>
         (KoordinatenExtern.YAchse <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse
          and
            KoordinatenExtern.XAchse <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchse);
   
   procedure ZusatzgrundBestimmen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldVorhandenRecord)
     with
       Pre =>
         (KoordinatenExtern.YAchse <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse
          and
            KoordinatenExtern.XAchse <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchse);
   
   
   
   function BasisExtraberechnungen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldVorhandenRecord;
      GrundExtern : in KartengrundDatentypen.Kartengrund_Oberfläche_Basis_Enum)
      return KartengrundDatentypen.Kartengrund_Oberfläche_Basis_Enum
     with
       Pre =>
         (KoordinatenExtern.YAchse <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse
          and
            KoordinatenExtern.XAchse <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchse);
      
   function ZusatzExtraberechnungen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldVorhandenRecord;
      GrundExtern : in KartengrundDatentypen.Kartengrund_Oberfläche_Zusatz_Enum)
      return KartengrundDatentypen.Kartengrund_Enum
     with
       Pre =>
         (KoordinatenExtern.YAchse <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse
          and
            KoordinatenExtern.XAchse <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchse);
   
   function ZusatzberechnungTundra
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldVorhandenRecord;
      GrundExtern : in KartengrundDatentypen.Kartengrund_Oberfläche_Basis_Enum)
      return KartengrundDatentypen.Kartengrund_Oberfläche_Basis_Enum
     with
       Pre =>
         (KoordinatenExtern.YAchse <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse
          and
            KoordinatenExtern.XAchse <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchse);
   
   function ZusatzberechnungWüste
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldVorhandenRecord;
      GrundExtern : in KartengrundDatentypen.Kartengrund_Oberfläche_Basis_Enum)
      return KartengrundDatentypen.Kartengrund_Oberfläche_Basis_Enum
     with
       Pre =>
         (KoordinatenExtern.YAchse <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse
          and
            KoordinatenExtern.XAchse <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchse);
   
   function ZusatzberechnungHügel
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldVorhandenRecord;
      GrundExtern : in KartengrundDatentypen.Kartengrund_Oberfläche_Basis_Enum)
      return KartengrundDatentypen.Kartengrund_Oberfläche_Basis_Enum
     with
       Pre =>
         (KoordinatenExtern.YAchse <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse
          and
            KoordinatenExtern.XAchse <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchse);
   
   function ZusatzberechnungGebirge
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldVorhandenRecord;
      GrundExtern : in KartengrundDatentypen.Kartengrund_Oberfläche_Basis_Enum)
      return KartengrundDatentypen.Kartengrund_Oberfläche_Basis_Enum
     with
       Pre =>
         (KoordinatenExtern.YAchse <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse
          and
            KoordinatenExtern.XAchse <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchse);
   
   function ZusatzberechnungFlachland
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldVorhandenRecord;
      GrundExtern : in KartengrundDatentypen.Kartengrund_Oberfläche_Basis_Enum)
      return KartengrundDatentypen.Kartengrund_Oberfläche_Basis_Enum
     with
       Pre =>
         (KoordinatenExtern.YAchse <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse
          and
            KoordinatenExtern.XAchse <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchse);
   
   function ZusatzberechnungWald
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldVorhandenRecord;
      GrundExtern : in KartengrundDatentypen.Kartengrund_Oberfläche_Zusatz_Enum)
      return KartengrundDatentypen.Kartengrund_Enum
     with
       Pre =>
         (KoordinatenExtern.YAchse <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse
          and
            KoordinatenExtern.XAchse <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchse);
   
   function ZusatzberechnungDschungel
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldVorhandenRecord;
      GrundExtern : in KartengrundDatentypen.Kartengrund_Oberfläche_Zusatz_Enum)
      return KartengrundDatentypen.Kartengrund_Enum
     with
       Pre =>
         (KoordinatenExtern.YAchse <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse
          and
            KoordinatenExtern.XAchse <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchse);
   
   function ZusatzberechnungSumpf
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldVorhandenRecord;
      GrundExtern : in KartengrundDatentypen.Kartengrund_Oberfläche_Zusatz_Enum)
      return KartengrundDatentypen.Kartengrund_Enum
     with
       Pre =>
         (KoordinatenExtern.YAchse <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse
          and
            KoordinatenExtern.XAchse <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchse);

end KartengeneratorLandschaft;

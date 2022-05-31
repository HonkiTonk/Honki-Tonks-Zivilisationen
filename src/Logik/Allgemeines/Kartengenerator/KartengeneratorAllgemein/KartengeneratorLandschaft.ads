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
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      XAchseExtern : in KartenDatentypen.KartenfeldPositiv)
     with
       Pre =>
         (YAchseExtern <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse
          and
            XAchseExtern <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchse);
   
   procedure ZusatzgrundBestimmen
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      XAchseExtern : in KartenDatentypen.KartenfeldPositiv)
     with
       Pre =>
         (YAchseExtern <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse
          and
            XAchseExtern <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchse);
   
   
   
   function BasisExtraberechnungen
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      XAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      GrundExtern : in KartengrundDatentypen.Kartengrund_Oberfläche_Basis_Enum)
      return KartengrundDatentypen.Kartengrund_Oberfläche_Basis_Enum
     with
       Pre =>
         (YAchseExtern <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse
          and
            XAchseExtern <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchse);
      
   function ZusatzExtraberechnungen
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      XAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      GrundExtern : in KartengrundDatentypen.Kartengrund_Oberfläche_Zusatz_Enum)
      return KartengrundDatentypen.Kartengrund_Enum
     with
       Pre =>
         (YAchseExtern <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse
          and
            XAchseExtern <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchse);
   
   function ZusatzberechnungTundra
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      XAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      GrundExtern : in KartengrundDatentypen.Kartengrund_Oberfläche_Basis_Enum)
      return KartengrundDatentypen.Kartengrund_Oberfläche_Basis_Enum
     with
       Pre =>
         (YAchseExtern <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse
          and
            XAchseExtern <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchse);
   
   function ZusatzberechnungWüste
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      XAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      GrundExtern : in KartengrundDatentypen.Kartengrund_Oberfläche_Basis_Enum)
      return KartengrundDatentypen.Kartengrund_Oberfläche_Basis_Enum
     with
       Pre =>
         (YAchseExtern <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse
          and
            XAchseExtern <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchse);
   
   function ZusatzberechnungHügel
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      XAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      GrundExtern : in KartengrundDatentypen.Kartengrund_Oberfläche_Basis_Enum)
      return KartengrundDatentypen.Kartengrund_Oberfläche_Basis_Enum
     with
       Pre =>
         (YAchseExtern <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse
          and
            XAchseExtern <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchse);
   
   function ZusatzberechnungGebirge
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      XAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      GrundExtern : in KartengrundDatentypen.Kartengrund_Oberfläche_Basis_Enum)
      return KartengrundDatentypen.Kartengrund_Oberfläche_Basis_Enum
     with
       Pre =>
         (YAchseExtern <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse
          and
            XAchseExtern <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchse);
   
   function ZusatzberechnungFlachland
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      XAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      GrundExtern : in KartengrundDatentypen.Kartengrund_Oberfläche_Basis_Enum)
      return KartengrundDatentypen.Kartengrund_Oberfläche_Basis_Enum
     with
       Pre =>
         (YAchseExtern <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse
          and
            XAchseExtern <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchse);
   
   function ZusatzberechnungWald
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      XAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      GrundExtern : in KartengrundDatentypen.Kartengrund_Oberfläche_Zusatz_Enum)
      return KartengrundDatentypen.Kartengrund_Enum
     with
       Pre =>
         (YAchseExtern <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse
          and
            XAchseExtern <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchse);
   
   function ZusatzberechnungDschungel
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      XAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      GrundExtern : in KartengrundDatentypen.Kartengrund_Oberfläche_Zusatz_Enum)
      return KartengrundDatentypen.Kartengrund_Enum
     with
       Pre =>
         (YAchseExtern <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse
          and
            XAchseExtern <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchse);
   
   function ZusatzberechnungSumpf
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      XAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      GrundExtern : in KartengrundDatentypen.Kartengrund_Oberfläche_Zusatz_Enum)
      return KartengrundDatentypen.Kartengrund_Enum
     with
       Pre =>
         (YAchseExtern <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse
          and
            XAchseExtern <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchse);

end KartengeneratorLandschaft;

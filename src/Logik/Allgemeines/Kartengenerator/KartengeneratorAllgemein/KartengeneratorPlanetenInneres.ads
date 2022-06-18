pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen; use KartenDatentypen;
with KartengrundDatentypen;
with KartenRecords;
with ZahlenDatentypen;

with Karten;

package KartengeneratorPlaneteninneres is

   procedure Planeteninneres;

private

   YKernanfang : KartenDatentypen.KartenfeldPositiv;
   XKernanfang : KartenDatentypen.KartenfeldPositiv;
   YKernende : KartenDatentypen.KartenfeldPositiv;
   XKernende : KartenDatentypen.KartenfeldPositiv;

   Multiplikator : ZahlenDatentypen.EigenesPositive;

   WelcherGrund : KartengrundDatentypen.Kartengrund_Enum;

   type BasisWahrscheinlichkeitenArray is array (KartengrundDatentypen.Kartengrund_Kernfläche_Fest_Enum'Range) of KartenDatentypen.Auswahlbereich;
   BasisWahrscheinlichkeiten : BasisWahrscheinlichkeitenArray := (
                                                                  KartengrundDatentypen.Ringwoodit_Enum     => 20,
                                                                  KartengrundDatentypen.Majorit_Enum        => 20,
                                                                  KartengrundDatentypen.Perowskit_Enum      => 20,
                                                                  KartengrundDatentypen.Magnesiowüstit_Enum => 20
                                                                 );
   BasisZahlen : BasisWahrscheinlichkeitenArray;

   type BasisMöglichkeitenArray is array (BasisWahrscheinlichkeitenArray'Range) of Boolean;
   BasisMöglichkeiten : BasisMöglichkeitenArray;

   procedure BasisgrundBestimmen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldVorhandenRecord)
     with
       Pre =>
         (KoordinatenExtern.YAchse <= Karten.Karteneinstellungen.Kartengröße.YAchse
          and
            KoordinatenExtern.XAchse <= Karten.Karteneinstellungen.Kartengröße.XAchse);



   function BasisExtraberechnungen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldVorhandenRecord;
      GrundExtern : in KartengrundDatentypen.Kartengrund_Kernfläche_Basis_Enum)
      return KartengrundDatentypen.Kartengrund_Kernfläche_Basis_Enum
     with
       Pre =>
         (KoordinatenExtern.YAchse <= Karten.Karteneinstellungen.Kartengröße.YAchse
          and
            KoordinatenExtern.XAchse <= Karten.Karteneinstellungen.Kartengröße.XAchse);

   function ZusatzberechnungRingwoodit
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldVorhandenRecord;
      GrundExtern : in KartengrundDatentypen.Kartengrund_Kernfläche_Basis_Enum)
      return KartengrundDatentypen.Kartengrund_Kernfläche_Basis_Enum
     with
       Pre =>
         (KoordinatenExtern.YAchse <= Karten.Karteneinstellungen.Kartengröße.YAchse
          and
            KoordinatenExtern.XAchse <= Karten.Karteneinstellungen.Kartengröße.XAchse);



   function ZusatzberechnungMajorit
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldVorhandenRecord;
      GrundExtern : in KartengrundDatentypen.Kartengrund_Kernfläche_Basis_Enum)
      return KartengrundDatentypen.Kartengrund_Kernfläche_Basis_Enum
     with
       Pre =>
         (KoordinatenExtern.YAchse <= Karten.Karteneinstellungen.Kartengröße.YAchse
          and
            KoordinatenExtern.XAchse <= Karten.Karteneinstellungen.Kartengröße.XAchse);



   function ZusatzberechnungPerowskit
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldVorhandenRecord;
      GrundExtern : in KartengrundDatentypen.Kartengrund_Kernfläche_Basis_Enum)
      return KartengrundDatentypen.Kartengrund_Kernfläche_Basis_Enum
     with
       Pre =>
         (KoordinatenExtern.YAchse <= Karten.Karteneinstellungen.Kartengröße.YAchse
          and
            KoordinatenExtern.XAchse <= Karten.Karteneinstellungen.Kartengröße.XAchse);



   function ZusatzberechnungMagnesiowüstit
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldVorhandenRecord;
      GrundExtern : in KartengrundDatentypen.Kartengrund_Kernfläche_Basis_Enum)
      return KartengrundDatentypen.Kartengrund_Kernfläche_Basis_Enum
     with
       Pre =>
         (KoordinatenExtern.YAchse <= Karten.Karteneinstellungen.Kartengröße.YAchse
          and
            KoordinatenExtern.XAchse <= Karten.Karteneinstellungen.Kartengröße.XAchse);

end KartengeneratorPlaneteninneres;

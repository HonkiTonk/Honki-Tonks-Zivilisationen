with KartenDatentypen; use KartenDatentypen;

private with KartengrundDatentypen;
private with KartenRecords;
private with Weltkarte;
private with SystemDatentypen;

package KartengeneratorPlanetenkernLogik is
   pragma Elaborate_Body;

   procedure Planetenkern;

private

   YKernanfang : KartenDatentypen.KartenfeldPositiv;
   XKernanfang : KartenDatentypen.KartenfeldPositiv;
   YKernende : KartenDatentypen.KartenfeldPositiv;
   XKernende : KartenDatentypen.KartenfeldPositiv;

   Kartenzeitwert : KartenDatentypen.KartenfeldNatural;

   WelcherGrund : KartengrundDatentypen.Basisgrund_Enum;

   type BasisWahrscheinlichkeitenArray is array (KartengrundDatentypen.Basisgrund_Kernfläche_Fest_Enum'Range) of SystemDatentypen.NullBisHundert;
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
       Pre => (
                 KoordinatenExtern.YAchse <= Weltkarte.Karteneinstellungen.Kartengröße.YAchse
               and
                 KoordinatenExtern.XAchse <= Weltkarte.Karteneinstellungen.Kartengröße.XAchse
              );



   function BasisExtraberechnungen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldVorhandenRecord;
      GrundExtern : in KartengrundDatentypen.Basisgrund_Kernfläche_Fest_Enum)
      return KartengrundDatentypen.Basisgrund_Kernfläche_Fest_Enum
     with
       Pre => (
                 KoordinatenExtern.YAchse <= Weltkarte.Karteneinstellungen.Kartengröße.YAchse
               and
                 KoordinatenExtern.XAchse <= Weltkarte.Karteneinstellungen.Kartengröße.XAchse
              );

   function ZusatzberechnungRingwoodit
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldVorhandenRecord;
      GrundExtern : in KartengrundDatentypen.Basisgrund_Kernfläche_Fest_Enum)
      return KartengrundDatentypen.Basisgrund_Kernfläche_Fest_Enum
     with
       Pre => (
                 KoordinatenExtern.YAchse <= Weltkarte.Karteneinstellungen.Kartengröße.YAchse
               and
                 KoordinatenExtern.XAchse <= Weltkarte.Karteneinstellungen.Kartengröße.XAchse
              );

   function ZusatzberechnungMajorit
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldVorhandenRecord;
      GrundExtern : in KartengrundDatentypen.Basisgrund_Kernfläche_Fest_Enum)
      return KartengrundDatentypen.Basisgrund_Kernfläche_Fest_Enum
     with
       Pre => (
                 KoordinatenExtern.YAchse <= Weltkarte.Karteneinstellungen.Kartengröße.YAchse
               and
                 KoordinatenExtern.XAchse <= Weltkarte.Karteneinstellungen.Kartengröße.XAchse
              );

   function ZusatzberechnungPerowskit
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldVorhandenRecord;
      GrundExtern : in KartengrundDatentypen.Basisgrund_Kernfläche_Fest_Enum)
      return KartengrundDatentypen.Basisgrund_Kernfläche_Fest_Enum
     with
       Pre => (
                 KoordinatenExtern.YAchse <= Weltkarte.Karteneinstellungen.Kartengröße.YAchse
               and
                 KoordinatenExtern.XAchse <= Weltkarte.Karteneinstellungen.Kartengröße.XAchse
              );

   function ZusatzberechnungMagnesiowüstit
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldVorhandenRecord;
      GrundExtern : in KartengrundDatentypen.Basisgrund_Kernfläche_Fest_Enum)
      return KartengrundDatentypen.Basisgrund_Kernfläche_Fest_Enum
     with
       Pre => (
                 KoordinatenExtern.YAchse <= Weltkarte.Karteneinstellungen.Kartengröße.YAchse
               and
                 KoordinatenExtern.XAchse <= Weltkarte.Karteneinstellungen.Kartengröße.XAchse
              );

end KartengeneratorPlanetenkernLogik;

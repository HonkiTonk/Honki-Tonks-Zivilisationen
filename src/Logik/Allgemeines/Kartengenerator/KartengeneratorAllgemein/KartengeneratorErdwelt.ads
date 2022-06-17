pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen; use KartenDatentypen;
with KartengrundDatentypen;
with KartenRecords;

with Karten;

package KartengeneratorErdwelt is

   procedure KartengeneratorErdwelt
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldVorhandenRecord)
     with
       Pre =>
         (KoordinatenExtern.YAchse <= Karten.Kartenparameter.Kartengröße.YAchse
          and
            KoordinatenExtern.XAchse <= Karten.Kartenparameter.Kartengröße.XAchse);
   
private
      
   NeuerGrund : KartengrundDatentypen.Kartengrund_Enum;
   
   WelcherGrund : KartengrundDatentypen.Kartengrund_Enum;
   
   type BasisWahrscheinlichkeitenArray is array (KartengrundDatentypen.Kartengrund_Unterfläche_Land_Enum'Range) of KartenDatentypen.WahrscheinlichkeitKartengenerator;
   BasisWahrscheinlichkeiten : BasisWahrscheinlichkeitenArray := (
                                                                          KartengrundDatentypen.Erde_Enum       => 30,
                                                                          KartengrundDatentypen.Erdgestein_Enum => 30,
                                                                          KartengrundDatentypen.Sand_Enum       => 30,
                                                                          KartengrundDatentypen.Gestein_Enum    => 30
                                                                         );
   BasisZahlen : BasisWahrscheinlichkeitenArray;
   
   type BasisMöglichkeitenArray is array (BasisWahrscheinlichkeitenArray'Range) of Boolean;
   BasisMöglichkeiten : BasisMöglichkeitenArray;
   
   procedure BasisgrundBestimmen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldVorhandenRecord)
     with
       Pre =>
         (KoordinatenExtern.YAchse <= Karten.Kartenparameter.Kartengröße.YAchse
          and
            KoordinatenExtern.XAchse <= Karten.Kartenparameter.Kartengröße.XAchse);
   
   procedure ZusatzgrundBestimmen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldVorhandenRecord)
     with
       Pre =>
         (KoordinatenExtern.YAchse <= Karten.Kartenparameter.Kartengröße.YAchse
          and
            KoordinatenExtern.XAchse <= Karten.Kartenparameter.Kartengröße.XAchse);
   
   
   
   function BasisExtraberechnungen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldVorhandenRecord;
      GrundExtern : in KartengrundDatentypen.Kartengrund_Unterfläche_Land_Enum)
      return KartengrundDatentypen.Kartengrund_Unterfläche_Land_Enum
     with
       Pre =>
         (KoordinatenExtern.YAchse <= Karten.Kartenparameter.Kartengröße.YAchse
          and
            KoordinatenExtern.XAchse <= Karten.Kartenparameter.Kartengröße.XAchse);
   
   function ZusatzberechnungErde
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldVorhandenRecord;
      GrundExtern : in KartengrundDatentypen.Kartengrund_Unterfläche_Land_Enum)
      return KartengrundDatentypen.Kartengrund_Unterfläche_Land_Enum
     with
       Pre =>
         (KoordinatenExtern.YAchse <= Karten.Kartenparameter.Kartengröße.YAchse
          and
            KoordinatenExtern.XAchse <= Karten.Kartenparameter.Kartengröße.XAchse);
   
   function ZusatzberechnungErdgestein
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldVorhandenRecord;
      GrundExtern : in KartengrundDatentypen.Kartengrund_Unterfläche_Land_Enum)
      return KartengrundDatentypen.Kartengrund_Unterfläche_Land_Enum
     with
       Pre =>
         (KoordinatenExtern.YAchse <= Karten.Kartenparameter.Kartengröße.YAchse
          and
            KoordinatenExtern.XAchse <= Karten.Kartenparameter.Kartengröße.XAchse);
   
   function ZusatzberechnungSand
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldVorhandenRecord;
      GrundExtern : in KartengrundDatentypen.Kartengrund_Unterfläche_Land_Enum)
      return KartengrundDatentypen.Kartengrund_Unterfläche_Land_Enum
     with
       Pre =>
         (KoordinatenExtern.YAchse <= Karten.Kartenparameter.Kartengröße.YAchse
          and
            KoordinatenExtern.XAchse <= Karten.Kartenparameter.Kartengröße.XAchse);
   
   function ZusatzberechnungGestein
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldVorhandenRecord;
      GrundExtern : in KartengrundDatentypen.Kartengrund_Unterfläche_Land_Enum)
      return KartengrundDatentypen.Kartengrund_Unterfläche_Land_Enum
     with
       Pre =>
         (KoordinatenExtern.YAchse <= Karten.Kartenparameter.Kartengröße.YAchse
          and
            KoordinatenExtern.XAchse <= Karten.Kartenparameter.Kartengröße.XAchse);

end KartengeneratorErdwelt;

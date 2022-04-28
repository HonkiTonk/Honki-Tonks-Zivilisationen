pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen; use KartenDatentypen;
with KartengrundDatentypen;

with Karten;

package KartengeneratorErdwelt is

   procedure KartengeneratorErdwelt
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      XAchseExtern : in KartenDatentypen.KartenfeldPositiv);
   
private
      
   NeuerGrund : KartengrundDatentypen.Kartengrund_Unterfläche_Land_Enum;
   ZusatzberechnungenGrund : KartengrundDatentypen.Kartengrund_Unterfläche_Land_Enum;
   
   WelcherGrund : KartengrundDatentypen.Kartengrund_Enum;
   
   type KartengrundWahrscheinlichkeitArray is array (KartengrundDatentypen.Kartengrund_Unterfläche_Land_Enum'Range) of Float;
   KartengrundWahrscheinlichkeit : KartengrundWahrscheinlichkeitArray := (
                                                                          KartengrundDatentypen.Erde_Enum       => 0.30,
                                                                          KartengrundDatentypen.Erdgestein_Enum => 0.30,
                                                                          KartengrundDatentypen.Sand_Enum       => 0.30,
                                                                          KartengrundDatentypen.Gestein_Enum    => 0.30
                                                                         );
   GezogeneZahlen : KartengrundWahrscheinlichkeitArray;
   
   type WelcheMöglichkeitenArray is array (KartengrundWahrscheinlichkeitArray'Range) of Boolean;
   WelcheMöglichkeiten : WelcheMöglichkeitenArray;
   
   
   
   function GrundErneutBestimmen
     (GrundExtern : in KartengrundDatentypen.Kartengrund_Enum)
      return KartengrundDatentypen.Kartengrund_Unterfläche_Land_Enum;
   
   function GrundZusatzberechnungen
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      XAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      GrundExtern : in KartengrundDatentypen.Kartengrund_Unterfläche_Land_Enum)
      return KartengrundDatentypen.Kartengrund_Unterfläche_Land_Enum
     with
       Pre =>
         (YAchseExtern <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse
          and
            XAchseExtern <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchse);
   
   function ZusatzberechnungErde
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      XAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      GrundExtern : in KartengrundDatentypen.Kartengrund_Unterfläche_Land_Enum)
      return KartengrundDatentypen.Kartengrund_Unterfläche_Land_Enum
     with
       Pre =>
         (YAchseExtern <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse
          and
            XAchseExtern <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchse);
   
   function ZusatzberechnungErdgestein
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      XAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      GrundExtern : in KartengrundDatentypen.Kartengrund_Unterfläche_Land_Enum)
      return KartengrundDatentypen.Kartengrund_Unterfläche_Land_Enum
     with
       Pre =>
         (YAchseExtern <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse
          and
            XAchseExtern <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchse);
   
   function ZusatzberechnungSand
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      XAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      GrundExtern : in KartengrundDatentypen.Kartengrund_Unterfläche_Land_Enum)
      return KartengrundDatentypen.Kartengrund_Unterfläche_Land_Enum
     with
       Pre =>
         (YAchseExtern <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse
          and
            XAchseExtern <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchse);
   
   function ZusatzberechnungGestein
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      XAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      GrundExtern : in KartengrundDatentypen.Kartengrund_Unterfläche_Land_Enum)
      return KartengrundDatentypen.Kartengrund_Unterfläche_Land_Enum
     with
       Pre =>
         (YAchseExtern <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse
          and
            XAchseExtern <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchse);

end KartengeneratorErdwelt;

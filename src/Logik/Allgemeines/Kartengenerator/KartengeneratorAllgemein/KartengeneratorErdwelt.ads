pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenGrundDatentypen;
with KartenDatentypen;

package KartengeneratorErdwelt is

   procedure KartengeneratorErdwelt
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      XAchseExtern : in KartenDatentypen.KartenfeldPositiv);
   
private
   
   WelcherGrund : KartenGrundDatentypen.Kartengrund_Enum;
   
   type KartengrundWahrscheinlichkeitArray is array (KartenGrundDatentypen.Kartengrund_Unterirdisch_Generator_Enum'Range) of Float;
   KartengrundWahrscheinlichkeit : KartengrundWahrscheinlichkeitArray := (
                                                                          KartenGrundDatentypen.Erde_Enum       => 0.30,
                                                                          KartenGrundDatentypen.Erdgestein_Enum => 0.30,
                                                                          KartenGrundDatentypen.Sand_Enum       => 0.30,
                                                                          KartenGrundDatentypen.Gestein_Enum    => 0.30
                                                                         );
   GezogeneZahlen : KartengrundWahrscheinlichkeitArray;
   
   type WelcheMöglichkeitenArray is array (KartengrundWahrscheinlichkeitArray'Range) of Boolean;
   WelcheMöglichkeiten : WelcheMöglichkeitenArray;

end KartengeneratorErdwelt;

pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartengrundDatentypen;
with KartenDatentypen;

package KartengeneratorErdwelt is

   procedure KartengeneratorErdwelt
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      XAchseExtern : in KartenDatentypen.KartenfeldPositiv);
   
private
   
   WelcherGrund : KartengrundDatentypen.Kartengrund_Enum;
   
   type KartengrundWahrscheinlichkeitArray is array (KartengrundDatentypen.Kartengrund_Unterirdisch_Generator_Enum'Range) of Float;
   KartengrundWahrscheinlichkeit : KartengrundWahrscheinlichkeitArray := (
                                                                          KartengrundDatentypen.Erde_Enum       => 0.30,
                                                                          KartengrundDatentypen.Erdgestein_Enum => 0.30,
                                                                          KartengrundDatentypen.Sand_Enum       => 0.30,
                                                                          KartengrundDatentypen.Gestein_Enum    => 0.30
                                                                         );
   GezogeneZahlen : KartengrundWahrscheinlichkeitArray;
   
   type WelcheMöglichkeitenArray is array (KartengrundWahrscheinlichkeitArray'Range) of Boolean;
   WelcheMöglichkeiten : WelcheMöglichkeitenArray;

end KartengeneratorErdwelt;

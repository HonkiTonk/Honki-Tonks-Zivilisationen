pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartengrundDatentypen;
with KartenDatentypen;

package KartengeneratorWasserwelt is

   procedure KartengeneratorWasserwelt
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      XAchseExtern : in KartenDatentypen.KartenfeldPositiv);
   
private
   
   WelcherGrund : KartengrundDatentypen.Kartengrund_Enum;
   
   type KartengrundWahrscheinlichkeitArray is array (KartengrundDatentypen.Kartengrund_Unterwasser_Generator_Enum'Range) of Float;
   KartengrundWahrscheinlichkeit : KartengrundWahrscheinlichkeitArray := (
                                                                          KartengrundDatentypen.Korallen_Enum         => 0.30,
                                                                          KartengrundDatentypen.Unterwald_Enum => 0.30
                                                                         );
   GezogeneZahlen : KartengrundWahrscheinlichkeitArray;
   
   type WelcheMöglichkeitenArray is array (KartengrundWahrscheinlichkeitArray'Range) of Boolean;
   WelcheMöglichkeiten : WelcheMöglichkeitenArray;

end KartengeneratorWasserwelt;

pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenGrundDatentypen;
with KartenDatentypen;

package KartengeneratorWasserwelt is

   procedure KartengeneratorWasserwelt
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      XAchseExtern : in KartenDatentypen.KartenfeldPositiv);
   
private
   
   WelcherGrund : KartenGrundDatentypen.Kartengrund_Enum;
   
   type KartengrundWahrscheinlichkeitArray is array (KartenGrundDatentypen.Kartengrund_Unterwasser_Generator_Enum'Range) of Float;
   KartengrundWahrscheinlichkeit : KartengrundWahrscheinlichkeitArray := (
                                                                          KartenGrundDatentypen.Korallen_Enum         => 0.30,
                                                                          KartenGrundDatentypen.Unterwald_Enum => 0.30
                                                                         );
   GezogeneZahlen : KartengrundWahrscheinlichkeitArray;
   
   type WelcheMöglichkeitenArray is array (KartengrundWahrscheinlichkeitArray'Range) of Boolean;
   WelcheMöglichkeiten : WelcheMöglichkeitenArray;

end KartengeneratorWasserwelt;

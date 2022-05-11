pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen;
with KartengrundDatentypen;

package KartengeneratorPlaneteninneres is

   procedure Planeteninneres;

private

   YKernanfang : KartenDatentypen.KartenfeldPositiv;
   XKernanfang : KartenDatentypen.KartenfeldPositiv;
   YKernende : KartenDatentypen.KartenfeldPositiv;
   XKernende : KartenDatentypen.KartenfeldPositiv;

   type KartengrundWahrscheinlichkeitArray is array (KartengrundDatentypen.Kartengrund_Kernfläche_Fest_Enum'Range) of KartenDatentypen.WahrscheinlichkeitKartengenerator;
   KartengrundWahrscheinlichkeit : KartengrundWahrscheinlichkeitArray := (
                                                                          KartengrundDatentypen.Ringwoodit_Enum     => 20,
                                                                          KartengrundDatentypen.Majorit_Enum        => 20,
                                                                          KartengrundDatentypen.Perowskit_Enum      => 20,
                                                                          KartengrundDatentypen.Magnesiowüstit_Enum => 20
                                                                         );
   GezogeneZahlen : KartengrundWahrscheinlichkeitArray;

   type WelcheMöglichkeitenArray is array (KartengrundWahrscheinlichkeitArray'Range) of Boolean;
   WelcheMöglichkeiten : WelcheMöglichkeitenArray;

end KartengeneratorPlaneteninneres;

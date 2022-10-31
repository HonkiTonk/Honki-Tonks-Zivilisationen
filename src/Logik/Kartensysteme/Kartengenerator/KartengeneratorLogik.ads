pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

package KartengeneratorLogik is
   pragma Elaborate_Body;

   procedure Kartengenerator;

private

   procedure PrüfeEinstellungen;

end KartengeneratorLogik;

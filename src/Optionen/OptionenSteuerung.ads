pragma SPARK_Mode (On);

package OptionenSteuerung is

   procedure SteuerungBelegen;

   type TastenbelegungArray is array (1 .. 100) of Integer;
   Tastenbelegung : TastenbelegungArray := (others => 0);

end OptionenSteuerung;

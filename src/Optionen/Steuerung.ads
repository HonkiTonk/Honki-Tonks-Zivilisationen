pragma SPARK_Mode (On);

package Steuerung is

   procedure SteuerungBelegen;

   type TastenbelegungArray is array (1 .. 100) of Integer;
   Tastenbelegung : TastenbelegungArray := (others => 0);

end Steuerung;

pragma SPARK_Mode (On);

package Informationen is

   Versionsnummer : constant Wide_Wide_String (1 .. 9) := "0.00.7090"; -- Das Zeug in der adb auch mal in eine externe Datei speichern.

   procedure Informationen
     with
       Global =>
         (Input => Versionsnummer);

end Informationen;

pragma SPARK_Mode (On);

package Informationen is

   -- Cheat.Sichtbar setzt den diplomatischen Zustand aktuell auf Krieg.
   Versionsnummer : constant Wide_Wide_String (1 .. 9) := "0.00.8610";

   procedure Informationen
     with
       Global =>
         (Input => Versionsnummer),
         Depends =>
           (null => Versionsnummer);

end Informationen;

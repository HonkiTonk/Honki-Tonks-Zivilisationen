pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with GrafikDatentypen;

package AbspannLogik is

   procedure Abspann
     (AbspannExtern : in GrafikDatentypen.Abspann_Enum);

end AbspannLogik;

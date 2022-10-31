pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

package KIEinheitFestlegenVerteidigungskriegLogik is
   pragma Elaborate_Body;

   function VerteidigungskriegVorbereiten
     return Boolean;

end KIEinheitFestlegenVerteidigungskriegLogik;

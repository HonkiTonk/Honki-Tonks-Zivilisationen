pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

package KIEinheitFestlegenAngriffskriegLogik is
   pragma Elaborate_Body;

   function AngriffskriegVorbereiten
     return Boolean;

end KIEinheitFestlegenAngriffskriegLogik;

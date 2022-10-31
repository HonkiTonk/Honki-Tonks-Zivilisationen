pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

package JaNeinLogik is
   pragma Elaborate_Body;

   function JaNein
     (FrageZeileExtern : in Positive)
      return Boolean;

private

   AktuelleAuswahl : Natural;

end JaNeinLogik;

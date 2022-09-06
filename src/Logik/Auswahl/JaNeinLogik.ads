pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

package JaNeinLogik is

   function JaNein
     (FrageZeileExtern : in Positive)
      return Boolean;

private

   AktuelleAuswahl : Natural;

end JaNeinLogik;

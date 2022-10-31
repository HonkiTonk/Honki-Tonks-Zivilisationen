pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

package SchreibenVerzeichnisseLogik is
   pragma Elaborate_Body;

   procedure SchreibenVerzeichnisse;

private

   procedure SchreibeSonstigeVerzeichnisse;

end SchreibenVerzeichnisseLogik;

pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

package SchreibenVerzeichnisse is

   procedure SchreibenVerzeichnisse;

private

   procedure SchreibeGrafikVerzeichnisse;
   procedure SchreibeAudioVerzeichnisse;
   procedure SchreibeSonstigeVerzeichnisse;

end SchreibenVerzeichnisse;

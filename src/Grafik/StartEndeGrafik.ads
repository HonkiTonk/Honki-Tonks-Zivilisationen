pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

package StartEndeGrafik is
   pragma Elaborate_Body;
   
   procedure FensterErzeugen;
   procedure FensterEntfernen;

   procedure FensterLeeren;
   procedure FensterAnzeigen;
   
private
   
   procedure FensterErzeugenErweitert;

end StartEndeGrafik;

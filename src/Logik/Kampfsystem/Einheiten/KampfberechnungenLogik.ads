pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KampfDatentypen;

package KampfberechnungenLogik is
   
   function Kampfberechnung
     (AngriffExtern : in KampfDatentypen.Kampfwerte;
      VerteidigungExtern : in KampfDatentypen.Kampfwerte)
      return Integer;
   
private
      
   ErfolgeAngreifer : Natural;
   ErfolgeVerteidiger : Natural;
   
end KampfberechnungenLogik;

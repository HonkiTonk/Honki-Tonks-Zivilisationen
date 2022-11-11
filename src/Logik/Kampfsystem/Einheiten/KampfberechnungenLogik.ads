with KampfDatentypen;

package KampfberechnungenLogik is
   pragma Elaborate_Body;
   
   function Kampfberechnung
     (AngriffExtern : in KampfDatentypen.KampfwerteGroß;
      VerteidigungExtern : in KampfDatentypen.KampfwerteGroß)
      return Integer;
   
private
      
   ErfolgeAngreifer : Natural;
   ErfolgeVerteidiger : Natural;
   
end KampfberechnungenLogik;

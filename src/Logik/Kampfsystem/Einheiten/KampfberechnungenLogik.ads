private with ZufallsgeneratorenHTB6;

with KampfDatentypen;

package KampfberechnungenLogik is
   pragma Elaborate_Body;
   
   function Kampfberechnung
     (AngriffExtern : in KampfDatentypen.Kampfwerte;
      VerteidigungExtern : in KampfDatentypen.Kampfwerte)
      return Integer;
   
private
      
   ErfolgeAngreifer : Natural;
   ErfolgeVerteidiger : Natural;
   
   
   
   function Kampferfolge is new ZufallsgeneratorenHTB6.ErreichteErfolge (GanzeZahl => KampfDatentypen.Kampfwerte);
   
end KampfberechnungenLogik;
